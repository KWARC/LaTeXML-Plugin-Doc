<?xml version="1.0" encoding="utf-8"?>
<!--
/=====================================================================\ 
|  ltx2word.xsl                                                       |
|  Stylesheet for converting LaTeXML documents to OOXML		      |
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
<xsl:import href="mml2omml.xsl"/>
<xsl:output method="xml" indent="yes"/>
<xsl:strip-space elements="*"/>

<xsl:template match="ltx:equation">
<omml:oMath>
<xsl:apply-templates mode="mml"/>
</omml:oMath>
</xsl:template>
<xsl:template match="ltx:Math">
<omml:oMath>
	<xsl:apply-templates mode="mml"/>
</omml:oMath>
</xsl:template>
<!-- Variables -->
<xsl:variable name="bibliographyreferences"> <!--This is a step on the way to creating a dummy variable like the ones before for references to the bibliography.  -->
<xsl:for-each select="//ltx:cite">
  <xsl:for-each select="./ltx:ref">
    <bibreference>
    <xsl:value-of select="./@idref"/>
    </bibreference>
  </xsl:for-each>
</xsl:for-each>
</xsl:variable>

<xsl:variable name="bibrefs"> <!--Here I am removing duplicates -->
<xsl:for-each select="$bibliographyreferences/bibreference">
  <xsl:if test="not(preceding::bibreference[.=current()])">
    <bibref content="{./text()}"/>
  </xsl:if>
</xsl:for-each>
</xsl:variable>

<!-- End Variables-->
<xsl:template match="ltx:document">
<w:document xmlns:o="urn:schemas-microsoft-com:office:office" xmlns:r="http://schemas.openxmlformats.org/officeDocument/2006/relationships" xmlns:v="urn:schemas-microsoft-com:vml" xmlns:w="http://schemas.openxmlformats.org/wordprocessingml/2006/main" xmlns:w10="urn:schemas-microsoft-com:office:word" xmlns:wp="http://schemas.openxmlformats.org/drawingml/2006/wordprocessingDrawing">
<w:body>
<xsl:apply-templates/>
<xsl:choose>				
	<xsl:when test="./ltx:bibliography/@files='local'">
		<xsl:variable name="foo"><xsl:copy-of select="./ltx:bibliography"/></xsl:variable>
		<xsl:for-each select="$bibrefs/bibref">
			<xsl:apply-templates select="$foo/ltx:bibliography/ltx:biblist/ltx:bibitem[@xml:id=current()/@content]"/>
		</xsl:for-each>
	</xsl:when>
	<xsl:otherwise>
		<xsl:message>Haven't dealt with this case yet </xsl:message>
	</xsl:otherwise>
</xsl:choose>
</w:body>
</w:document>
</xsl:template>

<xsl:template match="ltx:bibliography[@files='local']"/>

<xsl:template match="ltx:bibitem">
<w:p>
	<w:pPr>
		<w:pStyle w:val="Bibliographyitem"/>
	</w:pPr>
	<xsl:apply-templates/>
</w:p>
<w:p>
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

<xsl:template match="ltx:bibtag[@class='ltx_bib_number' and @role='number']">
	<w:bookmarkStart w:id="{generate-id(..)}" w:name="{../@xml:id}"/>
		<xsl:apply-templates/>
	
	<w:bookmarkEnd w:id="{generate-id(..)}"/>
</xsl:template>

<!-- The information what kind of element is in these tags will be saved in the run properties. -->
<xsl:template match="ltx:bibtag[@class='ltx_bib_author' and @role='authors']">
	<xsl:apply-templates/>
</xsl:template>

<xsl:template match="ltx:bibtag[@class='ltx_bib_type']">
	<xsl:apply-templates/>
</xsl:template>

<xsl:template match="ltx:bibtag[@class='ltx_bib_author' and @role='fullauthors']">
	<xsl:apply-templates/>
</xsl:template>

<xsl:template match="ltx:bibtag[@class='ltx_bib_year' and @role='year']">
	<xsl:apply-templates/>
</xsl:template>

<xsl:template match="ltx:bibtag[@class='ltx_bib_title' and @role='title']">
	<xsl:apply-templates/>
</xsl:template>

<xsl:template match="ltx:text[@class='ltx_bib_crossref']">
	<xsl:apply-templates/>
</xsl:template>

<xsl:template match="ltx:bibtag[@class='ltx_bib_key' and @role='refnum']">
	<xsl:apply-templates/>
</xsl:template>

<xsl:template match="ltx:bibtag[@class='ltx_bib_key' and @role='key']">
	<xsl:apply-templates/>
</xsl:template>
<xsl:template match="ltx:cite">
	<xsl:apply-templates/>
