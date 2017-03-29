<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" exclude-result-prefixes="xs"
    xmlns:fo="http://www.w3.org/1999/XSL/Format" version="2.0">

    <!-- variables -->
    <xsl:variable name="border-width">1pt</xsl:variable>
    <xsl:variable name="border-style">solid</xsl:variable>
    <xsl:variable name="border-color">black</xsl:variable>
    <xsl:variable name="tabbed-numbering-tabwidth">20mm</xsl:variable>
    <xsl:variable name="small-space">5pt</xsl:variable>
    <xsl:variable name="large-space">8mm</xsl:variable>
    <xsl:variable name="very-large-space">1.3cm</xsl:variable>

    <!-- User-accessible classes -->
    <xsl:attribute-set name="keep-together">
        <xsl:attribute name="keep-together">always</xsl:attribute>
    </xsl:attribute-set>

    <!-- Common settings -->
    <xsl:attribute-set name="root-common">
        <xsl:attribute name="line-height-shift-adjustment">disregard-shifts</xsl:attribute>
    </xsl:attribute-set>

    <!-- Text -->
    <xsl:attribute-set name="DefaultFont">
        <xsl:attribute name="font-family">LiberationSansNarrow</xsl:attribute>
        <xsl:attribute name="font-size">10pt</xsl:attribute>
        <xsl:attribute name="color">black</xsl:attribute>
    </xsl:attribute-set>
    <xsl:attribute-set name="HeaderFont" use-attribute-sets="DefaultFont"/>
    <xsl:attribute-set name="FooterFont" use-attribute-sets="DefaultFont"/>
    <xsl:attribute-set name="TableFont" use-attribute-sets="DefaultFont">
        <xsl:attribute name="font-size">10pt</xsl:attribute>
    </xsl:attribute-set>
    <xsl:attribute-set name="TinyFont" use-attribute-sets="DefaultFont">
        <xsl:attribute name="font-size">8pt</xsl:attribute>
    </xsl:attribute-set>
    <xsl:attribute-set name="PreFont" use-attribute-sets="DefaultFont">
        <xsl:attribute name="font-family">LiberationMono</xsl:attribute>
        <xsl:attribute name="font-size">10pt</xsl:attribute>
    </xsl:attribute-set>
    <!--
    <xsl:attribute-set name="title">
        <xsl:attribute name="keep-with-next.within-page">always</xsl:attribute>
        <xsl:attribute name="font-weight">bold</xsl:attribute>
    </xsl:attribute-set>-->
    <xsl:attribute-set name="errortext">
        <xsl:attribute name="color">red</xsl:attribute>
        <xsl:attribute name="background-color">black</xsl:attribute>
        <xsl:attribute name="font-weight">bold</xsl:attribute>
    </xsl:attribute-set>
    <xsl:attribute-set name="title-0" use-attribute-sets="title">
        <xsl:attribute name="text-align">center</xsl:attribute>
        <xsl:attribute name="font-size">16pt</xsl:attribute>
        <xsl:attribute name="margin-bottom">1cm</xsl:attribute>
        <xsl:attribute name="background-color">orange</xsl:attribute>
    </xsl:attribute-set>
    <xsl:attribute-set name="title-1" use-attribute-sets="title">
        
    </xsl:attribute-set>
    <xsl:attribute-set name="title-2" use-attribute-sets="title">
        
    </xsl:attribute-set>
    <xsl:attribute-set name="title-3" use-attribute-sets="title">
    </xsl:attribute-set>
    <xsl:attribute-set name="title-4" use-attribute-sets="title">
        <xsl:attribute name="margin-bottom">5pt</xsl:attribute>
    </xsl:attribute-set>
    <xsl:attribute-set name="title-client" use-attribute-sets="title-0">
        <xsl:attribute name="background-color">silver</xsl:attribute>
        <xsl:attribute name="margin-bottom">6cm</xsl:attribute>
        <xsl:attribute name="text-transform">capitalize</xsl:attribute>
    </xsl:attribute-set>
    <xsl:attribute-set name="for">
        <xsl:attribute name="text-align">center</xsl:attribute>
        <xsl:attribute name="margin-bottom">1cm</xsl:attribute>
    </xsl:attribute-set>
    <xsl:attribute-set name="title-toc" use-attribute-sets="title-2">
    </xsl:attribute-set>
    <xsl:attribute-set name="img-title">
        <xsl:attribute name="font-style">italic</xsl:attribute>
        <xsl:attribute name="text-align">center</xsl:attribute>
    </xsl:attribute-set>
    <xsl:attribute-set name="section">
        <xsl:attribute name="margin-bottom">
            <xsl:value-of select="$very-large-space"/>
        </xsl:attribute>
    </xsl:attribute-set>
    <xsl:attribute-set name="bold">
        <xsl:attribute name="font-weight">bold</xsl:attribute>
    </xsl:attribute-set>
    <xsl:attribute-set name="italic">
        <xsl:attribute name="font-style">italic</xsl:attribute>
    </xsl:attribute-set>
    <xsl:attribute-set name="underline">
        <xsl:attribute name="text-decoration">underline</xsl:attribute>
    </xsl:attribute-set>
    <xsl:attribute-set name="code" use-attribute-sets="DefaultFont">
        <xsl:attribute name="font-family">LiberationMono</xsl:attribute>
        <xsl:attribute name="font-size">90%</xsl:attribute>
        <xsl:attribute name="background-color">#eeeeee</xsl:attribute>
    </xsl:attribute-set>
    <xsl:attribute-set name="code-title" use-attribute-sets="DefaultFont">
        <xsl:attribute name="font-family">LiberationMono</xsl:attribute>
        <xsl:attribute name="font-size">90%</xsl:attribute>
    </xsl:attribute-set>
    <xsl:attribute-set name="sup" use-attribute-sets="DefaultFont">
        <xsl:attribute name="font-size">60%</xsl:attribute>
        <xsl:attribute name="vertical-align">super</xsl:attribute>
    </xsl:attribute-set>
    <xsl:attribute-set name="sub" use-attribute-sets="DefaultFont">
        <xsl:attribute name="font-size">60%</xsl:attribute>
        <xsl:attribute name="vertical-align">sub</xsl:attribute>
    </xsl:attribute-set>
    <xsl:attribute-set name="link">
        <xsl:attribute name="color">#eb6209</xsl:attribute>
    </xsl:attribute-set>
    <!-- bibliography -->
    <xsl:attribute-set name="title.book" use-attribute-sets="italic"/>
    <xsl:attribute-set name="title.article"/>
    <xsl:attribute-set name="journal" use-attribute-sets="italic"/>
    <xsl:attribute-set name="website"/>
    <xsl:attribute-set name="info"/>
    <xsl:attribute-set name="publisher"/>
    <xsl:attribute-set name="pubdate"/>
    <!-- blocks -->
    <xsl:attribute-set name="p">
        <xsl:attribute name="margin-bottom">
            <xsl:value-of select="$small-space"/>
        </xsl:attribute>
        <xsl:attribute name="line-height">6.5mm</xsl:attribute>
    </xsl:attribute-set>
    <xsl:attribute-set name="li">
        <xsl:attribute name="line-height">5.5mm</xsl:attribute>
        <xsl:attribute name="keep-together.within-page">always</xsl:attribute>
    </xsl:attribute-set>
    <xsl:attribute-set name="biblioentry">
        <xsl:attribute name="margin-bottom">
            <xsl:value-of select="$small-space"/>
        </xsl:attribute>
    </xsl:attribute-set>
    <xsl:attribute-set name="list" use-attribute-sets="p"/>
    <xsl:attribute-set name="last">
        <xsl:attribute name="margin-bottom">
            <xsl:value-of select="$very-large-space"/>
        </xsl:attribute>
    </xsl:attribute-set>
    <xsl:attribute-set name="pre" use-attribute-sets="PreFont">
        <xsl:attribute name="border-style">solid</xsl:attribute>
        <xsl:attribute name="border-width">1pt</xsl:attribute>
        <xsl:attribute name="border-color">#e4e4e4</xsl:attribute>
        <xsl:attribute name="background-color">#ededed</xsl:attribute>
        <xsl:attribute name="margin-bottom">
            <xsl:value-of select="$medium-space"/>
        </xsl:attribute>
        <xsl:attribute name="white-space-collapse">false</xsl:attribute>
        <xsl:attribute name="linefeed-treatment">preserve</xsl:attribute>
        <xsl:attribute name="white-space-treatment">preserve</xsl:attribute>
        <xsl:attribute name="font-size">8pt</xsl:attribute>
        <xsl:attribute name="padding">4pt</xsl:attribute>
    </xsl:attribute-set>
    <xsl:attribute-set name="finding-meta">
        <xsl:attribute name="margin-bottom" select="$small-space"/>
    </xsl:attribute-set>

    <!-- Pages -->
    <xsl:attribute-set name="PortraitPage">
        <xsl:attribute name="margin-top">0cm</xsl:attribute>
        <xsl:attribute name="margin-bottom">0cm</xsl:attribute>
        <xsl:attribute name="margin-left">0cm</xsl:attribute>
        <xsl:attribute name="margin-right">0cm</xsl:attribute>
        <xsl:attribute name="page-height">29.7cm</xsl:attribute>
        <xsl:attribute name="page-width">21.0cm</xsl:attribute>
    </xsl:attribute-set>
    <xsl:attribute-set name="region-body-content">
        <xsl:attribute name="margin-top">4.7cm</xsl:attribute>
        <xsl:attribute name="margin-bottom">3cm</xsl:attribute>
        <xsl:attribute name="margin-left">3cm</xsl:attribute>
        <xsl:attribute name="margin-right">1.8cm</xsl:attribute>
    </xsl:attribute-set>
    <xsl:attribute-set name="cover-flow">
        <xsl:attribute name="background-image">url(../graphics/report_titlesheet.png)</xsl:attribute>
    </xsl:attribute-set>
    <xsl:attribute-set name="region-body-sectioncover">
        <xsl:attribute name="background-image">url(../graphics/section_titlesheet.png)</xsl:attribute>
    </xsl:attribute-set>
    <xsl:attribute-set name="region-before-content">
        <xsl:attribute name="precedence">true</xsl:attribute>
        <xsl:attribute name="extent">4.2cm</xsl:attribute>
        <xsl:attribute name="background-image">url(../graphics/gradient_top_gray.png)</xsl:attribute>
    </xsl:attribute-set>
    <xsl:attribute-set name="region-after-content">
        <xsl:attribute name="precedence">true</xsl:attribute>
        <xsl:attribute name="extent">2.5cm</xsl:attribute>
        <xsl:attribute name="background-color">black</xsl:attribute>
    </xsl:attribute-set>
    <xsl:attribute-set name="region-end-content">
        <xsl:attribute name="extent">1.3cm</xsl:attribute>
    </xsl:attribute-set>
    <xsl:attribute-set name="sidetab">
        <xsl:attribute name="width">4.3cm</xsl:attribute>
        <xsl:attribute name="height">1.3cm</xsl:attribute>
        <xsl:attribute name="padding-end">5mm</xsl:attribute>
        <xsl:attribute name="background-color">#eb6209</xsl:attribute>
        <xsl:attribute name="reference-orientation">90</xsl:attribute>
        <xsl:attribute name="display-align">center</xsl:attribute>
    </xsl:attribute-set>
    <xsl:attribute-set name="sidetab-textblock">
        <xsl:attribute name="color">white</xsl:attribute>
        <xsl:attribute name="font-size">9pt</xsl:attribute>
        <xsl:attribute name="margin-left">2mm</xsl:attribute>
        <xsl:attribute name="margin-right">2mm</xsl:attribute>
        <xsl:attribute name="text-align">center</xsl:attribute>
    </xsl:attribute-set>
    <xsl:attribute-set name="region-body-cover" use-attribute-sets="region-body-content"/>
    <xsl:attribute-set name="region-before-cover" use-attribute-sets="region-before-content"/>
    <xsl:attribute-set name="region-after-cover" use-attribute-sets="region-after-content"/>

    <xsl:attribute-set name="header">
        <xsl:attribute name="text-align">right</xsl:attribute>
        <xsl:attribute name="font-weight">bold</xsl:attribute>
    </xsl:attribute-set>
    <xsl:attribute-set name="footer">
        <xsl:attribute name="color">#e4e4e4</xsl:attribute>
        <xsl:attribute name="margin-left">1cm</xsl:attribute>
        <xsl:attribute name="margin-right">1cm</xsl:attribute>
    </xsl:attribute-set>
    <xsl:attribute-set name="coverfooter" use-attribute-sets="footer">
        <xsl:attribute name="margin-top">7mm</xsl:attribute>
        <xsl:attribute name="line-height">5.5mm</xsl:attribute>
    </xsl:attribute-set>
    <xsl:attribute-set name="footerlogo">
        <xsl:attribute name="src">url(../graphics/footer_logo.png)</xsl:attribute>
        <xsl:attribute name="height">10mm</xsl:attribute>
        <xsl:attribute name="content-width">scale-to-fit</xsl:attribute>
        <xsl:attribute name="content-height">scale-to-fit</xsl:attribute>
        <xsl:attribute name="scaling">uniform</xsl:attribute>
    </xsl:attribute-set>
    <xsl:attribute-set name="footertable">
        <xsl:attribute name="text-align-last">justify</xsl:attribute>
    </xsl:attribute-set>
    <xsl:attribute-set name="sidetabs"/>

    <!-- colors -->
    <xsl:attribute-set name="bg-orange">
        <xsl:attribute name="background-color">#eb6209</xsl:attribute>
    </xsl:attribute-set>

    <!-- graphics -->
    <xsl:attribute-set name="graphics-block">
        <xsl:attribute name="text-align">center</xsl:attribute>
        <xsl:attribute name="margin-bottom" select="$small-space"/>
    </xsl:attribute-set>

    <!-- tables -->
    <xsl:attribute-set name="borders">
        <xsl:attribute name="border-width">
            <xsl:value-of select="$border-width"/>
        </xsl:attribute>
        <xsl:attribute name="border-style">
            <xsl:value-of select="$border-style"/>
        </xsl:attribute>
        <xsl:attribute name="border-color">
            <xsl:value-of select="$border-color"/>
        </xsl:attribute>
    </xsl:attribute-set>
    <xsl:attribute-set name="th" use-attribute-sets="td bg-orange">
        <xsl:attribute name="color">white</xsl:attribute>
    </xsl:attribute-set>
    <xsl:attribute-set name="td">
        <xsl:attribute name="padding-left">4pt</xsl:attribute>
        <xsl:attribute name="padding-right">4pt</xsl:attribute>
        <xsl:attribute name="padding-top">3pt</xsl:attribute>
        <xsl:attribute name="padding-bottom">3pt</xsl:attribute>
    </xsl:attribute-set>
    <xsl:attribute-set name="table">
        <xsl:attribute name="margin-bottom" select="$small-space"/>
        <xsl:attribute name="border-after-width.conditionality">retain</xsl:attribute>
        <xsl:attribute name="border-before-width.conditionality">retain</xsl:attribute>
    </xsl:attribute-set>
    <xsl:attribute-set name="findingTable">
        <xsl:attribute name="margin-bottom" select="$small-space"/>
        <xsl:attribute name="background-color">#ededed</xsl:attribute>
        <xsl:attribute name="border-color">#e4e4e4</xsl:attribute>
    </xsl:attribute-set>
    <xsl:attribute-set name="pieChartTable">
        <xsl:attribute name="table-layout">fixed</xsl:attribute>
    </xsl:attribute-set>
    <xsl:attribute-set name="pieLegendTable" use-attribute-sets="borders pieChartTable">
        <xsl:attribute name="background-color">#ededed</xsl:attribute>
        <xsl:attribute name="border-color">#e4e4e4</xsl:attribute>
    </xsl:attribute-set>
    <xsl:attribute-set name="pieLegendTableCell">
        <xsl:attribute name="padding-left">4pt</xsl:attribute>
        <xsl:attribute name="padding-right">4pt</xsl:attribute>
    </xsl:attribute-set>
    

    <!-- lists -->
    <xsl:attribute-set name="li">
        <xsl:attribute name="margin-bottom" select="$small-space"/>
    </xsl:attribute-set>

    <!-- ToC -->
    <xsl:attribute-set name="index">
        <xsl:attribute name="break-after">page</xsl:attribute>
    </xsl:attribute-set>
    <xsl:attribute-set name="tocCell">
        <xsl:attribute name="padding-bottom">1.5mm</xsl:attribute>
    </xsl:attribute-set>

    <!-- Contact -->
    <xsl:attribute-set name="Contact">
        <xsl:attribute name="keep-together.within-page">always</xsl:attribute>
        <xsl:attribute name="margin-left" select="$very-large-space"/>
        <xsl:attribute name="line-height">18pt</xsl:attribute>
    </xsl:attribute-set>

    <!-- Signature boxes -->
    <xsl:attribute-set name="signaturebox">
        <xsl:attribute name="margin-top" select="$very-large-space"/>
    </xsl:attribute-set>

    <!-- Misc (invoice) -->
    <xsl:attribute-set name="orange-text">
        <!-- 'silver' is #c0c0c0 -->
        <xsl:attribute name="color">#FF5C00</xsl:attribute>
    </xsl:attribute-set>
    <xsl:attribute-set name="align-right">
        <xsl:attribute name="text-align">right</xsl:attribute>
    </xsl:attribute-set>
    <xsl:attribute-set name="big-space-below">
        <xsl:attribute name="margin-bottom">8mm</xsl:attribute>
    </xsl:attribute-set>
</xsl:stylesheet>
