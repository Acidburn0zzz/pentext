<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:fo="http://www.w3.org/1999/XSL/Format"
    exclude-result-prefixes="xs" version="2.0">


    <xsl:template name="layout-master-set">
        <!-- Main Page layout structure -->
        <fo:layout-master-set>
            <!-- Cover page -->
            <fo:simple-page-master master-name="Cover-Cover" xsl:use-attribute-sets="PortraitPage">
                <fo:region-body region-name="cover-flow" xsl:use-attribute-sets="cover-flow"/>
                <fo:region-after region-name="region-after-cover"
                    xsl:use-attribute-sets="region-after-cover"/>
            </fo:simple-page-master>
            <!-- Cover Content Page -->
            <fo:simple-page-master master-name="Cover-Content" xsl:use-attribute-sets="PortraitPage">
                <fo:region-body region-name="cover-flow"
                    xsl:use-attribute-sets="region-body-content"/>
                <fo:region-before region-name="region-before-cover"
                    xsl:use-attribute-sets="region-before-content"/>
                <fo:region-after region-name="region-after-meta"
                    xsl:use-attribute-sets="region-after-content"/>
            </fo:simple-page-master>
            <!-- Section Cover Page -->
            <fo:simple-page-master master-name="Section-Cover" xsl:use-attribute-sets="PortraitPage">
                <fo:region-body region-name="region-body"
                    xsl:use-attribute-sets="region-body-sectioncover"/>
            </fo:simple-page-master>
            <!-- Section Content Page (Odd) -->
            <fo:simple-page-master master-name="Section-Content-odd"
                xsl:use-attribute-sets="PortraitPage">
                <fo:region-body region-name="region-body"
                    xsl:use-attribute-sets="region-body-content"/>
                <fo:region-before region-name="region-before-content"
                    xsl:use-attribute-sets="region-before-content"/>
                <fo:region-after region-name="region-after-content-odd"
                    xsl:use-attribute-sets="region-after-content"/>
                <fo:region-end region-name="region-end-content"
                    xsl:use-attribute-sets="region-end-content"/>
            </fo:simple-page-master>
            <!-- Section Content Page (Even) (just a change in the footer) -->
            <fo:simple-page-master master-name="Section-Content-even"
                xsl:use-attribute-sets="PortraitPage">
                <fo:region-body region-name="region-body"
                    xsl:use-attribute-sets="region-body-content"/>
                <fo:region-before region-name="region-before-content"
                    xsl:use-attribute-sets="region-before-content"/>
                <fo:region-after region-name="region-after-content-even"
                    xsl:use-attribute-sets="region-after-content"/>
                <fo:region-end region-name="region-end-content"
                    xsl:use-attribute-sets="region-end-content"/>
            </fo:simple-page-master>
            <!-- sequence master -->
            <fo:page-sequence-master master-name="Cover">
                <fo:repeatable-page-master-alternatives>
                    <fo:conditional-page-master-reference master-reference="Cover-Cover"
                        page-position="first" blank-or-not-blank="not-blank"/>
                    <fo:conditional-page-master-reference master-reference="Cover-Content"
                        page-position="any"/>
                </fo:repeatable-page-master-alternatives>
            </fo:page-sequence-master>
            <fo:page-sequence-master master-name="Sections">
                <fo:repeatable-page-master-alternatives>
                    <fo:conditional-page-master-reference master-reference="Section-Cover"
                        page-position="first"/>
                    <fo:conditional-page-master-reference master-reference="Section-Content-odd"
                        page-position="any" odd-or-even="odd"/>
                    <fo:conditional-page-master-reference master-reference="Section-Content-even"
                        page-position="any" odd-or-even="even"/>
                </fo:repeatable-page-master-alternatives>
            </fo:page-sequence-master>
        </fo:layout-master-set>
    </xsl:template>

    <xsl:template name="cover_footer">
        <fo:static-content flow-name="region-after-cover" xsl:use-attribute-sets="FooterFont">
            <fo:block xsl:use-attribute-sets="footer coverfooter">
                <fo:block> V<xsl:value-of select="$latestVersionNumber"/>
                </fo:block>
                <fo:block>
                    <xsl:value-of select="//meta/company/city"/>, <xsl:value-of select="$latestVersionDate"/>
                </fo:block>
                <fo:block>
                    <xsl:value-of select="//meta/company/coc"/>
                </fo:block>
            </fo:block>
        </fo:static-content>
    </xsl:template>

    <xsl:template name="page_footer">
        <fo:static-content flow-name="region-after-content-odd" xsl:use-attribute-sets="FooterFont">
            <fo:block xsl:use-attribute-sets="footer">
                <fo:table table-layout="fixed" width="19cm" margin-top="10.5mm">
                    <fo:table-column column-width="2cm"/>
                    <fo:table-column column-width="17cm"/>
                    <fo:table-body>
                        <fo:table-row>
                            <fo:table-cell>
                                <fo:block>&#160;</fo:block>
                            </fo:table-cell>
                            <fo:table-cell display-align="center">
                                <fo:block xsl:use-attribute-sets="footertable">
                                    <xsl:value-of select="//meta/company/coc"/>
                                    <fo:leader leader-pattern="space"/>
                                    <xsl:text>p </xsl:text>
                                    <fo:page-number/>
                                    <xsl:text> </xsl:text>
                                    <xsl:call-template name="getString">
                                        <xsl:with-param name="stringID" select="'page_of'"/>
                                    </xsl:call-template>
                                    <xsl:text> </xsl:text>
                                    <fo:page-number-citation ref-id="EndOfDoc"/>
                                </fo:block>
                            </fo:table-cell>
                        </fo:table-row>
                    </fo:table-body>
                </fo:table>
            </fo:block>
        </fo:static-content>
        <fo:static-content flow-name="region-after-content-even" xsl:use-attribute-sets="FooterFont">
            <fo:block xsl:use-attribute-sets="footer">
                <fo:table table-layout="fixed" width="19cm" margin-top="7mm">
                    <fo:table-column column-width="2cm"/>
                    <fo:table-column column-width="17cm"/>
                    <fo:table-body>
                        <fo:table-row>
                            <fo:table-cell>
                                <fo:block>
                                    <fo:external-graphic xsl:use-attribute-sets="footerlogo"/>
                                </fo:block>
                            </fo:table-cell>
                            <fo:table-cell display-align="center">
                                <fo:block xsl:use-attribute-sets="footertable">
                                    <xsl:value-of select="//meta/company/coc"/>
                                    <fo:leader leader-pattern="space"/>
                                    <xsl:text>p </xsl:text>
                                    <fo:page-number/>
                                    <xsl:text> </xsl:text>
                                    <xsl:call-template name="getString">
                                        <xsl:with-param name="stringID" select="'page_of'"/>
                                    </xsl:call-template>
                                    <xsl:text> </xsl:text>
                                    <fo:page-number-citation ref-id="EndOfDoc"/>
                                </fo:block>
                            </fo:table-cell>
                        </fo:table-row>
                    </fo:table-body>
                </fo:table>
            </fo:block>
        </fo:static-content>
    </xsl:template>

    <xsl:template name="meta_footer">
        <fo:static-content flow-name="region-after-meta" xsl:use-attribute-sets="FooterFont">
            <fo:block xsl:use-attribute-sets="footer">&#160;</fo:block>
        </fo:static-content>
    </xsl:template>

    <xsl:template name="page_header">
        <fo:static-content flow-name="region-before-content" xsl:use-attribute-sets="HeaderFont">
            <fo:block/>
            <!-- empty, just needed for graphic -->
        </fo:static-content>
    </xsl:template>

    <xsl:template name="page_tab">
        <fo:static-content flow-name="region-end-content" xsl:use-attribute-sets="HeaderFont">
            <fo:block>
                <fo:block-container xsl:use-attribute-sets="sidetab">
                    <fo:block xsl:use-attribute-sets="sidetab-textblock">
                        <fo:block>
                            <fo:retrieve-marker retrieve-class-name="tab"/>
                        </fo:block>
                    </fo:block>
                </fo:block-container>
            </fo:block>
        </fo:static-content>
    </xsl:template>

    <xsl:template name="Content">
        <fo:page-sequence master-reference="Cover">
            <xsl:call-template name="cover_footer"/>
            <xsl:call-template name="page_header"/>
            <xsl:call-template name="meta_footer"/>
            <fo:flow flow-name="cover-flow" xsl:use-attribute-sets="DefaultFont">
                <fo:block>
                    <xsl:call-template name="meta"/>
                    <xsl:if test="generate_index">
                        <!-- moet dit of slaat ie 'm sowieso wel over als er geen generate_index is? -->
                        <xsl:apply-templates select="generate_index"/>
                    </xsl:if>
                </fo:block>
            </fo:flow>
        </fo:page-sequence>
        <xsl:for-each select="/*/section | /*/appendix">
            <fo:page-sequence master-reference="Sections">
                <xsl:call-template name="page_header"/>
                <xsl:call-template name="page_footer"/>
                <xsl:call-template name="page_tab"/>
                <fo:flow flow-name="region-body" xsl:use-attribute-sets="DefaultFont">
                    <fo:block>
                        <xsl:apply-templates/>
                    </fo:block>
                    <xsl:if test="not(following-sibling::*)">
                        <fo:block id="EndOfDoc"/>
                    </xsl:if>
                </fo:flow>
            </fo:page-sequence>
        </xsl:for-each>
    </xsl:template>

</xsl:stylesheet>