</xsl:template>
 
 
 <xsl:template match="ltx:text[@xml:id and @fragid]">
 	<w:bookmarkStart w:id="{generate-id(.)}" w:name="@xml:id"/>
 	<w:bookmarkEnd w:id="{generate-id(.)}"/>
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
  	<w:rFonts w:ascii="smallcaps" w:cs="smallcaps" />
  </xsl:if>
  <xsl:if test="ancestor::*[contains(@font,'bold')]">
    <w:b/> 
  </xsl:if>
  <xsl:if test="ancestor::*[@font='serif' or contains(@font,' serif') or contains(@font,'serif ') and not(contains(@font,'sansserif'))]">
  	<w:rFonts w:ascii="serif" w:cs="serif"/>
  </xsl:if>
  <xsl:if test="ancestor::ltx:text[contains(@font,'typewriter')]">
  	<w:rFonts w:ascii="typewriter" w:cs="typewriter"/>
  </xsl:if>
  <xsl:if test="ancestor::*[contains(@font,'italic')] or ancestor::ltx:emph or ancestor::*[contains(@shape,'italic')]"> 
    <w:i/>
  </xsl:if>
  <xsl:if test="ancestor::*[contains(@framed,'underline')]"> 
    <w:u w:val="single"/> 
  </xsl:if> 
  <xsl:if test="ancestor::ltx:text[contains(@font,'sansserif')]">
    <w:rFonts w:ascii="sansserif" w:cs="sansserif"/>
  </xsl:if>
  <xsl:if test="ancestor::ltx:bibtag[contains(@class,'ltx_bib_number') and @role='number']">
  	<w:rStyle w:val="bibnumber"/>
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
	<xsl:value-of select="translate(.,'&#xa;',' ')"/>
</w:t>
</w:r>
</xsl:template>
<xsl:template match="ltx:creator">
	<xsl:apply-templates/>
</xsl:template>

<xsl:template match="ltx:break">
<w:r>
	<w:br/>
</w:br>
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
		<w:SectPr/> <xsl:comment>This is just to create a new section </xsl:comment>
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

<xsl:template match="ltx:item/ltx:tag">
	<xsl:apply-templates/>
</xsl:template>

<xsl:template match="ltx:item">
<w:p>
	<w:pPr>
		<w:ilvl w:val="{count(ancestor::ltx:enumerate)+1}"/>
		<w:numId w:val="none"/>
		<w:pStyle w:val="empty"/>
	</w:pPr>
</w:p>
<xsl:apply-templates/>
</xsl:template>

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
<w:p>
	<w:pPr>
		<w:pStyle w:val="style0"/>
	</w:pPr>
	<xsl:apply-templates/>
</w:p>
</xsl:template>
<xsl:template match="ltx:resource"/>
<!-- Fallback for debugging -->
<xsl:template match="*">
  <xsl:message>cannot deal with element <xsl:value-of select="local-name()"/> yet!</xsl:message>
  <xsl:comment>elided element <xsl:value-of select="local-name()"/></xsl:comment>
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
	<w:hyperlink w:anchor="{generate-id(.)}"><w:r> <w:rPr> <w:rStyle w:val="superscript"/></w:rPr><w:t> [<xsl:value-of select="./@mark"/>]</w:t></w:r></w:hyperlink>
	<footnote>
	<w:bookmarkStart w:name="{generate-id(.)}" w:id="{generate-id(./text()[1])}"/>
	<w:bookmarkEnd w:id="{generate-id(./text()[1])}"/>
	<xsl:apply-templates/>
	</footnote>
</xsl:template>

<xsl:template match="ltx:ref[@class='ltx_bib_external']">
	<w:hyperlink r:id="{generate-id()}">
		<xsl:apply-templates/>
	</w:hyperlink>
	<external-link>
	<xsl:copy-of select="."/>
	<extra r:id="{generate-id()}"/>
	</external-link>
</xsl:template>

<xsl:template match="ltx:text[@class='ltx_lst_space']">
	<xsl:apply-templates/>
</xsl:template>

<xsl:template match="ltx:enumerate">
	<xsl:apply-templates/>
</xsl:template>

<xsl:template match="ltx:ref[@class='ltx_url']">
	<w:hyperlink r:id="{generate-id()}">
		<xsl:apply-templates/>
	</w:hyperlink>
	<external-link>
		<xsl:copy-of select="."/>
		<extra r:id="{generate-id()}"/>
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
	<xsl:apply-templates/>
</xsl:template>

<xsl:template match="ltx:graphics">
	<pic:pic>
		<pic:nvpicPr/>
		<pic:blipfill>
			<a:blip r:embed="{generate-id()}" cstate="none"/>
		</pic:blipfill>
	</pic:pic>
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
</xsl:template> <!-- I have no idea what this thing does --> 

<xsl:template match="ltx:tabular">
<xsl:variable name="numtcs">
	<xsl:for-each select="./ltx:tr">
		<number>
		<xsl:value-of select="count(./ltx:td)"/>
		</number>
	</xsl:for-each>
</xsl:variable>
<xsl:variable name="foo">
<xsl:for-each select="$numtcs/number">
<xsl:sort select="."/>
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
	<xsl:if test="$i>0">
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
 				<w:vAlign w:val="{@align}"/>
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
 	<xsl:apply-templates/>
 	</w:p>
 	</w:tc>
 </xsl:template>
</xsl:stylesheet>
