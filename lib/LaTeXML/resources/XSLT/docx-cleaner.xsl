<?xml version="1.0" encoding="utf-8"?>
<!--
/=====================================================================\ 
|  ltx2word.xsl                                                       |
|  Stylesheet for converting LaTeXML documents to OOXML          |
|=====================================================================|
| not yet Part of LaTeXML: http://dlmf.nist.gov/LaTeXML/              |
|=====================================================================|
| Michael Kohlhase http://kwarc.info/kohlhase                 #_#     |
| Public domain software                                     (o o)    |
\=========================================================ooo==U==ooo=/
-->
<xsl:stylesheet
    version     = "1.0"
    xmlns:ltx   = "http://dlmf.nist.gov/LaTeXML"
    xmlns:xsl   = "http://www.w3.org/1999/XSL/Transform"
    xmlns:exsl="http://exslt.org/common"
    xmlns:w="http://schemas.openxmlformats.org/wordprocessingml/2006/main"
    exclude-result-prefixes = "ltx">
    <xsl:output method="xml" indent="yes"/>
    <xsl:template match="@*|node()">
      <xsl:copy>
      <xsl:apply-templates select="@*|node()"/>
      </xsl:copy>
    </xsl:template>
    <xsl:template match="external-link"/>
    <xsl:template match="picturus"/>
    <xsl:template match="w:p//w:p">
    <xsl:apply-templates select="@*|node()"/>
    </xsl:template>
        <xsl:template match="w:p//w:tc/w:p">
        <xsl:copy>
    <xsl:apply-templates select="@*|node()"/>
    </xsl:copy>
    </xsl:template>
    <xsl:template select="w:r[not(ancestor::w:p)]">
    <w:p>
    <xsl:copy>
      <xsl:apply-templates select="@*|node()"/>
      </xsl:copy>
    </w:p>
    </xsl:template>
    <xsl:template match="footnote"/>
    </xsl:stylesheet>
