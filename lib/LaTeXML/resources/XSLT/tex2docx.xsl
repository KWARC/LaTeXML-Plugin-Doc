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
<xsl:stylesheet xmlns:a="http://schemas.openxmlformats.org/drawingml/2006/main" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:ltx="http://dlmf.nist.gov/LaTeXML" xmlns:o="urn:schemas-microsoft-com:office:office" xmlns:r="http://schemas.openxmlformats.org/officeDocument/2006/relationships" xmlns:v="urn:schemas-microsoft-com:vml" xmlns:m="http://www.w3.org/1998/Math/MathML" xmlns:w="http://schemas.openxmlformats.org/wordprocessingml/2006/main" xmlns:w10="urn:schemas-microsoft-com:office:word" xmlns:wp="http://schemas.openxmlformats.org/drawingml/2006/wordprocessingDrawing" xmlns:pic="http://schemas.openxmlformats.org/drawingml/2006/picture" xmlns:omml="http://schemas.openxmlformats.org/officeDocument/2006/math" version="1.0" exclude-result-prefixes="ltx" xmlns:exsl="http://exslt.org/common">
  <xsl:import href="mml2omml.xsl"/>
  <xsl:output method="xml" indent="yes"/>
  <xsl:strip-space elements="*"/>
  <xsl:template match="ltx:equation">
  <xsl:if test="./@labels">
      <w:bookmarkStart w:id="{./@xml:id}" w:name="{./@labels}"/>
    <w:bookmarkEnd w:id="{./@xml:id}"/>
  </xsl:if>
    <omml:oMath>
      <xsl:apply-templates mode="mml"/>
    </omml:oMath>
  </xsl:template> 

  <xsl:template match="ltx:Math[@mode='inline']">
    <xsl:if test="./@labels">
      <w:bookmarkStart w:id="{./@xml:id}" w:name="{./@labels}"/>
    <w:bookmarkEnd w:id="{./@xml:id}"/>
  </xsl:if>
    <omml:oMath>
      <xsl:apply-templates mode="mml"/>
    </omml:oMath>
  </xsl:template> 

  <xsl:template match="ltx:Math">
   <xsl:if test="./@labels">
  <w:p>
  <w:pPr><w:pStyle w:val="empty"/></w:pPr>
      <w:bookmarkStart w:id="{./@xml:id}" w:name="{./@labels}"/>
    <w:bookmarkEnd w:id="{./@xml:id}"/>
  </w:p>
  </xsl:if>
    <w:p>
      <omml:oMath>
        <xsl:apply-templates mode="mml"/>
      </omml:oMath>
    </w:p>
  </xsl:template> 

  <xsl:template match="ltx:equation[not(ancestor::ltx:p)]">
   <xsl:if test="./@labels">
  <w:p>
  <w:pPr><w:pStyle w:val="empty"/></w:pPr>
      <w:bookmarkStart w:id="{./@xml:id}" w:name="{./@labels}"/>
    <w:bookmarkEnd w:id="{./@xml:id}"/>
  </w:p>
  </xsl:if>
    <w:p>
      <omml:oMath>
        <xsl:apply-templates mode="mml"/>
      </omml:oMath>
    </w:p>
  </xsl:template> 

  <!-- Variables -->
  <!--
<xsl:variable name="bibliographyreferences"> 
<xsl:for-each select="//ltx:cite">
  <xsl:for-each select="./ltx:ref">
    <bibreference>
    <xsl:value-of select="./@idref"/>
    </bibreference>
  </xsl:for-each>
</xsl:for-each>
</xsl:variable> 
-->
  <!-- 
<xsl:variable name="bibrefs"> 
<xsl:for-each select="$bibliographyreferences/bibreference">
  <xsl:if test="not(preceding::bibreference[.=current()])">
    <bibref content="{./text()}"/>
  </xsl:if>
</xsl:for-each>
</xsl:variable> -->
  <!-- End Variables-->
  <xsl:template match="ltx:document">
    <w:document xmlns:o="urn:schemas-microsoft-com:office:office" xmlns:r="http://schemas.openxmlformats.org/officeDocument/2006/relationships" xmlns:v="urn:schemas-microsoft-com:vml" xmlns:w="http://schemas.openxmlformats.org/wordprocessingml/2006/main" xmlns:w10="urn:schemas-microsoft-com:office:word" xmlns:wp="http://schemas.openxmlformats.org/drawingml/2006/wordprocessingDrawing">
      <w:body>
        <xsl:apply-templates/>
      </w:body>
    </w:document>
  </xsl:template> 

  <xsl:template match="ltx:bibitem">
      <w:p>
      <w:pPr>
      	<w:pStyle w:val="empty"/>
      </w:pPr>
     <w:bookmarkStart w:id="{./@xml:id}" w:name="{./@xml:id}"/>
    <w:bookmarkEnd w:id="{./@xml:id}"/>
