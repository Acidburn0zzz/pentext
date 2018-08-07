<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:my="http://www.radical.sexy"
    exclude-result-prefixes="xs my" version="2.0">

    <!-- auto numbering format (used in various docs) -->
    <xsl:param name="AUTO_NUMBERING_FORMAT" select="'1.1.1'"/>

    <!-- executive summary (report only) -->
    <xsl:param name="EXEC_SUMMARY" select="true()"/>

    <!-- language parameter for localization (quote & invoice) -->
    <xsl:param name="lang" select="/*/@xml:lang"/>

    <!-- keys for numbering (used in report) -->
    <xsl:key name="rosid" match="section | finding | appendix | non-finding" use="@id"/>

    <!-- key for bibliographies (for general document) -->
    <xsl:key name="biblioid" match="biblioentry" use="@id"/>

    <!-- contract variables -->
    <xsl:variable name="hourly_fee" select="/contract/meta/contractor/hourly_fee * 1"/>
    <xsl:variable name="plannedHours" select="/contract/meta/work/planning/hours * 1"/>
    <xsl:variable name="total_fee" select="$hourly_fee * $plannedHours"/>

    <!-- document version number (mostly for report) -->
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


    <!-- document version number (various documents) -->
    <xsl:variable name="latestVersionDate">
        <xsl:choose>
            <xsl:when test="/contract">
                <!-- we're not using versions for contracts, but the contract date will do just fine -->
                <xsl:value-of
                    select="format-date(/contract/meta/work/start_date, '[MNn] [D1], [Y]', 'en', (), ())"
                />
            </xsl:when>
            <xsl:when test="/ratecard">
                <xsl:for-each select="/*/meta/client/rates/latestrevisiondate">
                    <xsl:sort select="xs:dateTime(@date)" order="descending"/>
                    <xsl:if test="position() = 1">
                        <xsl:value-of select="format-dateTime(@date, '[MNn] [D1], [Y]', en, (), ())"
                        />
                    </xsl:if>
                </xsl:for-each>
            </xsl:when>
            <xsl:otherwise>
                <xsl:for-each select="//version_history/version">
                    <xsl:sort select="xs:dateTime(@date)" order="descending"/>
                    <xsl:if test="position() = 1">
                        <xsl:value-of
                            select="format-dateTime(@date, '[MNn] [D1o], [Y]', 'en', (), ())"/>
                        <!-- Note: this should be: 
                    <xsl:value-of select="format-dateTime(@date, $localDateFormat, $lang, (), ())"/> 
                    to properly be localised, but we're using Saxon HE instead of PE/EE and having localised month names 
                    would require creating a LocalizerFactory 
                    See http://www.saxonica.com/html/documentation/extensibility/config-extend/localizing/ for more info
                    sounds like I'd have to know Java for that so for now, the date isn't localised. :) -->
                    </xsl:if>
                </xsl:for-each>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:variable>

    <xsl:variable name="eur" select="'eur'"/>
    <xsl:variable name="gbp" select="'gbp'"/>
    <xsl:variable name="usd" select="'usd'"/>
    <xsl:variable name="eur_s" select="'€'"/>
    <xsl:variable name="gbp_s" select="'£'"/>
    <xsl:variable name="usd_s" select="'$'"/>
    <xsl:variable name="denomination">
        <xsl:choose>
            <xsl:when test="/ratecard">
                <xsl:choose>
                    <xsl:when test="//meta/client/rates/@denomination = $eur">
                        <xsl:value-of select="$eur_s"/>
                    </xsl:when>
                    <xsl:when test="//meta/client/rates/@denomination = $gbp">
                        <xsl:value-of select="$gbp_s"/>
                    </xsl:when>
                    <xsl:when test="//meta/client/rates/@denomination = $usd">
                        <xsl:value-of select="$usd_s"/>
                    </xsl:when>
                </xsl:choose>
            </xsl:when>
            <xsl:when test="/contract">
                <xsl:choose>
                    <xsl:when test="/contract/meta/contractor/hourly_fee/@denomination = $eur">
                        <xsl:value-of select="$eur_s"/>
                    </xsl:when>
                    <xsl:when test="/contract/meta/contractor/hourly_fee/@denomination = $gbp">
                        <xsl:value-of select="$gbp_s"/>
                    </xsl:when>
                    <xsl:when test="/contract/meta/contractor/hourly_fee/@denomination = $usd">
                        <xsl:value-of select="$usd_s"/>
                    </xsl:when>
                </xsl:choose>
            </xsl:when>
            <xsl:when test="/offerte">
                <xsl:choose>
                    <xsl:when test="/offerte/meta/activityinfo/fee/@denomination = $eur">
                        <xsl:value-of select="$eur_s"/>
                    </xsl:when>
                    <xsl:when test="/offerte/meta/activityinfo/fee/@denomination = $gbp">
                        <xsl:value-of select="$gbp_s"/>
                    </xsl:when>
                    <xsl:when test="/offerte/meta/activityinfo/fee/@denomination = $usd">
                        <xsl:value-of select="$usd_s"/>
                    </xsl:when>
                </xsl:choose>
            </xsl:when>
            <xsl:when test="/invoice">
                <xsl:choose>
                    <xsl:when test="/invoice/@denomination = $eur">
                        <xsl:value-of select="$eur_s"/>
                    </xsl:when>
                    <xsl:when test="/invoice/@denomination = $gbp">
                        <xsl:value-of select="$gbp_s"/>
                    </xsl:when>
                    <xsl:when test="/invoice/@denomination = $usd">
                        <xsl:value-of select="$usd_s"/>
                    </xsl:when>
                </xsl:choose>
            </xsl:when>
        </xsl:choose>
    </xsl:variable>

    <!-- titlecase function -->
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
</xsl:stylesheet>
