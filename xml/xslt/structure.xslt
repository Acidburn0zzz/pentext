<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:my="http://radical.sexy"
    exclude-result-prefixes="xs my" xmlns:fo="http://www.w3.org/1999/XSL/Format" version="2.0">

    <xsl:template match="section | appendix | finding | non-finding | annex">
        <xsl:if test="not(@visibility = 'hidden')">
            <xsl:choose>
                <xsl:when test="$EXEC_SUMMARY = true()">
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
        <xsl:variable name="LEVEL" select="count(ancestor::*) - 1"/>
        <xsl:variable name="CLASS">
            <!-- use title-x for all levels -->
            <xsl:text>title-</xsl:text>
            <xsl:value-of select="$LEVEL"/>
        </xsl:variable>

        <fo:block>
            <xsl:call-template name="use-att-set">
                <xsl:with-param name="CLASS" select="$CLASS"/>
            </xsl:call-template>

            <xsl:if test="../.. = /">
                <fo:marker marker-class-name="tab">
                    <xsl:value-of select="text()"/>
                </fo:marker>
            </xsl:if>
            <xsl:choose>
                <xsl:when test="$EXEC_SUMMARY = true()">
                    <xsl:choose>
                        <xsl:when test="self::title[parent::appendix]">
                            <fo:inline> Appendix&#160;<xsl:number
                                    count="appendix[not(@visibility = 'hidden')][@inexecsummary = 'yes']"
                                    level="multiple" format="{$AUTO_NUMBERING_FORMAT}"/>
                            </fo:inline>
                        </xsl:when>
                        <xsl:when test="ancestor::appendix and not(self::title[parent::appendix])">
                            <fo:inline> App&#160;<xsl:number
                                    count="appendix[not(@visibility = 'hidden')][@inexecsummary = 'yes']"
                                    level="multiple" format="{$AUTO_NUMBERING_FORMAT}"/>.<xsl:number
                                    count="section[ancestor::appendix][not(@visibility = 'hidden')][@inexecsummary = 'yes']"
                                    level="multiple" format="{$AUTO_NUMBERING_FORMAT}"/>
                            </fo:inline>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:if test="not(../.. = /)">
                                <!-- no numbering for top-level sections -->
                                <fo:inline>
                                    <xsl:number
                                        count="section[not(@visibility = 'hidden')][ancestor-or-self::*/@inexecsummary = 'yes'] | finding | non-finding"
                                        level="multiple" format="{$AUTO_NUMBERING_FORMAT}"/>
                                </fo:inline>
                            </xsl:if>
                        </xsl:otherwise>
                    </xsl:choose>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:choose>
                        <xsl:when test="self::title[parent::appendix]">
                            <fo:inline> Appendix&#160;<xsl:number
                                    count="appendix[not(@visibility = 'hidden')]" level="multiple"
                                    format="{$AUTO_NUMBERING_FORMAT}"/>
                            </fo:inline>
                        </xsl:when>
                        <xsl:when test="ancestor::appendix and not(self::title[parent::appendix])">
                            <fo:inline> App&#160;<xsl:number
                                    count="appendix[not(@visibility = 'hidden')]" level="multiple"
                                    format="{$AUTO_NUMBERING_FORMAT}"/>.<xsl:number
                                    count="section[ancestor::appendix][not(@visibility = 'hidden')]"
                                    level="multiple" format="{$AUTO_NUMBERING_FORMAT}"/>
                            </fo:inline>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:if test="not(../.. = /)">
                                <!-- no numbering for top-level sections -->
                                <fo:inline>
                                    <xsl:number
                                        count="section[not(@visibility = 'hidden')] | finding | non-finding"
                                        level="multiple" format="{$AUTO_NUMBERING_FORMAT}"/>
                                </fo:inline>
                            </xsl:if>
                        </xsl:otherwise>
                    </xsl:choose>
                </xsl:otherwise>
            </xsl:choose>
            <xsl:text>&#160;&#160;&#160;</xsl:text>
            <xsl:if test="parent::finding">
                <!-- prepend finding id (XXX-NNN) -->
                <xsl:apply-templates select=".." mode="number"/>
                <xsl:text> &#8212; </xsl:text>
            </xsl:if>
            <xsl:choose>
                <!-- First level section titles are on their own page and need to be broken down -->
                <xsl:when test="../.. = /">
                    <xsl:variable name="words" select="tokenize(., '\s')"/>
                    <xsl:for-each select="$words">
                    <xsl:analyze-string select="." regex="([A|a]nd|[O|o]r|[T|t]he|[O|o]f)">
                        <xsl:matching-substring>
                            <xsl:text> </xsl:text><xsl:value-of select="."/>
                        </xsl:matching-substring>
                        <xsl:non-matching-substring>
                            <fo:block/><xsl:value-of select="."/>
                        </xsl:non-matching-substring>
                    </xsl:analyze-string>
                    </xsl:for-each>
                    
                </xsl:when>
                <xsl:otherwise>
                    <xsl:apply-templates/>
                </xsl:otherwise>
            </xsl:choose>
        </fo:block>
        <xsl:if test="parent::finding">
            <xsl:apply-templates select=".." mode="meta"/>
        </xsl:if>
    </xsl:template>



</xsl:stylesheet>