</w:p>
    <w:p>
      <w:pPr>
        <w:pStyle w:val="Bibliographyitem"/>
      </w:pPr>
      <w:r>
      	<w:rPr>
      		<w:b/>
      	</w:rPr>
      	<w:t>[<xsl:value-of select="./ltx:bibtag[@role='refnum']"/>]</w:t>
      	</w:r>
      <xsl:apply-templates/>
    </w:p>
  </xsl:template> 

  <xsl:template match="ltx:bibblock">
    <xsl:apply-templates/>
  </xsl:template> 

  <!-- Child elements of bibblock -->
  <xsl:template match="ltx:text[@class='ltx_bib_author']">
    <xsl:apply-templates/>
  </xsl:template> 

  <xsl:template match="ltx:text[@font='smallcaps']">
    <xsl:apply-templates/>
  </xsl:template> 

  <xsl:template match="ltx:text[@class='ltx_bib_editor']">
    <xsl:apply-templates/>
  </xsl:template> 

  <xsl:template match="ltx:text[@font='typewriter']">
    <xsl:apply-templates/>
  </xsl:template> 
  
  <xsl:template match="ltx:text[@font='bold italic']">
    <xsl:apply-templates/>
  </xsl:template>
  
  <xsl:template match="ltx:text[@font='medium']">
  	<xsl:apply-templates/>
  </xsl:template>
  
  <xsl:template match="ltx:text">
  	<xsl:apply-templates/>
  	<xsl:message> cannot deal with element <xsl:value-of select="name()"/> yet! </xsl:message>
  	<xsl:comment> Text formatting error here </xsl:comment>
  </xsl:template>

  <xsl:template match="ltx:text[@class='ltx_bib_year']">
    <xsl:apply-templates select="ltx:bib-date"/>
  </xsl:template> 

  <xsl:template match="ltx:bib-date[@role='publication']">
    <xsl:apply-templates/>
  </xsl:template> 

  <xsl:template match="ltx:text[@class='ltx_bib_title']">
    <xsl:apply-templates/>
  </xsl:template> 

  <xsl:template match="ltx:text[@class='ltx_bib_title']/ltx:bib-title">
    <xsl:apply-templates/>
  </xsl:template> 

  <xsl:template match="ltx:text[@class='ltx_bib_note']">
    <xsl:apply-templates/>
  </xsl:template> 

  <xsl:template match="ltx:text[@class='ltx_bib_journal']">
    <xsl:apply-templates/>
  </xsl:template> 

  <xsl:template match="ltx:text[@class='ltx_bib_journal']/ltx:bib-title">
    <xsl:apply-templates/>
  </xsl:template> 

  <xsl:template match="ltx:text[@class='ltx_bib_series']">
    <xsl:apply-templates/>
  </xsl:template> 

  <xsl:template match="ltx:bib-part[@role='series']">
    <xsl:apply-templates/>
  </xsl:template> 

  <xsl:template match="ltx:text[@class='ltx_bib_publisher']">
    <xsl:apply-templates/>
  </xsl:template> 

  <xsl:template match="ltx:bib-publisher">
    <xsl:apply-templates/>
  </xsl:template> 

  <xsl:template match="ltx:text[@class='ltx_bib_etal']">
    <xsl:apply-templates/>
  </xsl:template> 

  <xsl:template match="ltx:text[@class='ltx_bib_links']">
    <xsl:apply-templates/>
  </xsl:template> 

  <xsl:template match="ltx:text[@class='isbn ltx_bib_external']">
    <xsl:apply-templates/>
  </xsl:template> 

  <!-- End of child elements of bibblock -->

  <xsl:template match="ltx:bibliography">
    <xsl:apply-templates/>
  </xsl:template> 

  <xsl:template match="ltx:bibliography/ltx:title">
    <w:p>
      <w:pPr>
        <w:pStyle w:val="style1"/>
      </w:pPr>
      <xsl:apply-templates/>
    </w:p>
  </xsl:template> 

  <xsl:template match="ltx:biblist">
    <xsl:apply-templates/>
  </xsl:template> 
  
  <xsl:template match="ltx:bibtag"/>

  <xsl:template match="ltx:text[@class='ltx_bib_crossref']">
    <xsl:apply-templates/>
  </xsl:template> 

  <xsl:template match="ltx:cite">
    <xsl:apply-templates/>
    <w:r>
      <w:rPr/>
      <w:t xml:space="preserve"> </w:t>
    </w:r>
  </xsl:template> 

  <xsl:template match="ltx:text[@xml:id and @fragid]">
    <w:bookmarkStart w:id="{generate-id(.)}" w:name="@xml:id"/>
    <w:bookmarkEnd w:id="{generate-id(.)}"/>
    <xsl:apply-templates/>
  </xsl:template> 

  <xsl:template match="ltx:document/ltx:title">
    <w:p>
      <w:pPr>
        <w:pStyle w:val="style35"/>
      </w:pPr>
      <xsl:apply-templates/>
    </w:p>
  </xsl:template> 

  <!-- Start of text formatting-->
  <xsl:template match="text()">
    <w:r>
      <w:rPr>
        <xsl:if test="ancestor::ltx:text[contains(@font,'smallcaps')]">
          <w:rFonts w:ascii="smallcaps" w:cs="smallcaps"/>
        </xsl:if>
        <xsl:if test="ancestor::*[contains(@font,'bold')]">
          <w:b/>
        </xsl:if>
        <xsl:if test="ancestor::*[contains(@fontsize,'small')]">
          <w:sz w:val="10"/>
        </xsl:if>
        <xsl:if test="ancestor::*[contains(@fontsize,'footnote')]">
          <w:sz w:val="5"/>
        </xsl:if>
        <xsl:if test="ancestor::*[@font='serif' or contains(@font,' serif') or contains(@font,'serif ') and not(contains(@font,'sansserif'))]">
          <w:rFonts w:ascii="serif" w:cs="serif"/>
        </xsl:if>
        <xsl:if test="ancestor::ltx:text[contains(@font,'typewriter')]">
          <w:rFonts w:ascii="typewriter" w:cs="typewriter"/>
        </xsl:if>
        <xsl:if test="ancestor::*[contains(@font,'italic')] or ancestor::ltx:emph or ancestor::*[contains(@shape,'italic') or contains(@font,'slanted')]">
          <w:i/>
        </xsl:if>
        <xsl:if test="ancestor::*[contains(@framed,'underline')]">
          <w:u w:val="single"/>
        </xsl:if>
        <xsl:if test="ancestor::ltx:text[contains(@font,'sansserif')]">
          <w:rFonts w:ascii="sansserif" w:cs="sansserif"/>
        </xsl:if>
        <xsl:if test="ancestor::ltx:bibtag[contains(@class,'ltx_bib_number') and @role='number']">
          <!--  <w:rStyle w:val="bibnumber"/> -->
          <!-- I should add this back in at some point. I am removing it now to make references look better. -->
        </xsl:if>
        <xsl:if test="ancestor::ltx:bibtag[@class='ltx_bib_author' and @role='authors']">
          <w:rStyle w:val="bibauthor"/>
        </xsl:if>
        <xsl:if test="ancestor::ltx:bibtag[@class='ltx_bib_author' and @role='fullauthors']">
          <w:rStyle w:val="bibfullauthors"/>
        </xsl:if>
        <xsl:if test="ancestor::ltx:bibtag[@class='ltx_bib_year' and @role='year']">
          <w:rStyle w:val="bibyear"/>
        </xsl:if>
        <xsl:if test="ancestor::ltx:bibtag[@class='ltx_bib_title' and @role='title']">
          <w:rStyle w:val="bibtitle"/>
        </xsl:if>
        <xsl:if test="ancestor::ltx:bib-part[@role='series']">
          <w:rStyle w:val="bibseries"/>
        </xsl:if>
        <xsl:if test="ancestor::ltx:bib-publisher">
          <w:rStyle w:val="bibpublisher"/>
        </xsl:if>
        <xsl:if test="ancestor::ltx:text[@class='ltx_bib_links']">
          <w:rStyle w:val="biblinks"/>
        </xsl:if>
        <xsl:if test="ancestor::ltx:text[@class='ltx_bib_author']">
          <w:rStyle w:val="bibauthor2"/>
        </xsl:if>
        <xsl:if test="ancestor::ltx:bibtag[@class='ltx_bib_type']">
          <w:rStyle w:val="bibtype"/>
        </xsl:if>
        <xsl:if test="ancestor::ltxbibtag[@class='ltx_bib_key' and @role='key']">
          <w:rStyle w:val="bibkey"/>
        </xsl:if>
        <xsl:if test="ancestor::ltx:bib-date[@role='publication']">
          <w:rStyle w:val="bibpublicationdate"/>
        </xsl:if>
        <xsl:if test="ancestor::ltx:text[@class='ltx_bib_title']/ltx:bib-title">
          <w:rStyle w:val="bibtitle2"/>
        </xsl:if>
        <xsl:if test="ancestor::ltx:text[@class='ltx_bib_journal']/ltx:bib-title">
          <w:rStyle w:val="bibjournal"/>
        </xsl:if>
        <xsl:if test="ancestor::ltx:bib-part[@role='pages']">
          <w:rStyle w:val="bibpages"/>
        </xsl:if>
        <xsl:if test="ancestor::ltx:bib-part[@role='volume']">
          <w:rStyle w:val="bibvolume"/>
        </xsl:if>
        <xsl:if test="ancestor::ltx:bib-type">
          <w:rStyle w:val="bibtype2"/>
        </xsl:if>
        <xsl:if test="ancestor::ltx:bib-note">
          <w:rStyle w:val="bibnote"/>
        </xsl:if>
        <xsl:if test="ancestor::ltx:bib-place">
          <w:rStyle w:val="bibplace"/>
        </xsl:if>
        <xsl:if test="ancestor::ltx:bib-organization">
          <w:rStyle w:val="biborganization"/>
        </xsl:if>
        <xsl:if test="ancestor::ltx:verbatim">
          <w:rStyle w:val="verbatim"/>
        </xsl:if>
      </w:rPr>
      <w:t>
        <xsl:value-of select="translate(.,'&#10;',' ')"/>
      </w:t>
    </w:r>
  </xsl:template> 

  <xsl:template match="ltx:creator">
    <xsl:apply-templates/>
  </xsl:template> 

  <xsl:template match="ltx:break">
    <w:r>
      <w:br/>
    </w:r>
  </xsl:template> 

  <xsl:template match="ltx:personname">
    <w:p>
      <w:pPr>
        <w:pStyle w:val="style36"/>
      </w:pPr>
      <xsl:apply-templates/>
    </w:p>
  </xsl:template> 

  <xsl:template match="ltx:text[@font='sansserif']">
    <xsl:apply-templates/>
  </xsl:template> 

  <xsl:template match="ltx:text[@font='bold']">
    <xsl:apply-templates/>
  </xsl:template> 

  <xsl:template match="ltx:text[@font='italic']">
    <xsl:apply-templates/>
  </xsl:template> 

  <xsl:template match="ltx:emph">
    <xsl:apply-templates/>
  </xsl:template> 

  <xsl:template match="*[@shape='italic']">
    <xsl:apply-templates/>
  </xsl:template> 

  <xsl:template match="ltx:text[@font='serif bold']">
    <xsl:apply-templates/>
  </xsl:template> 

  <xsl:template match="ltx:text[@framed='underline']">
    <xsl:apply-templates/>
  </xsl:template> 

  <!--End of text formatting -->
  <xsl:template match="ltx:section">
    <w:p>
      <w:pPr>
        <w:pStyle w:val="empty"/>
      </w:pPr>
      <w:bookmarkStart w:name="{@labels}" w:id="{generate-id(.)}"/>
      <w:bookmarkEnd w:id="{generate-id(.)}"/>
    </w:p>
    <xsl:apply-templates/>
    <w:p>
      <w:pPr>
        <w:pStyle w:val="empty"/>
        <w:SectPr/>
        <xsl:comment>This is just to create a new section </xsl:comment>
      </w:pPr>
    </w:p>
  </xsl:template> 

  <xsl:template match="ltx:verbatim">
    <xsl:apply-templates/>
  </xsl:template> 

  <xsl:template match="ltx:para">
    <xsl:apply-templates/>
  </xsl:template> 

  <xsl:template match="ltx:para[@xml:id]">
    <w:p>
      <w:pPr>
        <w:pStyle w:val="empty"/>
      </w:pPr>
      <w:bookmarkStart w:name="{@xml:id}" w:id="{generate-id(.)}"/>
      <w:bookmarkEnd w:id="{generate-id(.)}"/>
    </w:p>
    <xsl:apply-templates/>
  </xsl:template> 

  <xsl:template match="ltx:paragraph">
    <xsl:apply-templates/>
  </xsl:template> 

  <xsl:template match="ltx:section/ltx:title">
    <w:p>
      <w:pPr>
        <w:pStyle w:val="style1"/>
      </w:pPr>
      <xsl:apply-templates/>
    </w:p>
  </xsl:template> 

  <xsl:template match="ltx:tag"/>

  <xsl:template match="ltx:paragraph/ltx:title">
    <w:p>
      <w:pPr>
        <w:pStyle w:val="Paragraphtitle"/>
      </w:pPr>
      <xsl:apply-templates/>
    </w:p>
  </xsl:template> 

  <xsl:template match="ltx:subsection">
    <w:p>
      <w:pPr>
        <w:pStyle w:val="empty"/>
      </w:pPr>
      <w:bookmarkStart w:name="{@labels}" w:id="{generate-id(.)}"/>
      <w:bookmarkEnd w:id="{generate-id(.)}"/>
    </w:p>
    <xsl:apply-templates/>
  </xsl:template> 

  <xsl:template match="ltx:subsection/ltx:title">
    <w:p>
      <w:pPr>
        <w:pStyle w:val="style2"/>
      </w:pPr>
      <xsl:apply-templates/>
    </w:p>
  </xsl:template> 

  <xsl:template match="ltx:quote/ltx:p">
    <w:p>
      <w:pPr>
        <w:pStyle w:val="quote"/>
      </w:pPr>
      <xsl:apply-templates/>
    </w:p>
  </xsl:template> 

 <xsl:template match="ltx:p">
  <xsl:if test="./ltx:tabular">
      <w:p>
      <w:pPr>
        <w:pStyle w:val="style46"/>
      </w:pPr> 
      <xsl:apply-templates select="/ltx:tabular/preceding-sibling::*"/>
    </w:p>
    <xsl:apply-templates select="ltx:tabular"/>
    <w:p>
      <w:pPr>
        <w:pStyle w:val="style46"/>
      </w:pPr>
      <xsl:apply-templates select="/ltx:tabular/following-sibling::*"/>
    </w:p> 
  </xsl:if>
  <xsl:if test="not(./ltx:tabular)">
    <w:p>
      <w:pPr>
        <w:pStyle w:val="style0"/>
      </w:pPr>
      <xsl:apply-templates/>
    </w:p>
  </xsl:if>
  </xsl:template> 
  <xsl:template match="ltx:resource"/>
  <!-- Fallback for debugging -->
