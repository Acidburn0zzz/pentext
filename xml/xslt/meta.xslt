<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" exclude-result-prefixes="xs"
    xmlns:fo="http://www.w3.org/1999/XSL/Format" version="2.0">

    <xsl:template match="meta">
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
            <xsl:choose>
                <xsl:when test="$EXEC_SUMMARY = true()">
                    <xsl:text>Penetration Test Report Management Summary</xsl:text>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:value-of select="title"/>
                </xsl:otherwise>
            </xsl:choose>
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
            <fo:block xsl:use-attribute-sets="for">
                <xsl:text>for</xsl:text>
            </fo:block>
            <fo:block xsl:use-attribute-sets="title-client">
                <xsl:value-of select="//client/full_name"/>
            </fo:block>
        </fo:block>
        <xsl:call-template name="DocProperties"/>
        <xsl:call-template name="VersionControl"/>
        <xsl:call-template name="Contact"/>
    </xsl:template>

    <xsl:template name="DocProperties">
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
        <xsl:variable name="authors"
            select="version_history/version/v_author[not(. = ../preceding::version/v_author)]"/>
        <fo:block xsl:use-attribute-sets="title-4">Document Properties</fo:block>
        <fo:block margin-bottom="{$very-large-space}">
            <fo:table width="100%" table-layout="fixed" xsl:use-attribute-sets="borders">
                <fo:table-column column-width="proportional-column-width(25)"
                    xsl:use-attribute-sets="bg-orange borders"/>
                <fo:table-column column-width="proportional-column-width(75)"/>
                <fo:table-body>
                    <fo:table-row xsl:use-attribute-sets="borders">
                        <fo:table-cell xsl:use-attribute-sets="th">
                            <fo:block>Client</fo:block>
                        </fo:table-cell>
                        <fo:table-cell xsl:use-attribute-sets="td">
                            <fo:block>
                                <xsl:value-of select="//client/full_name"/>
                            </fo:block>
                        </fo:table-cell>
                    </fo:table-row>
                    <fo:table-row xsl:use-attribute-sets="borders">
                        <fo:table-cell xsl:use-attribute-sets="th">
                            <fo:block>Title</fo:block>
                        </fo:table-cell>
                        <fo:table-cell xsl:use-attribute-sets="td">
                            <fo:block>
                                <xsl:choose>
                                    <xsl:when test="$EXEC_SUMMARY = true()">
                                        <xsl:text>Penetration Test Report Management Summary</xsl:text>
                                    </xsl:when>
                                    <xsl:otherwise>
                                        <xsl:value-of select="title"/>
                                    </xsl:otherwise>
                                </xsl:choose>
                            </fo:block>
                        </fo:table-cell>
                    </fo:table-row>
                    <fo:table-row xsl:use-attribute-sets="borders">
                        <fo:table-cell xsl:use-attribute-sets="th">
                            <fo:block>Target<xsl:if test="targets/target[2]">s</xsl:if>
                            </fo:block>
                        </fo:table-cell>
                        <fo:table-cell xsl:use-attribute-sets="td">
                            <fo:block>
                                <xsl:choose>
                                    <xsl:when test="targets/target[2]">
                                        <!-- more than one target -->
                                        <xsl:for-each select="targets/target">
                                            <fo:block>
                                                <xsl:value-of select="."/>
                                            </fo:block>
                                        </xsl:for-each>
                                        <!-- end list -->
                                    </xsl:when>
                                    <xsl:otherwise>
                                        <!-- just the one -->
                                        <xsl:value-of select="targets/target"/>
                                    </xsl:otherwise>
                                </xsl:choose>
                            </fo:block>
                        </fo:table-cell>
                    </fo:table-row>
                    <fo:table-row xsl:use-attribute-sets="borders">
                        <fo:table-cell xsl:use-attribute-sets="th">
                            <fo:block>Version</fo:block>
                        </fo:table-cell>
                        <fo:table-cell xsl:use-attribute-sets="td">
                            <fo:block>
                                <xsl:value-of select="$latestVersionNumber"/>
                            </fo:block>
                        </fo:table-cell>
                    </fo:table-row>
                    <fo:table-row xsl:use-attribute-sets="borders">
                        <fo:table-cell xsl:use-attribute-sets="th">
                            <fo:block>Pentester<xsl:if test="collaborators/pentesters/pentester[2]"
                                    >s</xsl:if></fo:block>
                        </fo:table-cell>
                        <fo:table-cell xsl:use-attribute-sets="td">
                            <fo:block>
                                <xsl:for-each select="collaborators/pentesters/pentester">
                                    <fo:inline>
                                        <xsl:value-of select="name"/>
                                    </fo:inline>
                                    <xsl:if test="following-sibling::pentester">
                                        <xsl:text>, </xsl:text>
                                    </xsl:if>
                                </xsl:for-each>
                            </fo:block>
                        </fo:table-cell>
                    </fo:table-row>
                    <fo:table-row xsl:use-attribute-sets="borders">
                        <fo:table-cell xsl:use-attribute-sets="th">
                            <fo:block>Author<xsl:if test="$authors[2]">s</xsl:if></fo:block>
                        </fo:table-cell>
                        <fo:table-cell xsl:use-attribute-sets="td">
                            <fo:block>
                                <xsl:for-each select="$authors">
                                    <xsl:if test="preceding::v_author">
                                        <xsl:text>, </xsl:text>
                                    </xsl:if>
                                    <fo:inline>
                                        <xsl:value-of select="."/>
                                    </fo:inline>
                                </xsl:for-each>
                            </fo:block>
                        </fo:table-cell>
                    </fo:table-row>
                    <fo:table-row xsl:use-attribute-sets="borders">
                        <fo:table-cell xsl:use-attribute-sets="th">
                            <fo:block>Reviewed by</fo:block>
                        </fo:table-cell>
                        <fo:table-cell xsl:use-attribute-sets="td">
                            <fo:block>
                                <xsl:for-each select="collaborators/reviewers/reviewer">
                                    <fo:block>
                                        <xsl:value-of select="."/>
                                    </fo:block>
                                </xsl:for-each>
                            </fo:block>
                        </fo:table-cell>
                    </fo:table-row>
                    <fo:table-row xsl:use-attribute-sets="borders">
                        <fo:table-cell xsl:use-attribute-sets="th">
                            <fo:block>Approved by</fo:block>
                        </fo:table-cell>
                        <fo:table-cell xsl:use-attribute-sets="td">
                            <fo:block>
                                <xsl:value-of select="collaborators/approver/name"/>
                            </fo:block>
                        </fo:table-cell>
                    </fo:table-row>
                </fo:table-body>
            </fo:table>
        </fo:block>
    </xsl:template>

    <xsl:template name="VersionControl">
        <xsl:variable name="versions" select="version_history/version"/>
        <fo:block xsl:use-attribute-sets="title-4">Version control</fo:block>
        <fo:block margin-bottom="{$very-large-space}">
            <fo:table width="100%" table-layout="fixed" xsl:use-attribute-sets="borders">
                <fo:table-column column-width="proportional-column-width(25)"
                    xsl:use-attribute-sets="borders"/>
                <fo:table-column column-width="proportional-column-width(25)"
                    xsl:use-attribute-sets="borders"/>
                <fo:table-column column-width="proportional-column-width(25)"
                    xsl:use-attribute-sets="borders"/>
                <fo:table-column column-width="proportional-column-width(25)"
                    xsl:use-attribute-sets="borders"/>
                <fo:table-body>
                    <fo:table-row xsl:use-attribute-sets="bg-orange">
                        <fo:table-cell xsl:use-attribute-sets="th">
                            <fo:block>Version</fo:block>
                        </fo:table-cell>
                        <fo:table-cell xsl:use-attribute-sets="th">
                            <fo:block>Date</fo:block>
                        </fo:table-cell>
                        <fo:table-cell xsl:use-attribute-sets="th">
                            <fo:block>Author</fo:block>
                        </fo:table-cell>
                        <fo:table-cell xsl:use-attribute-sets="th">
                            <fo:block>Description</fo:block>
                        </fo:table-cell>
                    </fo:table-row>
                    <xsl:for-each select="$versions">
                        <!-- todo: guard date format in schema -->
                        <xsl:sort select="xs:dateTime(@date)" order="ascending"/>
                        <fo:table-row>
                            <xsl:if test="position() mod 2 != 0">
                                <xsl:attribute name="background-color">#ededed</xsl:attribute>
                            </xsl:if>
                            <fo:table-cell xsl:use-attribute-sets="td">
                                <fo:block>
                                    <xsl:call-template name="VersionNumber">
                                        <xsl:with-param name="number" select="@number"/>
                                    </xsl:call-template>
                                </fo:block>
                            </fo:table-cell>
                            <fo:table-cell xsl:use-attribute-sets="td">
                                <fo:block>
                                    <xsl:value-of
                                        select="format-dateTime(@date, '[MNn] [D1o], [Y]', 'en', (), ())"
                                    />
                                </fo:block>
                            </fo:table-cell>
                            <fo:table-cell xsl:use-attribute-sets="td">
                                <fo:block>
                                    <xsl:for-each select="v_author">
                                        <fo:inline>
                                            <xsl:value-of select="."/>
                                        </fo:inline>
                                        <xsl:if test="following-sibling::v_author">
                                            <xsl:text>, </xsl:text>
                                        </xsl:if>
                                    </xsl:for-each>
                                </fo:block>
                            </fo:table-cell>
                            <fo:table-cell xsl:use-attribute-sets="td">
                                <fo:block>
                                    <xsl:value-of select="v_description"/>
                                </fo:block>
                            </fo:table-cell>
                        </fo:table-row>
                    </xsl:for-each>
                </fo:table-body>
            </fo:table>
        </fo:block>
    </xsl:template>

    <xsl:template name="VersionNumber">
        <xsl:param name="number" select="@number"/>
        <xsl:choose>
            <!-- if value is auto, do some autonumbering magic -->
            <xsl:when test="string(@number) = 'auto'"> 0.<xsl:number count="version"
                    level="multiple" format="{$AUTO_NUMBERING_FORMAT}"/>
                <!-- this is really unrobust :D - todo: follow fixed numbering if provided -->
            </xsl:when>
            <xsl:otherwise>
                <!-- just plop down the value -->
                <!-- todo: guard numbering format in schema -->
                <xsl:value-of select="@number"/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>

    <xsl:template name="Contact">
        <fo:block xsl:use-attribute-sets="title-4">Contact</fo:block>
        <fo:block xsl:use-attribute-sets="p" margin-left="0">For more information about this Document and its
            contents please contact <xsl:value-of select="company/full_name"/>
            <xsl:if test="not(company/full_name[ends-with(., '.')])"
            ><xsl:text>.</xsl:text></xsl:if></fo:block>
        <fo:block break-after="page">
            <fo:table width="100%" table-layout="fixed" xsl:use-attribute-sets="borders">
                <fo:table-column column-width="proportional-column-width(25)"
                    xsl:use-attribute-sets="bg-orange borders"/>
                <fo:table-column column-width="proportional-column-width(75)"/>
                <fo:table-body xsl:use-attribute-sets="borders">
                    <fo:table-row>
                        <fo:table-cell xsl:use-attribute-sets="th">
                            <fo:block>Name</fo:block>
                        </fo:table-cell>
                        <fo:table-cell xsl:use-attribute-sets="td">
                            <fo:block>
                                <xsl:value-of select="company/poc1"/>
                            </fo:block>
                        </fo:table-cell>
                    </fo:table-row>
                    <fo:table-row xsl:use-attribute-sets="borders">
                        <fo:table-cell xsl:use-attribute-sets="th">
                            <fo:block>Address</fo:block>
                        </fo:table-cell>
                        <fo:table-cell xsl:use-attribute-sets="td">
                            <fo:block>
                                <xsl:apply-templates select="company/address"/>
                            </fo:block>
                            <fo:block>
                                <xsl:value-of select="company/postal_code"/>&#160;<xsl:value-of
                                    select="company/city"/>
                            </fo:block>
                            <fo:block>
                                <xsl:value-of select="company/country"/>
                            </fo:block>
                        </fo:table-cell>
                    </fo:table-row>
                    <fo:table-row xsl:use-attribute-sets="borders">
                        <fo:table-cell xsl:use-attribute-sets="th">
                            <fo:block>Phone</fo:block>
                        </fo:table-cell>
                        <fo:table-cell xsl:use-attribute-sets="td">
                            <fo:block>
                                <xsl:value-of select="company/phone"/>
                            </fo:block>
                        </fo:table-cell>
                    </fo:table-row>
                    <fo:table-row xsl:use-attribute-sets="borders">
                        <fo:table-cell xsl:use-attribute-sets="th">
                            <fo:block>Email</fo:block>
                        </fo:table-cell>
                        <fo:table-cell xsl:use-attribute-sets="td">
                            <fo:block>
                                <xsl:value-of select="company/email"/>
                            </fo:block>
                        </fo:table-cell>
                    </fo:table-row>
                </fo:table-body>
            </fo:table>
        </fo:block>
    </xsl:template>

</xsl:stylesheet>
