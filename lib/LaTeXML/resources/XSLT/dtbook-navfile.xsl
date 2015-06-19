<?xml version="1.0" encoding="UTF-8"?>
<!--
/=====================================================================\ 
|  cleaner.xsl                                                        |
|  Stylesheet for cleaning up and making Word-readable document.xml   |
|=====================================================================|
| not yet Part of LaTeXML: http://dlmf.nist.gov/LaTeXML/              |
|=====================================================================|
| Lukas Kohlhase                                              #_#     |
| Public domain software                                     (o o)    |
\=========================================================ooo==U==ooo=/
-->
<xsl:stylesheet  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
xmlns:book="http://www.daisy.org/z3986/2005/dtbook/" xmlns="http://www.daisy.org/z3986/2005/ncx/" exclude-result-prefixes="book dc"  xmlns:dc="http://purl.org/dc/elements/1.1/" version="1.0">
  <xsl:output indent="yes" method="xml"/>
  
  <xsl:template match="*">
    <xsl:apply-templates/>
  </xsl:template>
  <xsl:template match="text()"/>
  
  <xsl:template match="book:head">
  	<head>
  		<xsl:apply-templates/>
  	</head>
  </xsl:template>
  
  <xsl:template match="/">
  <xsl:text disable-output-escaping='yes'>
  &lt;!DOCTYPE ncx
  PUBLIC "-//NISO//DTD ncx 2005-1//EN" "http://www.daisy.org/z3986/2005/ncx-2005-1.dtd">
  </xsl:text>
<xsl:apply-templates/>
</xsl:template>

<xsl:template match="book:dtbook">
	<ncx version="2005-1" xml:lang="en-US">
	<xsl:apply-templates select="book:head"/>
	<xsl:apply-templates select="//book:doctitle"/>
	<xsl:apply-templates select="//book:docauthor"/>
	<xsl:apply-templates select="book:book"/>
</ncx>
</xsl:template>

<xsl:template match="book:book">
	<navMap>
		<xsl:apply-templates select="book:bodymatter"/>
	</navMap>
</xsl:template>
<xsl:template match="book:h1">
<navPoint class="h1" playOrder="{count(preceding::book:h1)+count(preceding::book:h2)+count(preceding::book:h3)+1}" id="{generate-id(.)}">
	<navLabel>
		<text><xsl:value-of select=".//text()"/></text>
	</navLabel>
	<xsl:apply-templates/>
</navPoint>
</xsl:template>

<xsl:template match="book:h2">
<navPoint class="h2" playOrder="{count(preceding::book:h1)+count(preceding::book:h2)+count(preceding::book:h3)+1}" id="{generate-id(.)}">
	<navLabel>
		<text><xsl:value-of select=".//text()"/></text>
	</navLabel>
	<xsl:apply-templates/>
</navPoint>
</xsl:template>

<xsl:template match="book:h3">
<navPoint class="h3" playOrder="{count(preceding::book:h1)+count(preceding::book:h2)+count(preceding::book:h3)+1}" id="{generate-id(.)}">
	<navLabel>
		<text><xsl:value-of select=".//text()"/></text>
	</navLabel>
	<xsl:apply-templates/>
</navPoint>
</xsl:template>


<xsl:template match="book:doctitle">
	<docTitle>
		<text>
			<xsl:apply-templates/>
		</text>
	</docTitle>
</xsl:template>

<xsl:template match="book:docauthor">
	<docAuthor>
		<text> 	
			<xsl:apply-templates/>
		</text>
	</docAuthor>
</xsl:template>

<xsl:template match="book:doctitle//text()">
	<xsl:copy-of select="."/>
</xsl:template>

<xsl:template match="book:docauthor//text()">
	<xsl:copy-of select="."/>
</xsl:template>
</xsl:stylesheet>