<xsl:template match="*">
    <xsl:message>cannot deal with element <xsl:value-of select="local-name()"/> yet!</xsl:message>
    <xsl:comment>elided element <xsl:value-of select="local-name()"/></xsl:comment>
     <xsl:if test="ancestor::ltx:p">
 <w:r>
  <w:rPr>
        <w:color w:val="FF0000"/>
        </w:rPr>
 <w:t>  <xsl:value-of select="local-name()"/> was not transformed </w:t>
</w:r>
</xsl:if>
<xsl:if test="not(ancestor::ltx:p)">
<w:p>
 <w:r>
  <w:rPr>
        <w:color w:val="FF0000"/>
        </w:rPr>
 <w:t> Error: <xsl:value-of select="local-name()"/> </w:t>
</w:r>
</w:p>
</xsl:if>
  </xsl:template> 
  <xsl:template match="ltx:ref[@labelref]">
    <w:hyperlink w:anchor="{@labelref}">
      <xsl:apply-templates/>
    </w:hyperlink>
  </xsl:template> 

  <xsl:template match="ltx:ref[@idref]">
    <w:hyperlink w:anchor="{@idref}">
      <xsl:apply-templates/>
    </w:hyperlink>
  </xsl:template> 

  <xsl:template match="ltx:note[@role='footnote']">
        <w:r>
        <w:rPr>
          <w:rStyle w:val="FootnoteReference"/>
        </w:rPr>
        <w:footnoteReference w:id="{count(preceding::ltx:note[@role='footnote'])}"/>
        <footnote w:id="{count(preceding::ltx:note[@role='footnote'])}">
          <xsl:apply-templates/>
        </footnote>
      </w:r>
  </xsl:template>
  <xsl:template match="ltx:ref[@class='ltx_bib_external']">
    <w:hyperlink r:id="{generate-id()}">
      <xsl:apply-templates/>
    </w:hyperlink>
    <external-link>
      <xsl:copy-of select="."/>
      <extra id="{generate-id()}"/>
    </external-link>
  </xsl:template> 

  <xsl:template match="ltx:text[@class='ltx_lst_space']">
    <xsl:apply-templates/>
  </xsl:template> 


  <xsl:template match="ltx:ref[@class='ltx_url']">
    <w:hyperlink r:id="{generate-id()}">
      <xsl:apply-templates/>
    </w:hyperlink>
    <external-link>
      <xsl:copy-of select="."/>
      <extra id="{generate-id()}"/>
    </external-link>
  </xsl:template> 

  <xsl:template match="ltx:text[@class='ltx_ref_tag']">
    <xsl:apply-templates/>
  </xsl:template> 

  <xsl:template match="ltx:text[@class='ltx_bib_pages']">
    <xsl:apply-templates/>
  </xsl:template> 

  <xsl:template match="ltx:bib-part[@role='pages']">
    <xsl:apply-templates/>
  </xsl:template> 

  <xsl:template match="ltx:text[@class='ltx_bib_volume']">
    <xsl:apply-templates/>
  </xsl:template> 

  <xsl:template match="ltx:bib-part[@role='volume']">
    <xsl:apply-templates/>
  </xsl:template> 

  <xsl:template match="ltx:text[@class='ltx_bib_type']">
    <xsl:apply-templates/>
  </xsl:template> 

  <xsl:template match="ltx:bib-type">
    <xsl:apply-templates/>
  </xsl:template> 

  <xsl:template match="ltx:bib-note">
    <xsl:apply-templates/>
  </xsl:template> 

  <xsl:template match="ltx:text[@class='ltx_bib_place']">
    <xsl:apply-templates/>
  </xsl:template> 

  <xsl:template match="ltx:bib-place">
    <xsl:apply-templates/>
  </xsl:template> 

  <xsl:template match="ltx:bib-organization">
    <xsl:apply-templates/>
  </xsl:template> 

  <xsl:template match="ltx:figure">
    <w:p>
      <w:pPr>
        <w:pStyle w:val="empty"/>
      </w:pPr>
      <w:bookmarkStart w:name="{@labels}" w:id="{generate-id(.)}"/>
      <w:bookmarkEnd w:id="{generate-id(.)}"/>
    </w:p>
    <w:p>
    <xsl:apply-templates/>
    </w:p>
  </xsl:template> 

  <xsl:template match="ltx:graphics[ancestor::ltx:figure]">
      <w:r>
        <w:drawing>
          <wp:anchor distT="0" distB="0" distL="0" distR="0" simplePos="0" relativeHeight="251658240" behindDoc="0" locked="0" layoutInCell="1" allowOverlap="1">
            <wp:simplePos x="1847850" y="914400"/>
            <xsl:if test="../@placement='h'">
              <wp:positionH relativeFrom="character">
                <wp:align>left</wp:align>
              </wp:positionH>
              <wp:positionV relativeFrom="paragraph">
                <wp:align>top</wp:align>
              </wp:positionV>
            </xsl:if>
            <xsl:if test="../@placement='t'">
              <wp:positionH relativeFrom="margin">
                <wp:align>left</wp:align>
              </wp:positionH>
              <wp:positionV relativeFrom="margin">
                <wp:align>top</wp:align>
              </wp:positionV>
            </xsl:if>
            <xsl:if test="../@placement='b'">
              <wp:positionH relativeFrom="margin">
                <wp:align>left</wp:align>
              </wp:positionH>
              <wp:positionV relativeFrom="margin">
                <wp:align>bottom</wp:align>
              </wp:positionV>
            </xsl:if>
            <xsl:if test="../@placement='p'">
              <wp:positionH relativeFrom="margin">
                <wp:align>left</wp:align>
              </wp:positionH>
              <wp:positionV relativeFrom="page">
                <wp:align>outside</wp:align>
              </wp:positionV>
            </xsl:if>
            <wp:extent cx="{format-number(9525*@imagewidth,'#')}" cy="{format-number(9525*@imageheight,'#')}"/>
            <wp:effectExtent l="0" t="0" r="0" b="0"/>
            <!-- I copied this in from a version that Word fixed -->
            <wp:wrapSquare wrapText="bothSides"/>
            <wp:docPr id="1" name="Picture 0" descr="Blue hills.jpg"/>
            <wp:cNvGraphicFramePr>
              <a:graphicFrameLocks xmlns:a="http://schemas.openxmlformats.org/drawingml/2006/main" noChangeAspect="1"/>
            </wp:cNvGraphicFramePr>
            <a:graphic xmlns:a="http://schemas.openxmlformats.org/drawingml/2006/main">
              <a:graphicData uri="http://schemas.openxmlformats.org/drawingml/2006/picture">
                <pic:pic xmlns:pic="http://schemas.openxmlformats.org/drawingml/2006/picture">
                  <pic:nvPicPr>
                    <pic:cNvPr id="0" name="don't know what I should write here"/>
                    <!-- not deletable, however I can change both the name and id properties. -->
                    <pic:cNvPicPr/>
                    <!-- not removable either -->
                  </pic:nvPicPr>
                  <pic:blipFill>
                    <xsl:variable name="foo" select="generate-id(.)"/>
                    <a:blip r:embed="{$foo}"/>
                    <!-- This encodes what picture to actually take, by the id specified in document.xml.rels " -->
                    <picturus id="{$foo}" reference="{concat('media/',@candidates)}"/>
                    <a:stretch>
                      <a:fillRect/>
                      <!-- This stuff tells Word to stretch the image to the frame size -->
                    </a:stretch>
                  </pic:blipFill>
                  <pic:spPr>
                    <a:xfrm>
                      <a:off x="0" y="0"/>
                      <!-- offset. Is deletable if there is no offset. -->
                      <a:ext cx="{9525*@imagewidth}" cy="{9525*@imageheight}"/>
                      <!-- I think this is just the size of theS1.Thmlemma1.p1 frame or something. Is deletable and values are changable, however there is no real picture if the values differ relevantly from the size of the frame given beforehand. Don't mess around with it I guess -->
                    </a:xfrm>
                    <a:prstGeom prst="rect">
                      <a:avLst/>
                    </a:prstGeom>
                  </pic:spPr>
                </pic:pic>
              </a:graphicData>
            </a:graphic>
          </wp:anchor>
        </w:drawing>
      </w:r>
  </xsl:template> 

  <xsl:template match="ltx:graphics[ancestor::ltx:p]">
    <w:r>
      <w:drawing>
        <wp:inline distT="0" distB="0" distL="0" distR="0">
          <wp:extent cx="{format-number(9525*@imagewidth,'#')}" cy="{format-number(9525*@imageheight,'#')}"/>
          <wp:docPr id="1" name="Picture 0" descr="dot_green.png"/>
          <a:graphic xmlns:a="http://schemas.openxmlformats.org/drawingml/2006/main">
            <a:graphicData uri="http://schemas.openxmlformats.org/drawingml/2006/picture">
              <pic:pic xmlns:pic="http://schemas.openxmlformats.org/drawingml/2006/picture">
                <pic:nvPicPr>
                  <pic:cNvPr id="0" name="don't know what I should write here"/>
                  <!-- not deletable, however I can change both the name and id properties. -->
                  <pic:cNvPicPr/>
                  <!-- not removable either -->
                </pic:nvPicPr>
                <pic:blipFill>
                  <xsl:variable name="foo" select="generate-id(.)"/>
                  <a:blip r:embed="{$foo}"/>
                  <!-- This encodes what picture to actually take, by the id specified in document.xml.rels " -->
                  <picturus id="{$foo}" reference="{concat('media/',@candidates)}"/>
                  <a:stretch>
                    <a:fillRect/>
                    <!-- This stuff tells Word to stretch the image to the frame size -->
                  </a:stretch>
                </pic:blipFill>
                <pic:spPr>
                  <a:xfrm>
                    <a:off x="0" y="0"/>
                    <!-- offset. Is deletable if there is no offset. -->
                    <a:ext cx="{9525*@imagewidth}" cy="{9525*@imageheight}"/>
                    <!-- I think this is just the size of the frame or something. Is deletable and values are changable, however there is no real picture if the values differ relevantly from the size of the frame given beforehand. Don't mess around with it I guess -->
                  </a:xfrm>
                  <a:prstGeom prst="rect">
                    <a:avLst/>
                  </a:prstGeom>
                </pic:spPr>
              </pic:pic>
            </a:graphicData>
          </a:graphic>
        </wp:inline>
      </w:drawing>
    </w:r>
  </xsl:template> 

  <xsl:template match="ltx:graphics">
    <!-- These are probably not inline, but I am treating them as inline for this period. -->
    <w:p>
      <w:r>
        <w:rPr/>
        <w:drawing>
          <wp:inline distT="0" distB="0" distL="0" distR="0">
            <wp:extent cx="{format-number(9525*@imagewidth,'#')}" cy="{format-number(9525*@imageheight,'#')}"/>
            <wp:docPr id="1" name="Picture 0" descr="dot_green.png"/>
            <a:graphic xmlns:a="http://schemas.openxmlformats.org/drawingml/2006/main">
              <a:graphicData uri="http://schemas.openxmlformats.org/drawingml/2006/picture">
                <pic:pic xmlns:pic="http://schemas.openxmlformats.org/drawingml/2006/picture">
                  <pic:nvPicPr>
                    <pic:cNvPr id="0" name="don't know what I should write here"/>
                    <!-- not deletable, however I can change both the name and id properties. -->
                    <pic:cNvPicPr/>
                    <!-- not removable either -->
                  </pic:nvPicPr>
                  <pic:blipFill>
                    <xsl:variable name="foo" select="generate-id(.)"/>
                    <a:blip r:embed="{$foo}"/>
                    <!-- This encodes what picture to actually take, by the id specified in document.xml.rels " -->
                    <picturus id="{$foo}" reference="{concat('media/',@candidates)}"/>
                    <a:stretch>
                      <a:fillRect/>
                      <!-- This stuff tells Word to stretch the image to the frame size -->
                    </a:stretch>
                  </pic:blipFill>
                  <pic:spPr>
                    <a:xfrm>
                      <a:off x="0" y="0"/>
                      <!-- offset. Is deletable if there is no offset. -->
                      <a:ext cx="{9525*@imagewidth}" cy="{9525*@imageheight}"/>
                      <!-- I think this is just the size of the frame or something. Is deletable and values are changable, however there is no real picture if the values differ relevantly from the size of the frame given beforehand. Don't mess around with it I guess -->
                    </a:xfrm>
                    <a:prstGeom prst="rect">
                      <a:avLst/>
                    </a:prstGeom>
                  </pic:spPr>
                </pic:pic>
              </a:graphicData>
            </a:graphic>
          </wp:inline>
        </w:drawing>
      </w:r>
    </w:p>
  </xsl:template> 

  <xsl:template match="ltx:caption">
    <xsl:apply-templates/>
  </xsl:template> 

  <xsl:template match="ltx:toccaption"/>
  <xsl:template match="ltx:text[@class='ltx_lstlisting ltx_lst_language_MathML' and not(@font)]">
    <xsl:apply-templates/>
  </xsl:template> 

  <xsl:template match="ltx:listingblock">
    <xsl:apply-templates/>
  </xsl:template> 

  <!-- I have no idea what this thing does -->
  <xsl:template match="ltx:tabular">
    <xsl:variable name="numtcs">
      <xsl:for-each select="./ltx:tr">
        <number>
          <xsl:value-of select="count(./ltx:td)"/>
        </number>
      </xsl:for-each>
    </xsl:variable>
    <xsl:variable name="foo">
      <!-- <xsl:for-each select="$numtcs/number"> -->
      <xsl:for-each select="./ltx:tr">
        <xsl:sort select="count(./ltx:td) "/>
        <xsl:if test="position()=last()">
          <xsl:value-of select="."/>
        </xsl:if>
      </xsl:for-each>
    </xsl:variable>
    <w:tbl>
      <w:tblGrid>
        <xsl:call-template name="ntimes">
          <xsl:with-param name="i" select="number($foo)"/>
        </xsl:call-template>
      </w:tblGrid>
      <xsl:apply-templates/>
    </w:tbl>
  </xsl:template> 

  <xsl:template name="ntimes">
    <xsl:param name="i"/>
    <xsl:if test="$i&gt;0">
      <w:gridCol/>
      <xsl:call-template name="ntimes">
        <xsl:with-param name="i" select="$i - 1"/>
      </xsl:call-template>
    </xsl:if>
    <xsl:if test="$i = 0">
   </xsl:if>
  </xsl:template> 

  <xsl:template match="ltx:tr">
    <w:tr>
      <xsl:apply-templates/>
    </w:tr>
  </xsl:template> 

  <xsl:template match="ltx:tbody">
    <xsl:apply-templates/>
  </xsl:template> 

  <xsl:template match="ltx:thead">
    <xsl:apply-templates/>
  </xsl:template> 

  <xsl:template match="ltx:abstract">
    <xsl:apply-templates/>
  </xsl:template> 

  <xsl:template match="ltx:abstract/ltx:p">
    <w:p>
      <w:pPr>
        <w:pStyle w:val="style46"/>
      </w:pPr>
      <xsl:if test="preceding::ltx:abstract/ltx:p">
        <w:r>
          <w:rPr>
            <w:b/>
          </w:rPr>
          <w:t>
            <xsl:choose>
              <xsl:when test="parent/@name">
                <xsl:value-of select="parent/@name"/>
              </xsl:when>
              <xsl:otherwise>
          Abstract
        </xsl:otherwise>
            </xsl:choose>
          </w:t>
        </w:r>
      </xsl:if>
      <xsl:apply-templates/>
    </w:p>
  </xsl:template> 

  <xsl:template match="ltx:quote">
    <xsl:apply-templates/>
  </xsl:template> 

  <xsl:template match="ltx:td">
    <w:tc>
      <w:tcPr>
        <xsl:if test="@colspan">
          <w:gridSpan w:val="{@colspan}"/>
        </xsl:if>
        <xsl:if test="@rowspan">
          <!-- I can't deal with spanning rows yet. I will have to take a closer look at this later -->
        </xsl:if>
         <xsl:if test="@align">
        <xsl:if test="not(@align='justify')">
          <w:vAlign w:val="{@align}"/>
        </xsl:if>
        <xsl:if test="@align='justify'">
          <w:vAlign w:val="both"/>
        </xsl:if>
        </xsl:if>
        <xsl:if test="thead='true'">
          <w:rStyle w:val="tablehead"/>
        </xsl:if>
        <xsl:if test="@border">
          <w:tcborders>
            <xsl:if test="contains(@border,'l')">
              <w:start w:val="single"/>
            </xsl:if>
            <xsl:if test="contains(@border,'ll')">
              <w:start w:val="double"/>
            </xsl:if>
            <xsl:if test="contains(@border,'t')">
              <w:top w:val="single"/>
            </xsl:if>
            <xsl:if test="contains(@border,'t')">
              <w:top w:val="double"/>
            </xsl:if>
            <xsl:if test="contains(@border,'r')">
              <w:end w:val="single"/>
            </xsl:if>
            <xsl:if test="contains(@border,'rr')">
              <w:end w:val="double"/>
            </xsl:if>
            <xsl:if test="contains(@border,'b')">
              <w:bottom w:val="single"/>
            </xsl:if>
            <xsl:if test="contains(@border,'bb')">
              <w:bottom w:val="double"/>
            </xsl:if>
          </w:tcborders>
        </xsl:if>
        <xsl:choose>
          <xsl:when test="@width">
            <w:tcW w:type="dxa" w:w="{20*@width}"/>
          </xsl:when>
          <xsl:otherwise>
            <w:tcW w:type="auto"/>
          </xsl:otherwise>
        </xsl:choose>
      </w:tcPr>
      <w:p>
       <w:pPr>
          <w:ind w:firstLine="0"/>
        </w:pPr>
        <xsl:apply-templates/>
      </w:p>
    </w:tc>
  </xsl:template> 
  <!-- ======================================================================================================================================================================== -->
  <xsl:template match="ltx:theorem">
      <xsl:apply-templates/>
  </xsl:template> 

  <xsl:template match="ltx:theorem/ltx:title">
