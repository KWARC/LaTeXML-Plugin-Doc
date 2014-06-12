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
<xsl:stylesheet xmlns:ltx="http://dlmf.nist.gov/LaTeXML" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:b="http://schemas.openxmlformats.org/officeDocument/2006/bibliography" version="1.0" exclude-result-prefixes="ltx">
  <xsl:output method="xml" indent="yes"/>
  <xsl:template match="*">
    <xsl:apply-templates/>
  </xsl:template>
  <xsl:template match="/">
    <b:Sources xmlns:b="http://schemas.openxmlformats.org/officeDocument/2006/bibliography" xmlns="http://schemas.openxmlformats.org/officeDocument/2006/bibliography" SelectedStyle="\APA.XSL" StyleName="APA">
      <xsl:apply-templates/>
    </b:Sources>
  </xsl:template>
  <xsl:template match="text()"/>
  <xsl:template match="ltx:bibitem">
    <b:source>
      <b:SourceType>
        <xsl:value-of select="./@type"/>
      </b:SourceType>
      <xsl:apply-templates/>
    </b:source>
  </xsl:template>
  <xsl:template match="ltx:bibtag[@class='ltx_bib_number' and @role='number']">
    <b:Tag>
      <xsl:value-of select="./text()"/>
    </b:Tag>
  </xsl:template>
  <xsl:template match="ltx:bibtag[@class='ltx_bib_author' and @role='authors']">
    <xsl:if test="not(../ltx:bibtag[@class='ltx_bib_author' and @role='fullauthors'])">
      <b:Author>
        <b:Author>
          <b:NameList>
            <b:Person>
              <xsl:variable name="foo">
                <xsl:call-template name="output-tokens">
                  <xsl:with-param name="list" select="./text()"/>
                </xsl:call-template>
              </xsl:variable>
              <xsl:copy-of select="$foo"/>
            </b:Person>
          </b:NameList>
        </b:Author>
      </b:Author>
    </xsl:if>
  </xsl:template>
  <xsl:template match="id">
  <xsl:copy-of select="."/>
  </xsl:template>
  <xsl:template name="output-tokens">
    <xsl:param name="list"/>
    <xsl:variable name="first" select="substring-before(concat($list,' '), ' ')"/>
    <xsl:variable name="remaining" select="substring-after($list, ' ')"/>
    <id>
      <xsl:value-of select="$first"/>
    </id>
    <xsl:if test="$remaining">
      <xsl:call-template name="output-tokens">
        <xsl:with-param name="list" select="$remaining"/>
      </xsl:call-template>
    </xsl:if>    
  </xsl:template>
</xsl:stylesheet>
