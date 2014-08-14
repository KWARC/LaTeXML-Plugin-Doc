<?xml version="1.0" encoding="UTF-8"?>
<!--
/=====================================================================\ 
|  cleaner.xsl                                                        |
|  Stylesheet for cleaning up and making Word-readable document.xml   |
|=====================================================================|
| not yet Part of LaTeXML: http://dlmf.nist.gov/LaTeXML/              |
|=====================================================================|
| Michael Kohlhase http://kwarc.info/kohlhase                 #_#     |
| Public domain software                                     (o o)    |
\=========================================================ooo==U==ooo=/
-->
<xsl:stylesheet  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
xmlns:book="http://www.daisy.org/z3986/2005/dtbook/" xmlns="http://openebook.org/namespaces/oeb-package/1.0/" exclude-result-prefixes="book dc"  xmlns:dc="http://purl.org/dc/elements/1.1/" version="1.0">
  <xsl:output indent="yes" method="xml"/>
  
  <xsl:template match="*">
    <xsl:apply-templates/>
  </xsl:template>
  <xsl:template match="/">
  <xsl:text disable-output-escaping='yes'>
 &lt;!DOCTYPE package
  PUBLIC "+//ISBN 0-9673008-1-9//DTD OEB 1.2 Package//EN" "http://openebook.org/dtds/oeb-1.2/oebpkg12.dtd">
</xsl:text>
<package unique-identifier="uid">
<xsl:apply-templates/>

</package>
  </xsl:template>
<xsl:template match="book:meta">
<xsl:if test="@name='dc:Title'">
<dc:Title><xsl:value-of select="@content"/></dc:Title>
</xsl:if>
<xsl:if test="@name='dc:Creator'">
	<dc:Creator><xsl:value-of select="@content"/></dc:Creator>
</xsl:if>
<xsl:if test="@name='dc:Format'">
	<dc:Format><xsl:value-of select="@content"/></dc:Format>
</xsl:if>
</xsl:template>
  
  <xsl:template match="book:head">
  	<metadata>
  	 	<dc-metadata xmlns:oebpackage="http://openebook.org/namespaces/oeb-package/1.0/"
                   xmlns:dc="http://purl.org/dc/elements/1.1/">
         
         <xsl:apply-templates/>
          <dc:Identifier id="uid"><xsl:value-of select="generate-id(.)"/></dc:Identifier>
          			   
		       <dc:Language>en</dc:Language>
         <dc:Publisher>Publisher</dc:Publisher>
         <dc:Title>odt2daisy Instruction Manual</dc:Title>
         <dc:Type>Text</dc:Type>
         <dc:Date>2011-11-11 <xsl:comment>Default Date </xsl:comment></dc:Date>
         </dc-metadata>
         </metadata>
  </xsl:template>
  <xsl:template match="book:book">
  	<manifest>
  	      <item href="content.xml" id="content" media-type="application/x-dtbook+xml"/>
  		<xsl:apply-templates/>
  	</manifest>
  	<spine>
  		<itemref idref="content"/>
  	</spine>
  </xsl:template>
  
<xsl:template match="book:img">
	<xsl:if test="contains(@src,'png')">
  	<item href="{@src}" id="{generate-id(.)}" media-type="image/png"/>
  	</xsl:if>
  	<xsl:if test="contains(@src,'jpg')">
<item href="{@src}" id="{generate-id(.)}" media-type="image/jpg"/>
	</xsl:if>
	<xsl:if test="contains(@src,'jpeg')">
		<item href="{@src}" id="{generate-id(.)}" media-type="image/jpg"/>
	</xsl:if>
	<xsl:if test="contains(@bsrc,'svg')">
	<item href="{@src}" id="{generate-id(.)}" media-type="image/svg"/>
	</xsl:if>
  </xsl:template>
  

  <xsl:template match="text()"/>
</xsl:stylesheet>