<w:p>
  <xsl:apply-templates/>
</w:p>
  </xsl:template> 

  <xsl:template match="ltx:equationgroup">
  <xsl:apply-templates/>
  </xsl:template> 
  <xsl:template match="ltx:toctitle"/>
  <xsl:template match="ltx:acknowledgements">
  <w:p>
  	<w:pPr>
  		<w:pStyle w:val="acknowledgments"/>
  	</w:pPr>
  <xsl:apply-templates/>
  </w:p>
  </xsl:template>

  <xsl:template match="ltx:contact">
  <w:p>
  	<w:pPr>
  		<w:pStyle w:val="contact"/>
  	</w:pPr>
  <xsl:apply-templates/>
  </w:p>
  </xsl:template>
  <xsl:template match="ltx:note"/>
  <xsl:template match="ltx:date"/>
  <xsl:template match="ltx:title/ltx:tag">
  <w:r>
  <w:t xml:space="preserve">
  <xsl:value-of select="concat(./text(),' ')"/>
  </w:t>
  </w:r>
  </xsl:template>
 
  <xsl:template match="ltx:table">
  <w:p>
  <xsl:apply-templates/>
  </w:p>
  </xsl:template>
  <xsl:template match="ltx:text[@fontsize='footnote']">
  <xsl:apply-templates/>
  </xsl:template>
  <xsl:template match="ltx:ref[not(@labelref) and not(@idref) and @href]">
      <w:hyperlink r:id="{generate-id()}">
      <xsl:apply-templates/>
    </w:hyperlink>
    <external-link>
      <xsl:copy-of select="."/>
      <extra id="{generate-id()}"/>
    </external-link>
    </xsl:template>
    <xsl:template match="ltx:text[@fontsize='small']">
    <xsl:apply-templates/>
    </xsl:template>
   <xsl:template match="ltx:appendix">
  <xsl:if test="./@labels">
  <w:p>
  <w:pPr><w:pStyle w:val="empty"/></w:pPr>
      <w:bookmarkStart w:id="{./@xml:id}" w:name="{./@labels}"/>
    <w:bookmarkEnd w:id="{./@xml:id}"/>
  </w:p>
  </xsl:if>
   <xsl:apply-templates/>
   </xsl:template>
   <xsl:template match="ltx:appendix/ltx:title">
     <w:p>
      <w:pPr>
        <w:pStyle w:val="style1"/>
      </w:pPr>
      <xsl:apply-templates/>
    </w:p>
   </xsl:template>
   <xsl:template match="ltx:titlepage">
   <xsl:apply-templates/>
   </xsl:template>
   <xsl:template match="ltx:pagination[@role='newpage']">
   <w:p>
   <w:r>
   <w:break type="page"/>
   </w:r>
   </w:p>
   </xsl:template>
  <xsl:template match="ltx:subsubsection"> 
   <w:p>
      <w:pPr>
        <w:pStyle w:val="empty"/>
      </w:pPr>
      <w:bookmarkStart w:name="{@labels}" w:id="{generate-id(.)}"/>
      <w:bookmarkEnd w:id="{generate-id(.)}"/>
    </w:p>
    <xsl:apply-templates/>
  </xsl:template> 

  <xsl:template match="ltx:subsubsection/ltx:title">
    <w:p>
      <w:pPr>
        <w:pStyle w:val="style3"/>
      </w:pPr>
      <xsl:apply-templates/>
    </w:p>
  </xsl:template> 
  <xsl:template match="ltx:break[not(parent::ltx:p)]"/>
  <xsl:template match="ltx:text[@font='slanted']">
  <xsl:apply-templates/>
  </xsl:template>
   <xsl:template match="ltx:proof">
      <xsl:apply-templates/>
  </xsl:template> 

  <xsl:template match="ltx:proof/ltx:title">
