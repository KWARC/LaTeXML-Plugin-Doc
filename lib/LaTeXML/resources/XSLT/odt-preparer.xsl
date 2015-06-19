<?xml version="1.0" encoding="utf-8"?>
<!--
/=====================================================================\ 
|  odt-preparer.xsl                                                   |
|  Adds booksmarks to everything with xml:id                          |
|=====================================================================|
| not yet Part of LaTeXML: http://dlmf.nist.gov/LaTeXML/              |
|=====================================================================|
| Lukas Kohlhase                                              #_#     |
| Public domain software                                     (o o)    |
\=========================================================ooo==U==ooo=/
-->
<xsl:stylesheet
   xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:ltx="http://dlmf.nist.gov/LaTeXML"  version="1.0" exclude-result-prefixes="ltx">
    <xsl:template match="@*|node()">
      <xsl:copy>
      <xsl:apply-templates select="@*|node()"/>
      </xsl:copy>
    </xsl:template> 

    <xsl:template match="*[@xml:id and not(self::ltx:document)]">
    <bookmark name="{@xml:id}"/>
    <xsl:copy>
      <xsl:apply-templates select="@*|node()"/>
      </xsl:copy>
</xsl:template> 

<!-- This makes conversion a lot easier, since I can just match to the <bookmark> I added --> 
</xsl:stylesheet>
