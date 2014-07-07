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
<xsl:stylesheet xmlns:exsl="http://exslt.org/common" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:ltx="http://dlmf.nist.gov/LaTeXML" exclude-result-prefixes="ltx" version="1.0">
  <xsl:output indent="yes" method="xml"/>
  <xsl:template match="*">
    <xsl:apply-templates/>
  </xsl:template>
  <xsl:template match="/">
    <Relationships xmlns="http://schemas.openxmlformats.org/package/2006/relationships">
      <Relationship Target="styles.xml" Type="http://schemas.openxmlformats.org/officeDocument/2006/relationships/styles" Id="rId1"/>
      <Relationship Target="../customXml/item1.xml" Type="http://schemas.openxmlformats.org/officeDocument/2006/relationships/customXml" Id="rId2"/>
      <Relationship Target="fontTable.xml" Type="http://schemas.openxmlformats.org/officeDocument/2006/relationships/fontTable" Id="rId3"/>
      <Relationship Target="settings.xml" Type="http://schemas.openxmlformats.org/officeDocument/2006/relationships/settings" Id="rId4"/>
      <Relationship Target="footnotes.xml" Type="http://schemas.openxmlformats.org/officeDocument/2006/relationships/footnotes" Id="rId5"/>
      <xsl:apply-templates/>
    </Relationships>
  </xsl:template>
  <xsl:template match="text()"/>
  <xsl:template match="external-link">
    <Relationship Target="{./*[@href]/@href}" Type="http://schemas.openxmlformats.org/officeDocument/2006/relationships/hyperlink" Id="{./extra/@id}" TargetMode="External"/>
  </xsl:template>
  <xsl:template match="picturus">
    <Relationship Target="{./@reference}" Type="http://schemas.openxmlformats.org/officeDocument/2006/relationships/image" Id="{./@id}"/>
  </xsl:template>
</xsl:stylesheet>