<w:p>
  <xsl:apply-templates/>
</w:p>
  </xsl:template> 
  <!-- 
  <xsl:template match="ltx:itemize">
  <xsl:variable name="foo">
  <xsl:for-each select=".//ltx:item">
  <item> <xsl:copy-of select=".//ltx:p"/> </item>
  </xsl:for-each>
  </xsl:variable>
  <xsl:copy-of select="exsl:node-set($foo)"/> 
  </xsl:template> --> 
  <xsl:template match="ltx:itemize">
   <xsl:apply-templates/>
  </xsl:template>
  <xsl:template match="ltx:item">
   <w:p w:rsidR="00847883" w:rsidRDefault="00E521C7" w:rsidP="00E521C7">
      <w:pPr>
        <w:pStyle w:val="ListParagraph"/>
        <w:numPr>
          <w:ilvl w:val="{count(ancestor::ltx:itemize)+count(ancestor::ltx:enumerate)-1}"/>
          <w:numId w:val="1"/>
        </w:numPr>
      </w:pPr>
      <xsl:apply-templates select="./ltx:para/ltx:p"/>
    </w:p>
    <xsl:apply-templates select=".//ltx:itemize"/>
    <xsl:apply-templates select=".//ltx:enumerate"/>
  </xsl:template>
  <xsl:template match="ltx:item/ltx:para/ltx:p">
  <xsl:apply-templates/>
  </xsl:template>
  
    <xsl:template match="ltx:enumerate">
   <xsl:apply-templates/>
  </xsl:template>
  
  <xsl:template match="ltx:item[(count(ancestor::ltx:itemize)+count(ancestor::ltx:enumerate))=1]">
  <xsl:variable name="foo">
  <xsl:for-each select="..//ltx:item">
  <xsl:if test="position()=1">
    <xsl:value-of select="count(preceding::ltx:item)"/>
  </xsl:if>
  </xsl:for-each>
  </xsl:variable>
   <w:p w:rsidR="00847883" w:rsidRDefault="00E521C7" w:rsidP="00E521C7">
      <w:pPr>
        <w:pStyle w:val="ListParagraph"/>
        <w:numPr>
          <w:ilvl w:val="{count(ancestor::ltx:itemize)+count(ancestor::ltx:enumerate)-1}"/>
          <xsl:if test="$foo=0">
          <w:numId w:val="1"/>
          </xsl:if>
          <xsl:if test="$foo>0">
          <w:numId w:val="{$foo}"/>
          </xsl:if>
        </w:numPr>
      </w:pPr>
      <xsl:apply-templates select="./ltx:para/ltx:p"/>
    </w:p>
    <xsl:apply-templates select=".//ltx:itemize"/>
    <xsl:apply-templates select=".//ltx:enumerate"/>
  </xsl:template>
  <xsl:template match="ltx:item/ltx:para/ltx:p">
  <xsl:apply-templates/>
  </xsl:template>
 
 <xsl:template match="ltx:figure/ltx:p"/>
 <xsl:template match="ltx:rule"/>
 <xsl:template match="ltx:inline-block">
 	<xsl:apply-templates/>
 </xsl:template>
 <xsl:template match="ltx:XMHint"/>
   <xsl:template match="ltx:ERROR">
 <xsl:message> An Error occurred here </xsl:message>
 <xsl:if test="ancestor::ltx:p">
 <w:r>
  <w:rPr>
        <w:color w:val="FF0000"/>
        </w:rPr>
 <w:t> Error: <w:value-of select="./text()"/> </w:t>
