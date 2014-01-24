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
    version     = "2.0"
    
    xmlns:a="http://schemas.openxmlformats.org/drawingml/2006/main"
    xmlns:xsl   = "http://www.w3.org/1999/XSL/Transform"
    xmlns:ltx   = "http://dlmf.nist.gov/LaTeXML"
    xmlns:o="urn:schemas-microsoft-com:office:office" 
    xmlns:r="http://schemas.openxmlformats.org/officeDocument/2006/relationships" 
    xmlns:v="urn:schemas-microsoft-com:vml" 
    xmlns:m="http://www.w3.org/1998/Math/MathML"
    xmlns:w="http://schemas.openxmlformats.org/wordprocessingml/2006/main" 
    xmlns:w10="urn:schemas-microsoft-com:office:word" 
    xmlns:wp="http://schemas.openxmlformats.org/drawingml/2006/wordprocessingDrawing"
     xmlns:pic="http://schemas.openxmlformats.org/drawingml/2006/picture"
     xmlns:omml="http://schemas.openxmlformats.org/officeDocument/2006/math"
    exclude-result-prefixes = "ltx">
    <xsl:output method="xml" indent="yes"/>
    <xsl:template match="*">
      <xsl:apply-templates/>
    </xsl:template>
    <xsl:template match="/">
    <Relationships>
      <Relationship Id="rId1" Type="http://schemas.openxmlformats.org/officeDocument/2006/relationships/styles" Target="styles.xml"/>
      <xsl:apply-templates/>
      <Relationship Id="rId3" Type="http://schemas.openxmlformats.org/officeDocument/2006/relationships/fontTable" Target="fontTable.xml"/>
      <Relationship Id="rId4" Type="http://schemas.openxmlformats.org/officeDocument/2006/relationships/settings" Target="settings.xml"/>    
    </Relationships>
    </xsl:template>
    <xsl:template match="text()"/>
    <xsl:template match="external-link">
    <Relationship Id="{./extra/@r:id}" Type="http://schemas.openxmlformats.org/officeDocument/2006/relationships/hyperlink" Target="{./*[@href]/@href}" TargetMode="External"/>
    </xsl:template>
    </xsl:stylesheet>
