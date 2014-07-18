<?xml version="1.0" encoding="utf-8"?>
<!--
/=====================================================================\ 
|  ltx2word.xsl                                                       |
|  Stylesheet for converting LaTeXML converted .bib files to a the    |
|Word bibliography format                                             |
|=====================================================================|
| not yet Part of LaTeXML: http://dlmf.nist.gov/LaTeXML/              |
|=====================================================================|
| Lukas Kohlhase                                              #_#     |
| Public domain software                                     (o o)    |
\=========================================================ooo==U==ooo=/
-->
<xsl:stylesheet xmlns:ltx="http://dlmf.nist.gov/LaTeXML" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:b="http://schemas.openxmlformats.org/officeDocument/2006/bibliography" xmlns:exsl="http://exslt.org/common" version="1.0" exclude-result-prefixes="ltx">
  <xsl:output method="xml" indent="yes"/>
  <xsl:template match="*">
    <!--  <xsl:message>Cannot deal with Element <xsl:value-of select="name(. )"/></xsl:message> -->
    <xsl:comment>
      <xsl:copy-of select="."/>
    </xsl:comment>
  </xsl:template>
  <xsl:param name="test"/>
  <xsl:variable name="document" select="document($test)"/>
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
  <xsl:variable name="foo" select="./@key"/>
  <xsl:if test="$document//ltx:bibitem[@key=$foo]">
    <b:Source>
      <b:SourceType>
        <xsl:value-of select="./@type"/>
      </b:SourceType>
      <b:Tag>
        <xsl:value-of select="./@key"/>
      </b:Tag>
      <b:Author>
        <b:Author>
          <b:NameList>
            <xsl:for-each select="./ltx:bib-name[@role='author' or @role='authors']">
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
    </xsl:if>
    <xsl:comment> Haven't deal with this bibentry yet </xsl:comment>
    <!-- <xsl:message>Haven't dealt with this bibentry yet </xsl:message> -->
  </xsl:template>
  <xsl:template match="ltx:bibentry[contains(./@type,'proceedings')]/ltx:bib-url"/>
  <xsl:template match="ltx:bibentry[@type='website']">
      <xsl:variable name="foo" select="./@key"/>
  <xsl:if test="$document//ltx:bibitem[@key=$foo]">
    <b:Source>
      <b:SourceType>InternetSite</b:SourceType>
      <b:Tag>
        <xsl:value-of select="./@key"/>
      </b:Tag>
      <b:Author>
        <b:Author>
          <b:NameList>
            <xsl:for-each select="./ltx:bib-name[@role='author' or @role='authors']">
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
    </b:Source> </xsl:if>
  </xsl:template>
  <xsl:template match="ltx:bibentry[@type='collection']">
  <xsl:variable name="foo" select="./@key"/>
  <xsl:if test="$document//ltx:bibitem[@key=$foo]">
    <b:Source>
      <b:SourceType>InternetSite</b:SourceType>
      <b:Tag>
        <xsl:value-of select="./@key"/>
      </b:Tag>
      <b:Author>
        <b:Author>
          <b:NameList>
            <xsl:for-each select="./ltx:bib-name[@role='author' or @role='authors']">
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
    </b:Source> </xsl:if>
    
  </xsl:template>
  <xsl:template match="ltx:bibentry[@type='book']/ltx:bib-url"/>
  <xsl:template match="ltx:bibentry[@type='book']">
  <xsl:variable name="foo" select="./@key"/>
  <xsl:if test="$document//ltx:bibitem[@key=$foo]">
    <b:Source>
      <b:SourceType>Book</b:SourceType>
      <b:Tag>
        <xsl:value-of select="./@key"/>
      </b:Tag>
      <b:Author>
        <b:Author>
          <b:NameList>
            <xsl:for-each select="./ltx:bib-name[@role='author' or @role='authors']">
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
    </b:Source> </xsl:if>
  </xsl:template>
  <xsl:template match="ltx:bibentry[@type='website']/ltx:bib-url">
    <b:URL>
      <xsl:value-of select="./@href"/>
    </b:URL>
  </xsl:template>
  <xsl:template match="ltx:bibentry[@type='report']">
  <xsl:variable name="foo" select="./@key"/>
  <xsl:if test="$document//ltx:bibitem[@key=$foo]">
    <b:Source>
      <b:SourceType>Report</b:SourceType>
      <b:Tag>
        <xsl:value-of select="./@key"/>type='book'
      </b:Tag>
      <b:Author>
        <b:Author>
          <b:NameList>
            <xsl:for-each select="./ltx:bib-name[@role='author' or @role='authors']">
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
    </b:Source> </xsl:if>
  </xsl:template>
  <xsl:template match="ltx:bib-organization[not(../ltx:bib-publisher)]">
  <b:Publisher><xsl:value-of select="./text()"/></b:Publisher>
  </xsl:template>
  <xsl:template match="ltx:bibentry[@type='report' and not(./ltx:bib-publisher)]/ltx:bib-organization">
    <b:Publisher>
      <xsl:value-of select="./text()"/>
    </b:Publisher>
  </xsl:template>
  <xsl:template match="ltx:bibentry[@type='website']/ltx:bib-url">
    <b:URL>
      <xsl:value-of select="./@href"/>
    </b:URL>
  </xsl:template>
  <xsl:template match="ltx:bib-data[@role='version']"/>
  <xsl:template match="ltx:bib-data[@role='urldate']">
    <b:YearAccessed>
      <xsl:value-of select="substring-before(./text(),'-')"/>
    </b:YearAccessed>
    <b:MonthAccessed>
      <xsl:value-of select="substring-before(substring-after(./text(),'-'),'-')"/>
    </b:MonthAccessed>
    <b:DayAccessed>
      <xsl:value-of select="substring-after(substring-after(./text(),'-'),'-')"/>
    </b:DayAccessed>
  </xsl:template>
  <xsl:template match="ltx:bibentry[@type='unpublished']">
  <xsl:variable name="foo" select="./@key"/>
  <xsl:if test="$document//ltx:bibitem[@key=$foo]">
    <b:Source>
      <b:SourceType>Misc</b:SourceType>
      <b:Tag>
        <xsl:value-of select="./@key"/>
      </b:Tag>
      <b:Author>
        <b:Author>
          <b:NameList>
            <xsl:for-each select="./ltx:bib-name[@role='author' or @role='authors']">
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
    </b:Source> </xsl:if>
  </xsl:template>
  <xsl:template match="ltx:bibentry[@type='misc']">
  <xsl:variable name="foo" select="./@key"/>
  <xsl:if test="$document//ltx:bibitem[@key=$foo]">
    <b:Source>
      <b:SourceType>Misc</b:SourceType>
      <b:Tag>
        <xsl:value-of select="./@key"/>
      </b:Tag>
      <b:Author>
        <b:Author>
          <b:NameList>
            <xsl:for-each select="./ltx:bib-name[@role='author' or @role='authors']">
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
    </b:Source> </xsl:if>
  </xsl:template>
  <xsl:template match="ltx:bibentry[contains(@type,'thesis')]">
    <!-- thesis are best modelled by articles in a journal. Only other options that fit are book and miscellaneous. However misc. doesn't contain the extra information we would want. -->
    <xsl:variable name="foo" select="./@key"/>
  <xsl:if test="$document//ltx:bibitem[@key=$foo]">
    <b:Source>
      <b:SourceType>JournalArticle</b:SourceType>
      <b:Tag>
        <xsl:value-of select="./@key"/>
      </b:Tag>
      <b:Author>
        <b:Author>
          <b:NameList>
            <xsl:for-each select="./ltx:bib-name[@role='author' or @role='authors']">
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
    </b:Source> </xsl:if>
  </xsl:template>
  <xsl:template match="ltx:bibentry[@type='manual']">
  <xsl:variable name="foo" select="./@key"/>
  <xsl:if test="$document//ltx:bibitem[@key=$foo]">
    <b:Source>
      <b:SourceType>Report</b:SourceType>
      <b:Tag>
        <xsl:value-of select="./@key"/>
      </b:Tag>
      <b:Author>
        <b:Author>
          <b:NameList>
            <xsl:for-each select="./ltx:bib-name[@role='author' or @role='authors']">
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
    </b:Source> </xsl:if>
  </xsl:template>
  <xsl:template match="ltx:bibentry[contains(@type,'proceedings')]">
  <xsl:variable name="foo" select="./@key"/>
  <xsl:if test="$document//ltx:bibitem[@key=$foo]">
    <b:Source>
      <b:SourceType>ConferenceProceedings</b:SourceType>
      <b:Tag>
        <xsl:value-of select="./@key"/>
      </b:Tag>
      <b:Author>
        <b:Author>
          <b:NameList>
            <xsl:for-each select="./ltx:bib-name[@role='author' or @role='authors']">
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
    </b:Source> </xsl:if>
  </xsl:template>
  <xsl:template match="ltx:bibentry[@type='incollection']">
  <xsl:variable name="foo" select="./@key"/>
  <xsl:if test="$document//ltx:bibitem[@key=$foo]">
    <b:Source>
      <b:SourceType>BookSection</b:SourceType>
      <b:Tag>
        <xsl:value-of select="./@key"/>
      </b:Tag>
      <b:Author>
        <b:Author>
          <b:NameList>
            <xsl:for-each select="./ltx:bib-name[@role='author' or @role='authors']">
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
    </b:Source> </xsl:if>
  </xsl:template>
  <xsl:template match="ltx:bibentry[@type='booklet']">
  <xsl:variable name="foo" select="./@key"/>
  <xsl:if test="$document//ltx:bibitem[@key=$foo]">
    <b:Source>
      <b:SourceType>Book</b:SourceType>
      <b:Tag>
        <xsl:value-of select="./@key"/>
      </b:Tag>
      <b:Author>
        <b:Author>
          <b:NameList>
            <xsl:for-each select="./ltx:bib-name[@role='author' or @role='authors']">
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
    </b:Source> </xsl:if>
  </xsl:template>
  <xsl:template match="ltx:bibentry[@type='inbook']">
  <xsl:variable name="foo" select="./@key"/>
  <xsl:if test="$document//ltx:bibitem[@key=$foo]">
    <b:Source>
      <b:SourceType>BookSection</b:SourceType>
      <b:Tag>
        <xsl:value-of select="./@key"/>
      </b:Tag>
      <b:Author>
        <b:Author>
          <b:NameList>
            <xsl:for-each select="./ltx:bib-name[@role='author' or @role='authors']">
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
    </b:Source> </xsl:if>
  </xsl:template>
  <xsl:template match="ltx:bibentry[@type='article']">
  <xsl:variable name="foo" select="./@key"/>
  <xsl:if test="$document//ltx:bibitem[@key=$foo]">
    <b:Source>
      <b:SourceType>JournalArticle</b:SourceType>
      <b:Tag>
        <xsl:value-of select="./@key"/>
      </b:Tag>
      <b:Author>
        <b:Author>
          <b:NameList>
            <xsl:for-each select="./ltx:bib-name[@role='author' or @role='authors']">
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
    </b:Source> </xsl:if>
  </xsl:template>
  <xsl:template match="ltx:bib-data[@role='venue']"/>
  
  <xsl:template match="ltx:bib-data[@role='eventdate']"/>
  <xsl:template match="ltx:bib-name[@role='author' or @role='authors']"/>
  <xsl:template match="ltx:bib-extract[@role='keywords']"/>
  <xsl:template match="ltx:bibentry[@type='article']/ltx:bib-url"/>
  <xsl:template match="ltx:bibentry[@type='misc']/ltx:bib-url"/>
  <xsl:template match="ltx:bib-data[@role='eventtitle']"/>
  <xsl:template match="ltx:bib-data[@role='hyphenation']"/>
  <xsl:template match="ltx:bibentry[contains(@type,'thesis')]/ltx:bib-url"/>
  <xsl:template match="ltx:bibentry[@type='inbook' or @type='incollection']/ltx:bib-url"/>
  <xsl:template match="ltx:bib-data[@role='issuetitle']"/>
  <xsl:template match="ltx:bib-identifier[@scheme='isbn']"/>
  <xsl:template match="ltx:bib-identifier[@scheme='issn']"/>
  <xsl:template match="ltx:bib-data[@role='vgwortseiten']"/>
  <xsl:template match="ltx:bibentry[@type='report']/ltx:bib-url"/>
  <xsl:template match="ltx:bib-data[@role='acceptancerate']"/>
  <xsl:template match="ltx:bib-data[@role='acceptanceratecomment']"/>
  <xsl:template match="ltx:bib-identifier[@scheme='doi']"/>
  <xsl:template match="ltx:bib-data[@role='impactfactor']"/>
  <xsl:template match="ltx:bib-data[@role='numpages']"/>
  <xsl:template match="ltx:bib-data[@role='acmid']"/>
  <xsl:template match="ltx:bib-data[@role='editors']"/>
  <xsl:template match="ltx:bib-data[@role='notyetpages']"/>
  <xsl:template match="ltx:bib-data[@role='day']"/>
  <xsl:template match="ltx:bib-data[@role='chrisnote']"/>
  <xsl:template match="ltx:bib-data[@role='notworkingdoi']"/>
  <xsl:template match="ltx:bib-note[@role='annotation']"/>
  <xsl:template match="ltx:bib-data[@role='monty']"/>
  <xsl:template match="ltx:bib-data[@role='lastchecked']"/>
  <xsl:template match="ltx:bib-data[@role='shorthand']"/>
  <xsl:template match="ltx:bib-data[@role='ee']"/>
  <xsl:template match="ltx:bib-data[@role='nuber']"/>
  <xsl:template match="ltx:bib-data[@role='email']"/>
  <xsl:template match="ltx:bib-data[@role='file']"/>
  <xsl:template match="ltx:bib-data[@role='titleat']"/>
  <xsl:template match="ltx:bib-data[@role='pubtype']"/>
  <xsl:template match="ltx:bib-data[@role='hardcopy']"/>
  <xsl:template match="ltx:bib-data[@role='pubstate']"/>
  <xsl:template match="ltx:bib-data[@role='changeurl']"/>
  <xsl:template match="ltx:bib-data[@role='crossre']"/>
  <xsl:template match="ltx:bib-data[@role='sooncrossref']"/>
  <xsl:template match="ltx:bib-data[@role='noturl']"/>
  <xsl:template match="ltx:bib-data[@role='issue']"/>
  <xsl:template match="ltx:bib-data[@role='issue_date']"/>
  <xsl:template match="ltx:bib-data[@role='articleno']"/>
  <xsl:template match="ltx:bib-extract[@role='abstract']"/>
  <xsl:template match="ltx:bib-data[@role='place']"/>
  <xsl:template match="ltx:bib-data[@role='bibsource']"/>
  <xsl:template match="ltx:bib-data[@role='bibstamp']"/>
  <xsl:template match="ltx:bib-data[@role='topics']"/>
  <xsl:template match="ltx:bib-data[@role='nonumber']"/>
  <xsl:template match="ltx:bibentry[@type='manual']/ltx:bib-url"/>
  <xsl:template match="ltx:bib-data[@role='shortauthor']"/>
  <xsl:template match="ltx:bib-data[@role='issn']"/>
  <xsl:template match="ltx:bib-data[@role='priority']"/>
  <xsl:template match="ltx:bib-data[@role='postedat']"/>
  <xsl:template match="ltx:bib-data[@role='booktitle']"/>
  <xsl:template match="ltx:bib-data[@role='projects']"/>
  <xsl:template match="ltx:bib-data[@role='noeditor']"/>
  <xsl:template match="ltx:bib-data[@role='firstkey']"/>
  <xsl:template match="ltx:bib-status"/>
  <xsl:template match="ltx:book-subtitle"/>
  <xsl:template match="ltx:bib-data[@role='bibtype']"/>
  <xsl:template match="ltx:bib-data[@role='caddress']"/>
  <xsl:template match="ltx:bib-data[@role='cmonth']"/>
  <xsl:template match="ltx:bib-data[@role='booksubtitle']"/>
  <xsl:template match="ltx:bib-data[@role='cyear']"/>
  <xsl:template match="ltx:bib-data[@role='pyear']"/>
  <xsl:template match="ltx:bib-data[@role='cnote']"/>
  <xsl:template match="ltx:bib-data[@role='location']"/>
  <xsl:template match="ltx:bib-data[@role='notes']"/>
  <xsl:template match="ltx:bib-data[@role='page']"/>
  <xsl:template match="ltx:bib-language"/>
  <xsl:template match="ltx:bibentry[@type='collection']/ltx:bib-url">
  <b:Url><xsl:value-of select="./text()"/></b:Url>
  </xsl:template>
  <xsl:template match="ltx:bib-data[@role='citeulike-article-id']"/>
  <xsl:template match="ltx:bib-title">
    <b:Title>
      <xsl:value-of select="./text()"/>
      <xsl:value-of select="../ltx:bib-subtitle./text()"/>
    </b:Title>
  </xsl:template>
  <xsl:template match="ltx:bib-subtitle"/>
  <xsl:template match="ltx:bib-related[@role='host' and @type='journal']/ltx:bib-title">
    <b:JournalName>
      <xsl:value-of select="./text()"/>
    </b:JournalName>
  </xsl:template>
  <xsl:template match="ltx:bib-data[@role='journal']">
  <b:JournalName><xsl:value-of select="./text()"/></b:JournalName>
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
  <xsl:template match="ltx:bib-data[@role='label']"/>
  <xsl:template match="ltx:bib-data[@role='pubs']"/>
  <xsl:template match="ltx:bib-note[@role='annotation']"/>
  <xsl:template match="ltx:bib-key"/>
  <xsl:template match="ltx:bib-publisher">
    <b:Publisher>
      <xsl:value-of select="./text()"/>
    </b:Publisher>
  </xsl:template>
  <xsl:template match="ltx:bib-place">
  <b:City><xsl:value-of select="./text()"/></b:City>
  </xsl:template>
  <xsl:template match="ltx:bibentry[@type='article' or contains(@type,'thesis')]/ltx:bib-place"/>
  <xsl:template match="ltx:bib-data[@role='self' and @type='BibTeX']"/>
  <xsl:template match="ltx:bib-related[@role='host' and @type='journal']">
    <xsl:apply-templates/>
  </xsl:template>
  <xsl:template match="ltx:bib-part[@role='volume']"/>
  <xsl:template match="ltx:bib-part[@role='number']"/>
  <xsl:template match="ltx:bib-part[@role='pages' and not(../ltx:bibentry[@type='article' or contains(@type,'proceedings')])]">
    <b:Pages>
      <xsl:value-of select="./text()"/>
    </b:Pages>
  </xsl:template>
  <xsl:template match="ltx:bib-data[@role='month']"/>
  <xsl:template match="ltx:bib-data[@role='address']">
    <b:City>
      <xsl:value-of select="./text()"/>
    </b:City>
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
      <b:BookTitle>
        <xsl:value-of select="./text()"/>
      </b:BookTitle>
    </xsl:if>
  </xsl:template>
  <xsl:template match="ltx:bib-related">
    <xsl:apply-templates/>
  </xsl:template>
  <xsl:template match="ltx:bib-data[@role='laterpages']"/>
  <xsl:template match="ltx:bib-data[@role='latermonth']"/>
  <xsl:template match="ltx:bibentry[@type='unpublished']/ltx:bib-url"/>
  <xsl:template match="ltx:bib-related[@role='host' and @type='proceedings']/ltx:bib-title"/>
  <xsl:template match="ltx:bib-related[@role='host' and @type='proceedings' and not(../ltx:bib-organiation)]/ltx:bib-title">
    <xsl:variable name="foo" select="."/>
    <b:ConferenceName><xsl:value-of select="./text()"/>q	</b:ConferenceName>
  </xsl:template>
  <xsl:template match="ltx:sup">
    <xsl:apply-templates/>
  </xsl:template>
  <xsl:template match="ltx:bib-type"/>
  <xsl:template match="ltx:bib-related[@role='host' and @type='proceedings']">
    <xsl:apply-templates/>
  </xsl:template>
  <xsl:template match="ltx:bib-name[@role='editor']"/>
  <xsl:template match="ltx:bibentry[@type='manual']//ltx:bib-organization">
    <b:Publisher>
      <xsl:value-of select="./text()"/>
    </b:Publisher>
  </xsl:template>
  <xsl:template match="ltx:bibentry[@type='thesis']//ltx:bib-organization">
    <b:Publisher>
      <xsl:value-of select="./text()"/>
    </b:Publisher>
  </xsl:template>
  <xsl:template match="ltx:bibentry[contains(@type,'proceedings')]//ltx:bib-organization">
    <b:ConferenceName>
      <xsl:value-of select="./text()"/>
    </b:ConferenceName>
  </xsl:template>
  <xsl:template match="ltx:bib-links"/>
  <xsl:template match="ltx:bib-data[@role='eprinttype']"/>
  <xsl:template match="ltx:bib-data[@role='eprintclass']"/>
</xsl:stylesheet>