</w:r>
</xsl:if>
<xsl:if test="not(ancestor::ltx:p)">
<w:p>
 <w:r>
  <w:rPr>
        <w:color w:val="FF0000"/>
        </w:rPr>
 <w:t> Error: <xsl:value-of select="./text()"/> </w:t>
</w:r>
</w:p>
</xsl:if>
</xsl:template>
  <xsl:template match="ltx:TOC">
      <w:sdt>
      <w:sdtPr>
        <w:id w:val="1841044555"/>
        <w:docPartObj>
          <w:docPartGallery w:val="Table of Contents"/>
          <w:docPartUnique/>
        </w:docPartObj>
      </w:sdtPr>
      <w:sdtEndPr>
        <w:rPr>
          <w:rFonts w:asciiTheme="minorHAnsi" w:eastAsiaTheme="minorEastAsia" w:hAnsiTheme="minorHAnsi" w:cstheme="minorBidi"/>
          <w:noProof/>
          <w:color w:val="auto"/>
          <w:sz w:val="22"/>
          <w:szCs w:val="22"/>
          <w:lang w:eastAsia="en-US"/>
        </w:rPr>
      </w:sdtEndPr>
      <w:sdtContent>
        <w:p w:rsidR="00E4086D" w:rsidRDefault="00E4086D">
          <w:pPr>
            <w:pStyle w:val="TOCHeading"/>
          </w:pPr>
          <w:r>
            <w:t>Contents</w:t>
          </w:r>
          <w:bookmarkStart w:id="0" w:name="_GoBack"/>
          <w:bookmarkEnd w:id="0"/>
        </w:p>
        <w:p w:rsidR="00E4086D" w:rsidRDefault="00E4086D">
          <w:pPr>
            <w:pStyle w:val="TOC1"/>
            <w:tabs>
              <w:tab w:val="right" w:leader="dot" w:pos="9350"/>
            </w:tabs>
            <w:rPr>
              <w:noProof/>
            </w:rPr>
          </w:pPr>
          <w:r>
            <w:fldChar w:fldCharType="begin"/>
          </w:r>
          <w:r>
            <w:instrText xml:space="preserve"> TOC \o "1-3" \h \z \u </w:instrText>
          </w:r>
          <w:r>
            <w:fldChar w:fldCharType="separate"/>
          </w:r>
        </w:p>
        <w:p w:rsidR="00E4086D" w:rsidRDefault="00E4086D">
          <w:r>
            <w:rPr>
              <w:b/>
              <w:bCs/>
              <w:noProof/>
            </w:rPr>
            <w:fldChar w:fldCharType="end"/>
          </w:r>
        </w:p>
      </w:sdtContent>
    </w:sdt>
    </xsl:template>
</xsl:stylesheet>
