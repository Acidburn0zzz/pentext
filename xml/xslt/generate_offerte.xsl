<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:xlink="http://www.w3.org/1999/xlink"
    xmlns:fo="http://www.w3.org/1999/XSL/Format" xmlns:my="http://www.radical.sexy"
    exclude-result-prefixes="xs my" version="2.0" extension-element-prefixes="my">


    <xsl:import href="pages.xslt"/>
    <xsl:import href="meta.xslt"/>
    <xsl:import href="toc.xslt"/>
    <xsl:import href="structure.xslt"/>
    <xsl:import href="att-set.xslt"/>
    <xsl:import href="block.xslt"/>
    <!--<xsl:import href="findings.xslt"/>-->
    <xsl:import href="auto.xslt"/>
    <xsl:import href="table.xslt"/>
    <xsl:import href="lists.xslt"/>
    <xsl:import href="inline.xslt"/>
    <xsl:import href="graphics.xslt"/>
    <xsl:import href="generic.xslt"/>
    <xsl:import href="numbering.xslt"/>
    <xsl:import href="localisation.xslt"/>
    <xsl:import href="placeholders.xslt"/>
    <xsl:import href="waiver.xslt"/>

    <xsl:include href="styles_off.xslt"/>

    <xsl:output method="xml" version="1.0" encoding="UTF-8" indent="no"/>


    <xsl:param name="AUTO_NUMBERING_FORMAT" select="'1.1.1'"/>
    <xsl:param name="EXEC_SUMMARY" select="false()"/>

    <xsl:key name="rosid" match="section | finding | appendix | non-finding" use="@id"/>
    <xsl:key name="biblioid" match="biblioentry" use="@id"/>

    <!-- not used but needed because of shared code with contract; todo: clean these up -->
    <xsl:variable name="fee" select="/contract/meta/contractor/hourly_fee * 1"/>
    <xsl:variable name="plannedHours" select="/contract/meta/work/planning/hours * 1"/>
    <xsl:variable name="total_fee" select="$fee * $plannedHours"/>
    <!-- end -->

    <xsl:variable name="lang" select="/*/@xml:lang"/>

    <xsl:variable name="CLASSES" select="document('../xslt/styles.xslt')/*/xsl:attribute-set"/>

    <xsl:variable name="latestVersionNumber">
        <xsl:for-each select="//version_history/version">
            <xsl:sort select="xs:dateTime(@date)" order="descending"/>
            <xsl:if test="position() = 1">
                <xsl:call-template name="VersionNumber">
                    <xsl:with-param name="number" select="@number"/>
                </xsl:call-template>
            </xsl:if>
        </xsl:for-each>
    </xsl:variable>

    <xsl:variable name="latestVersionDate">
        <xsl:for-each select="//version_history/version">
            <xsl:sort select="xs:dateTime(@date)" order="descending"/>
            <xsl:if test="position() = 1">
                <xsl:value-of select="format-dateTime(@date, '[MNn] [D1o], [Y]', 'en', (), ())"/>
            </xsl:if>
        </xsl:for-each>
    </xsl:variable>

    <xsl:function name="my:titleCase" as="xs:string">
        <xsl:param name="s" as="xs:string"/>
        <xsl:choose>
            <xsl:when test="lower-case($s) = ('and', 'or')">
                <xsl:value-of select="lower-case($s)"/>
            </xsl:when>
            <xsl:when test="$s = upper-case($s)">
                <xsl:value-of select="$s"/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:value-of
                    select="concat(upper-case(substring($s, 1, 1)), lower-case(substring($s, 2)))"/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:function>


    <!-- ROOT -->
    <xsl:template match="/">
        <fo:root xsl:use-attribute-sets="root-common">
            <xsl:call-template name="layout-master-set"/>
            <xsl:call-template name="FrontMatter"/>
            <xsl:call-template name="Content">
                <xsl:with-param name="execsummary" select="'no'" tunnel="yes"/>
            </xsl:call-template>
        </fo:root>
    </xsl:template>


    <!-- OVERRIDES -->

    <!-- PAGE LAYOUT -->
    <xsl:template name="Content">
        <fo:page-sequence master-reference="Sections">
            <xsl:call-template name="page_header"/>
            <xsl:call-template name="page_footer"/>
            <xsl:call-template name="page_tab"/>
            <fo:flow flow-name="region-body" xsl:use-attribute-sets="DefaultFont">
                <fo:block>
                    <xsl:apply-templates select="offerte"/>
                </fo:block>
                <xsl:if test="not(following-sibling::*)">
                    <fo:block id="EndOfDoc"/>
                </xsl:if>
            </fo:flow>
        </fo:page-sequence>
    </xsl:template>
    
    <xsl:template name="page_tab"/>

    <!-- skip meta in quote; this is handled in FrontMatter -->
    <xsl:template match="meta"/>

    <!-- FRONT PAGE -->
    <xsl:template match="meta" mode="frontmatter">
        <xsl:param name="execsummary" tunnel="yes"/>
        <xsl:variable name="latestVersionNumber">
            <xsl:for-each select="version_history/version">
                <xsl:sort select="xs:dateTime(@date)" order="descending"/>
                <xsl:if test="position() = 1">
                    <xsl:call-template name="VersionNumber">
                        <xsl:with-param name="number" select="@number"/>
                    </xsl:call-template>
                </xsl:if>
            </xsl:for-each>
        </xsl:variable>
        <xsl:variable name="reporttitle">
            <xsl:value-of select="title"/>
        </xsl:variable>
        <xsl:variable name="words" select="tokenize($reporttitle, '\s')"/>

        <fo:block xsl:use-attribute-sets="frontpagetext">
            <fo:block xsl:use-attribute-sets="title-0">
                <xsl:for-each select="$words">
                    <xsl:choose>
                        <xsl:when
                            test="
                                . = 'And' or
                                . = 'and' or
                                . = 'Or' or
                                . = 'or' or
                                . = 'The' or
                                . = 'the' or
                                . = 'Of' or
                                . = 'of' or
                                . = 'A' or
                                . = 'a'">
                            <xsl:text> </xsl:text>
                            <xsl:value-of select="."/>
                        </xsl:when>
                        <xsl:otherwise>
                            <fo:block/>
                            <xsl:value-of select="."/>
                        </xsl:otherwise>
                    </xsl:choose>
                </xsl:for-each>
            </fo:block>
            <fo:block xsl:use-attribute-sets="frontpagesubtitle">
                <xsl:sequence
                    select="
                        string-join(for $x in tokenize(//offered_service_long, ' ')
                        return
                            my:titleCase($x), ' ')"
                />
            </fo:block>
            <fo:block xsl:use-attribute-sets="for">
                <xsl:text>for</xsl:text>
            </fo:block>
            <fo:block xsl:use-attribute-sets="title-client">
                <xsl:value-of select="//client/full_name"/>
            </fo:block>
            <xsl:if test="normalize-space(//client_reference)">
                <fo:block xsl:use-attribute-sets="title-client">
                    <xsl:text>[</xsl:text>
                    <xsl:value-of select="//client_reference"/>
                    <xsl:text>]</xsl:text>
                </fo:block>
            </xsl:if>
            <fo:block xsl:use-attribute-sets="title-date">
                <xsl:value-of select="$latestVersionDate"/>
            </fo:block>
        </fo:block>
    </xsl:template>

    <xsl:template name="cover_footer">
        <fo:static-content flow-name="region-after-cover" xsl:use-attribute-sets="FooterFont">
            <fo:block xsl:use-attribute-sets="footer coverfooter">
                <fo:block>
                    <xsl:value-of select="//meta/company/coc"/>
                </fo:block>
            </fo:block>
        </fo:static-content>
    </xsl:template>

    <!-- TITLES (NO NUMBERING) -->
    <xsl:template match="title">
        <xsl:variable name="LEVEL" select="count(ancestor::*) - 1"/>
        <xsl:variable name="CLASS">
            <xsl:choose>
                <xsl:when test="ancestor::waivers">
                    <!-- Waivers get their own title style -->
                    <xsl:text>title-waiver</xsl:text>
                </xsl:when>
                <xsl:otherwise>
                    <!-- use title-x for all levels -->
                    <xsl:text>title-</xsl:text>
                    <xsl:value-of select="$LEVEL"/>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:variable>


        <fo:block padding-left="2mm">
            <xsl:call-template name="use-att-set">
                <xsl:with-param name="CLASS" select="$CLASS"/>
            </xsl:call-template>
            <xsl:if test="self::title[ancestor::waivers]">
                <fo:inline>
                    <xsl:text>Annex&#160;</xsl:text>
                    <xsl:value-of select="count(//annex) + 1"/>
                    <xsl:text>:&#160;</xsl:text>
                </fo:inline>
            </xsl:if>
            <xsl:apply-templates/>
        </fo:block>

    </xsl:template>

    <!-- CONTACT BOX (comes at the end, is just the address, no title/table) -->
    <xsl:template match="contact">
        <fo:block xsl:use-attribute-sets="Contact">
            <xsl:apply-templates/>
        </fo:block>
    </xsl:template>
    <xsl:template match="contact/name">
        <fo:block>
            <xsl:apply-templates/>
        </fo:block>
    </xsl:template>
    <xsl:template match="contact/phone">
        <fo:block>
            <xsl:apply-templates/>
        </fo:block>
    </xsl:template>
    <xsl:template match="contact/email">
        <fo:block>
            <xsl:apply-templates/>
        </fo:block>
    </xsl:template>
</xsl:stylesheet>
