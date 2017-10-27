<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:my="http://radical.sexy"
    exclude-result-prefixes="xs my" xmlns:fo="http://www.w3.org/1999/XSL/Format" version="2.0">

    <xsl:template match="section | appendix | finding | non-finding | annex">
        <xsl:param name="execsummary" tunnel="yes"/>
        <xsl:if test="not(@visibility = 'hidden')">
            <xsl:choose>
                <xsl:when test="$execsummary = true()">
                    <xsl:if test="ancestor-or-self::*/@inexecsummary = 'yes'">
                        <fo:block xsl:use-attribute-sets="section">
                            <xsl:if test="self::appendix or self::annex">
                                <xsl:attribute name="break-before">page</xsl:attribute>
                            </xsl:if>
                            <xsl:apply-templates select="@* | node()"/>
                        </fo:block>
                    </xsl:if>
                </xsl:when>
                <xsl:otherwise>
                    <fo:block xsl:use-attribute-sets="section">
                        <xsl:if test="self::appendix or self::annex">
                            <xsl:attribute name="break-before">page</xsl:attribute>
                        </xsl:if>
                        <xsl:apply-templates select="@* | node()"/>
                    </fo:block>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:if>
    </xsl:template>

    <xsl:template match="title[not(parent::biblioentry)]">
        <xsl:param name="execsummary" tunnel="yes"/>
        <xsl:variable name="LEVEL" select="count(ancestor::*) - 1"/>
        <xsl:variable name="CLASS">
            <!-- use title-x for all levels -->
            <xsl:text>title-</xsl:text>
            <xsl:value-of select="$LEVEL"/>
        </xsl:variable>

        <fo:table table-layout="fixed" width="100%" keep-with-next.within-page="always" margin-bottom="0.5cm">
            <xsl:call-template name="use-att-set">
                <xsl:with-param name="CLASS" select="$CLASS"/>
            </xsl:call-template>
            <fo:table-column column-width="2.8cm"/>
            <fo:table-column column-width="13.2cm"/>
            <fo:table-body>
                <fo:table-row height="0.7cm">
                    <fo:table-cell display-align="center" padding-left="0.5cm">
                        <xsl:if test="../.. = /">
                            <!-- Titles that appear on a section cover need to have a marker attached -->
                            <fo:marker marker-class-name="tab">
                                <xsl:value-of select="text()"/>
                            </fo:marker>
                        </xsl:if>
                        <fo:block>
                            <xsl:choose>
                                <xsl:when test="$execsummary = true()">
                                    <xsl:choose>
                                        <xsl:when test="self::title[parent::appendix]">
                                            <fo:inline> Appendix&#160;<xsl:number
                                                  count="appendix[not(@visibility = 'hidden')][@inexecsummary = 'yes']"
                                                  level="multiple" format="{$AUTO_NUMBERING_FORMAT}"
                                                />
                                            </fo:inline>
                                        </xsl:when>
                                        <xsl:when
                                            test="ancestor::appendix and not(self::title[parent::appendix])">
                                            <fo:inline> App&#160;<xsl:number
                                                  count="appendix[not(@visibility = 'hidden')][@inexecsummary = 'yes']"
                                                  level="multiple" format="{$AUTO_NUMBERING_FORMAT}"
                                                  />.<xsl:number
                                                  count="section[ancestor::appendix][not(@visibility = 'hidden')][@inexecsummary = 'yes']"
                                                  level="multiple" format="{$AUTO_NUMBERING_FORMAT}"
                                                />
                                            </fo:inline>
                                        </xsl:when>
                                        <xsl:otherwise>
                                            <xsl:if test="not(../.. = /)">
                                                <!-- no numbering for top-level sections -->
                                                <fo:inline>
                                                  <xsl:number
                                                  count="section[not(@visibility = 'hidden')][ancestor-or-self::*/@inexecsummary = 'yes'] | finding | non-finding"
                                                  level="multiple" format="{$AUTO_NUMBERING_FORMAT}"
                                                  />
                                                </fo:inline>
                                            </xsl:if>
                                        </xsl:otherwise>
                                    </xsl:choose>
                                </xsl:when>
                                <xsl:otherwise>
                                    <xsl:choose>
                                        <xsl:when test="self::title[parent::appendix]">
                                            <fo:inline> Appendix&#160;<xsl:number
                                                  count="appendix[not(@visibility = 'hidden')]"
                                                  level="multiple" format="{$AUTO_NUMBERING_FORMAT}"
                                                />
                                            </fo:inline>
                                        </xsl:when>
                                        <xsl:when
                                            test="ancestor::appendix and not(self::title[parent::appendix])">
                                            <fo:inline> App&#160;<xsl:number
                                                  count="appendix[not(@visibility = 'hidden')]"
                                                  level="multiple" format="{$AUTO_NUMBERING_FORMAT}"
                                                  />.<xsl:number
                                                  count="section[ancestor::appendix][not(@visibility = 'hidden')]"
                                                  level="multiple" format="{$AUTO_NUMBERING_FORMAT}"
                                                />
                                            </fo:inline>
                                        </xsl:when>
                                        <xsl:otherwise>
                                            <fo:inline>
                                                <xsl:number
                                                  count="section[not(@visibility = 'hidden')] | finding | non-finding"
                                                  level="multiple" format="{$AUTO_NUMBERING_FORMAT}"
                                                />
                                            </fo:inline>
                                        </xsl:otherwise>
                                    </xsl:choose>
                                </xsl:otherwise>
                            </xsl:choose>
                        </fo:block>
                    </fo:table-cell>
                    <fo:table-cell display-align="center">
                        <fo:block>
                            <xsl:if test="parent::finding">
                                <xsl:call-template name="prependNumber"/>
                            </xsl:if>
                            <xsl:apply-templates/>
                        </fo:block>
                    </fo:table-cell>
                </fo:table-row>
            </fo:table-body>
        </fo:table>
    </xsl:template>



</xsl:stylesheet>
