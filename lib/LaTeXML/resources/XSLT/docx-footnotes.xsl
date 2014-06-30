<?xml version="1.0" encoding="utf-8"?>
<!--
/=====================================================================\ 
|  ltx2word.xsl                                                       |
|  Stylesheet for making footnotes                                    |
|=====================================================================|
| not yet Part of LaTeXML: http://dlmf.nist.gov/LaTeXML/              |
|=====================================================================|
| Lukas Kolhase                                               #_#     |
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
    <xsl:template match="*">
      <xsl:apply-templates/>
    </xsl:template>
    <xsl:template match="/">
    <w:footnotes xmlns:wpc="http://schemas.microsoft.com/office/word/2010/wordprocessingCanvas" xmlns:mc="http://schemas.openxmlformats.org/markup-compatibility/2006" xmlns:o="urn:schemas-microsoft-com:office:office" xmlns:r="http://schemas.openxmlformats.org/officeDocument/2006/relationships" xmlns:m="http://schemas.openxmlformats.org/officeDocument/2006/math" xmlns:v="urn:schemas-microsoft-com:vml" xmlns:wp14="http://schemas.microsoft.com/office/word/2010/wordprocessingDrawing" xmlns:wp="http://schemas.openxmlformats.org/drawingml/2006/wordprocessingDrawing" xmlns:w10="urn:schemas-microsoft-com:office:word" xmlns:w="http://schemas.openxmlformats.org/wordprocessingml/2006/main" xmlns:w14="http://schemas.microsoft.com/office/word/2010/wordml" xmlns:wpg="http://schemas.microsoft.com/office/word/2010/wordprocessingGroup" xmlns:wpi="http://schemas.microsoft.com/office/word/2010/wordprocessingInk" xmlns:wne="http://schemas.microsoft.com/office/word/2006/wordml" xmlns:wps="http://schemas.microsoft.com/office/word/2010/wordprocessingShape" mc:Ignorable="w14 wp14">
    <xsl:apply-templates/>
    </w:footnotes>
    </xsl:template>
 <xsl:template match="footnote">
  <w:footnote w:id="{./@w:id}"> 
    <w:p w:rsidR="00AB4F54" w:rsidRDefault="00AB4F54"> 
      <w:pPr>  
        <w:pStyle w:val="FootnoteText"/> 
      </w:pPr> 
       <w:r> 
        <w:rPr> 
          <w:rStyle w:val="FootnoteReference"/> 
        </w:rPr> 
        <w:footnoteRef/> 
      </w:r> 
      <xsl:apply-templates mode="copy"/> 
    </w:p> 
  </w:footnote>
  </xsl:template>
  <xsl:template match="*">
  <xsl:apply-templates/>
  </xsl:template>
  <xsl:template match="text()"/>
  <xsl:template match="@*|node()" mode="copy">
      <xsl:copy>
      <xsl:apply-templates select="@*|node()" mode="copy"/>
      </xsl:copy>
    </xsl:template>
    </xsl:stylesheet>
