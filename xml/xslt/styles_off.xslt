<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="xs" xmlns:fo="http://www.w3.org/1999/XSL/Format"
    version="2.0">
    
    <xsl:import href="styles.xslt"/>
    
    <!-- variables -->
    
    <xsl:variable name="medium-space">8pt</xsl:variable>
    
    <!-- Text -->
    <xsl:attribute-set name="p">
        <xsl:attribute name="margin-bottom">
            <xsl:value-of select="$small-space"/>
        </xsl:attribute>
    </xsl:attribute-set>
    
    <!-- Titles -->
    <xsl:attribute-set name="frontpagesubtitle" use-attribute-sets="title">
        <xsl:attribute name="margin-right">2cm</xsl:attribute>
        <xsl:attribute name="margin-bottom">1.5cm</xsl:attribute>
        <xsl:attribute name="font-size">36pt</xsl:attribute>
        <xsl:attribute name="text-align">right</xsl:attribute>
        <xsl:attribute name="color">#e2632a</xsl:attribute>
        <xsl:attribute name="font-family">OpenSans</xsl:attribute>
    </xsl:attribute-set>
    <xsl:attribute-set name="for" use-attribute-sets="title">
        <xsl:attribute name="font-family">LiberationSansNarrow</xsl:attribute>
        <xsl:attribute name="color">white</xsl:attribute>
        <xsl:attribute name="font-size">20pt</xsl:attribute>
        <xsl:attribute name="font-weight">normal</xsl:attribute>
        <xsl:attribute name="text-align">right</xsl:attribute>
        <xsl:attribute name="margin-right">2cm</xsl:attribute>
    </xsl:attribute-set>
    <xsl:attribute-set name="title-date" use-attribute-sets="title">
        <xsl:attribute name="font-family">LiberationSansNarrow</xsl:attribute>
        <xsl:attribute name="margin-top">0.5cm</xsl:attribute>
        <xsl:attribute name="color">white</xsl:attribute>
        <xsl:attribute name="font-size">14pt</xsl:attribute>
        <xsl:attribute name="font-weight">normal</xsl:attribute>
        <xsl:attribute name="text-align">right</xsl:attribute>
        <xsl:attribute name="margin-right">2cm</xsl:attribute>
    </xsl:attribute-set>
    <!-- Pages -->
    <xsl:attribute-set name="coverfooter" use-attribute-sets="FooterFont footer">
        <xsl:attribute name="color">#FFFFFF</xsl:attribute>
        <xsl:attribute name="margin-top">105mm</xsl:attribute>
        <xsl:attribute name="text-align">right</xsl:attribute>
        <xsl:attribute name="font-weight">bold</xsl:attribute>
        <xsl:attribute name="line-height">5.5mm</xsl:attribute>
        <xsl:attribute name="text-align-last">right</xsl:attribute>
    </xsl:attribute-set>
    <xsl:attribute-set name="sidetab"/>
    <xsl:attribute-set name="sidetab-textblock"/>
    
</xsl:stylesheet>