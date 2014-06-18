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
<xsl:stylesheet xmlns:ltx="http://dlmf.nist.gov/LaTeXML" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:b="http://schemas.openxmlformats.org/officeDocument/2006/bibliography" xmlns:exsl="http://exslt.org/common" version="1.0" exclude-result-prefixes="ltx">
  <xsl:output method="xml" indent="yes"/>
  <xsl:template match="*">
    <xsl:message>Cannot deal with Element <xsl:value-of select="name(. )"/></xsl:message>
    <xsl:comment> <xsl:copy-of select="."/></xsl:comment>
  </xsl:template>
  <xsl:template match="/">
    <b:Sources xmlns:b="http://schemas.openxmlformats.org/officeDocument/2006/bibliography" xmlns="http://schemas.openxmlformats.org/officeDocument/2006/bibliography" SelectedStyle="\APA.XSL" StyleName="APA">
      <xsl:apply-templates/>
    </b:Sources>
  </xsl:template>
  <xsl:template match="text()"/>
  <xsl:template match="ltx:document">
    <xsl:apply-templates/>
  </xsl:template>
  <xsl:template match="ltx:resource"/>
  <xsl:template match="ltx:bibliography">
    <xsl:apply-templates/>
  </xsl:template>
  <xsl:template match="ltx:title"/>
  <xsl:template match="ltx:biblist">
    <xsl:apply-templates/>
  </xsl:template>
  <xsl:template match="ltx:bibentry">
    <b:Source>
      <b:SourceType><xsl:value-of select="./@type"/></b:SourceType>
      <b:Tag>
        <xsl:value-of select="./@key"/>
      </b:Tag>
      <b:Author>
        <b:Author>
          <b:NameList>
            <xsl:for-each select="./ltx:bib-name[@role='author']">
              <b:Person>
                <xsl:if test="./ltx:givenname">
                  <b:First>
                    <xsl:value-of select="./ltx:givenname/text()"/>
                  </b:First>
                </xsl:if>
                <b:Last>
                  <xsl:value-of select="./ltx:surname/text()"/>
                </b:Last>
              </b:Person>
            </xsl:for-each>
          </b:NameList>
        </b:Author>
      </b:Author>
      <xsl:apply-templates/>
    </b:Source>
  </xsl:template>
  <xsl:template match="ltx:bibentry[contains(@type,'thesis')]"> <!-- thesis are best modelled by articles in a journal. Only other options that fit are book and miscellaneous. However misc. doesn't contain the extra information we would want. --> 
    <b:Source>
      <b:SourceType>JournalArticle</b:SourceType>
      <b:Tag>
        <xsl:value-of select="./@key"/>
      </b:Tag>
      <b:Author>
        <b:Author>
          <b:NameList>
            <xsl:for-each select="./ltx:bib-name[@role='author']">
              <b:Person>
                <xsl:if test="./ltx:givenname">
                  <b:First>
                    <xsl:value-of select="./ltx:givenname/text()"/>
                  </b:First>
                </xsl:if>
                <b:Last>
                  <xsl:value-of select="./ltx:surname/text()"/>
                </b:Last>
              </b:Person>
            </xsl:for-each>
          </b:NameList>
        </b:Author>
      </b:Author>
      <xsl:apply-templates/>
    </b:Source>
  </xsl:template>
  <xsl:template match="ltx:bibentry[@type='manual']">
    <b:Source>
      <b:SourceType>Report</b:SourceType>
      <b:Tag>
        <xsl:value-of select="./@key"/>
      </b:Tag>
      <b:Author>
        <b:Author>
          <b:NameList>
            <xsl:for-each select="./ltx:bib-name[@role='author']">
              <b:Person>
                <xsl:if test="./ltx:givenname">
                  <b:First>
                    <xsl:value-of select="./ltx:givenname/text()"/>
                  </b:First>
                </xsl:if>
                <b:Last>
                  <xsl:value-of select="./ltx:surname/text()"/>
                </b:Last>
              </b:Person>
            </xsl:for-each>
          </b:NameList>
        </b:Author>
      </b:Author>
      <xsl:apply-templates/>
    </b:Source>
  </xsl:template>
  <xsl:template match="ltx:bibentry[contains(@type,'proceedings')]">
    <b:Source>
      <b:SourceType>ConferenceProceedings</b:SourceType>
      <b:Tag>
        <xsl:value-of select="./@key"/>
      </b:Tag>
      <b:Author>
        <b:Author>
          <b:NameList>
            <xsl:for-each select="./ltx:bib-name[@role='author']">
              <b:Person>
                <xsl:if test="./ltx:givenname">
                  <b:First>
                    <xsl:value-of select="./ltx:givenname/text()"/>
                  </b:First>
                </xsl:if>
                <b:Last>
                  <xsl:value-of select="./ltx:surname/text()"/>
                </b:Last>
              </b:Person>
            </xsl:for-each>
          </b:NameList>
        </b:Author>
      </b:Author>
      <xsl:apply-templates/>
    </b:Source>
  </xsl:template>
   <xsl:template match="ltx:bibentry[@type='incollection']">
    <b:Source>
      <b:SourceType>BookSection</b:SourceType>
      <b:Tag>
        <xsl:value-of select="./@key"/>
      </b:Tag>
      <b:Author>
        <b:Author>
          <b:NameList>
            <xsl:for-each select="./ltx:bib-name[@role='author']">
              <b:Person>
                <xsl:if test="./ltx:givenname">
                  <b:First>
                    <xsl:value-of select="./ltx:givenname/text()"/>
                  </b:First>
                </xsl:if>
                <b:Last>
                  <xsl:value-of select="./ltx:surname/text()"/>
                </b:Last>
              </b:Person>
            </xsl:for-each>
          </b:NameList>
        </b:Author>
      </b:Author>
      <xsl:apply-templates/>
    </b:Source>
  </xsl:template>
  <xsl:template match="ltx:bibentry[@type='booklet']">
    <b:Source>
      <b:SourceType>Book</b:SourceType>
      <b:Tag>
        <xsl:value-of select="./@key"/>
      </b:Tag>
      <b:Author>
        <b:Author>
          <b:NameList>
            <xsl:for-each select="./ltx:bib-name[@role='author']">
              <b:Person>
                <xsl:if test="./ltx:givenname">
                  <b:First>
                    <xsl:value-of select="./ltx:givenname/text()"/>
                  </b:First>
                </xsl:if>
                <b:Last>
                  <xsl:value-of select="./ltx:surname/text()"/>
                </b:Last>
              </b:Person>
            </xsl:for-each>
          </b:NameList>
        </b:Author>
      </b:Author>
      <xsl:apply-templates/>
    </b:Source>
  </xsl:template>
  <xsl:template match="ltx:bibentry[@type='inbook']">
    <b:Source>
      <b:SourceType>BookSection</b:SourceType>
      <b:Tag>
        <xsl:value-of select="./@key"/>
      </b:Tag>
      <b:Author>
        <b:Author>
          <b:NameList>
            <xsl:for-each select="./ltx:bib-name[@role='author']">
              <b:Person>
                <xsl:if test="./ltx:givenname">
                  <b:First>
                    <xsl:value-of select="./ltx:givenname/text()"/>
                  </b:First>
                </xsl:if>
                <b:Last>
                  <xsl:value-of select="./ltx:surname/text()"/>
                </b:Last>
              </b:Person>
            </xsl:for-each>
          </b:NameList>
        </b:Author>
      </b:Author>
      <xsl:apply-templates/>
    </b:Source>
  </xsl:template>
  <xsl:template match="ltx:bibentry[@type='article']">
    <b:Source>
      <b:SourceType>JournalArticle</b:SourceType>
      <b:Tag>
        <xsl:value-of select="./@key"/>
      </b:Tag>
      <b:Author>
        <b:Author>
          <b:NameList>
            <xsl:for-each select="./ltx:bib-name[@role='author']">
              <b:Person>
                <xsl:if test="./ltx:givenname">
                  <b:First>
                    <xsl:value-of select="./ltx:givenname/text()"/>
                  </b:First>
                </xsl:if>
                <b:Last>
                  <xsl:value-of select="./ltx:surname/text()"/>
                </b:Last>
              </b:Person>
            </xsl:for-each>
          </b:NameList>
        </b:Author>
      </b:Author>
      <xsl:apply-templates/>
    </b:Source>
  </xsl:template>
  <xsl:template match="ltx:bib-name[@role='author']"/>
  <xsl:template match="ltx:bib-title">
    <b:Title>
      <xsl:value-of select="./text()"/>
    </b:Title>
  </xsl:template>
  <xsl:template match="ltx:bib-related[@role='host' and @type='journal']/ltx:bib-title">
    <b:JournalName>
      <xsl:value-of select="./text()"/>
    </b:JournalName>
  </xsl:template>
  <xsl:template match="ltx:bib-date[@role='publication']">
    <xsl:if test="contains(./text(),'-')">
      <b:Year>
        <xsl:value-of select="substring-before(./text(),'-')"/>
      </b:Year>
      <xsl:if test="not(ancestor::ltx:bibentry[@type='manual'])">
      <b:Month>
        <xsl:value-of select="substring-after(./text(),'-')"/>
      </b:Month>
      </xsl:if>
    </xsl:if>
    <xsl:if test="not(contains(./text(),'-'))">
      <b:Year>
        <xsl:value-of select="./text()"/>
      </b:Year>
    </xsl:if>
  </xsl:template>

  <xsl:template match="ltx:bib-note[@role='annotation']"/>
  <xsl:template match="ltx:bib-key"/>
  <xsl:template match="ltx:bib-publisher">
  <b:Publisher><xsl:value-of select="./text()"/></b:Publisher>
  </xsl:template>
  <xsl:template match="ltx:bib-place"/>
  <xsl:template match="ltx:bib-data[@role='self' and @type='BibTeX']"/>
  <xsl:template match="ltx:bib-related[@role='host' and @type='journal']">
  	<xsl:apply-templates/>
  </xsl:template>
  <xsl:template match="ltx:bib-part[@role='volume']"/>
  <xsl:template match="ltx:bib-part[@role='number']"/>
  <xsl:template match="ltx:bib-part[@role='pages' and not(../ltx:bibentry[@type='article' or contains(@type,'proceedings')])]">
   <b:Pages><xsl:value-of select="./text()"/></b:Pages>
  </xsl:template>
    <xsl:template match="ltx:bib-data[@role='month']"/>

  <xsl:template match="ltx:bib-data[@role='address']">
  	<b:City><xsl:value-of select="./text()"/></b:City>
  </xsl:template>
  <xsl:template match="ltx:bib-part[@role='series']"/>
  <xsl:template match="ltx:bib-edition"/>
  <xsl:template match="ltx:bib-note[@role='publication']"/>
  <xsl:template match="ltx:bib-part[@role='chapter']"/>
  <xsl:template match="ltx:bib-related[@role='host' and @type='book']">
  <xsl:apply-templates/>
  </xsl:template>
  <xsl:template match="ltx:bib-related[@role='host' and @type='book']/ltx:bib-title">
  <xsl:if test="not(ancestor::ltx:bibentry[@type='book'] or ancestor::ltx:bibentry[@type='inbook'])">
    <b:BookTitle><xsl:value-of select="./text()"/></b:BookTitle>
  </xsl:if>
  </xsl:template>

   <xsl:template match="ltx:bib-related[@role='host' and @type='proceedings']/ltx:bib-title"/>       
     <xsl:template match="ltx:bib-type"/>     
  <xsl:template match="ltx:bib-related[@role='host' and @type='proceedings']">
  <xsl:apply-templates/>
  </xsl:template>
  <xsl:template match="ltx:bib-name[@role='editor']"/>
  <xsl:template match="ltx:bibentry[@type='manual']//ltx:bib-organization">
  <b:Publisher><xsl:value-of select="./text()"/></b:Publisher>
  </xsl:template>
  <xsl:template match="ltx:bibentry[@type='thesis']//ltx:bib-organization">
  <b:Publisher><xsl:value-of select="./text()"/></b:Publisher>
  </xsl:template>
  <xsl:template match="ltx:bibentry[contains(@type,'proceedings')]//ltx:bib-organization">
   <b:ConferenceName><xsl:value-of select="./text()"/></b:ConferenceName>
   </xsl:template>
   
</xsl:stylesheet>
