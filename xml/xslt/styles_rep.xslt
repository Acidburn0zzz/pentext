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
    
    
    
    <!-- colors -->
   
    <xsl:attribute-set name="status-new"><!-- also used by unresolved -->
        <xsl:attribute name="color">#CC4900</xsl:attribute>
    </xsl:attribute-set>
    <xsl:attribute-set name="status-resolved">
        <xsl:attribute name="color">#b7aa5b</xsl:attribute>
    </xsl:attribute-set>
    <xsl:attribute-set name="status-not_retested">
        <xsl:attribute name="color">#FE9920</xsl:attribute>
    </xsl:attribute-set>
   
    
    
</xsl:stylesheet>