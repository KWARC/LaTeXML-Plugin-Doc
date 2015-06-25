<?xml version="1.0" encoding="utf-8"?>
<!--
/=====================================================================\ 
|  docx-cleaner.xsl                                                   |
|  Stylesheet to remove helping elements and try to patch obvious     |
|  issues when converting from LaTeX to OOXML                         |
|=====================================================================|
| not yet Part of LaTeXML: http://dlmf.nist.gov/LaTeXML/              |
|=====================================================================|
| Lukas Kohlhase                                              #_#     |
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
    <xsl:template match="w:p//w:p"/>

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
