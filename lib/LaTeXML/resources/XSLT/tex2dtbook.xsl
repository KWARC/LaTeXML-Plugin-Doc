<?xml version="1.0" encoding="utf-8"?>
<!--
/=====================================================================\ 
|  ltx2word.xsl                                                       |
|  Stylesheet for converting LaTeXML documents to DTBook              |
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
    xmlns:m="http://www.w3.org/1998/Math/MathML"
    xmlns="http://www.daisy.org/z3986/2005/dtbook/"
    exclude-result-prefixes = "ltx"	>
    <xsl:output method="xml" indent="yes"/>
    <xsl:strip-space elements="*"/>
  
  <!-- Fallback for debugging -->  
  <xsl:template match="*">
    <xsl:message>cannot deal with element <xsl:value-of select="local-name()"/> yet!</xsl:message>
    <xsl:comment>cannot deal with element <xsl:value-of select="local-name()"/> here yet!</xsl:comment>
  </xsl:template> 
  
    <xsl:template match="/">
    <xsl:text disable-output-escaping='yes'>
   &lt;!DOCTYPE dtbook PUBLIC "-//NISO//DTD dtbook 2005-2//EN" "http://www.daisy.org/z3986/2005/dtbook-2005-2.dtd" [
  &lt;!ENTITY % MATHML.prefixed "INCLUDE" >
  &lt;!ENTITY % MATHML.prefix "m">
  &lt;!ENTITY % MATHML.Common.attrib
          "xlink:href    CDATA       #IMPLIED
          xlink:type     CDATA       #IMPLIED	
          class          CDATA       #IMPLIED
          style          CDATA       #IMPLIED
          id             ID          #IMPLIED
          xref           IDREF       #IMPLIED
          other          CDATA       #IMPLIED
          xmlns:dtbook   CDATA       #FIXED	'http://www.daisy.org/z3986/2005/dtbook/'
          dtbook:smilref CDATA       #IMPLIED"
  >    
  &lt;!ENTITY % mathML2 PUBLIC "-//W3C//DTD MathML 2.0//EN"
             "http://www.w3.org/Math/DTD/mathml2/mathml2.dtd"
  >
  %mathML2;        
  &lt;!ENTITY % externalFlow "| m:math">
  &lt;!ENTITY % externalNamespaces "xmlns:m CDATA #FIXED 'http://www.w3.org/1998/Math/MathML'">      
 ]
>
</xsl:text>
 	<xsl:apply-templates/>
    </xsl:template>
    
    <xsl:template match="ltx:document">
    <dtbook xml:lang="en-US" version="2005-2">
    	<head>
		<!-- TODO find out whether I can find out the language" -->
		<xsl:if test="//ltx:document/ltx:title">
		<meta name="dc:Title" content="{//ltx:document/ltx:title/text()}" />
		</xsl:if>
		<xsl:if test="//ltx:document/ltx:creator[@role='author']">
		<meta name="dc:Creator" content="{//ltx:document/ltx:creator[@role='author']/ltx:personname/text()}" />
		</xsl:if>
		<meta name="dc:Format" content="ANSI/NISO Z39.86-2005" />
		<meta name="Generator" content="tex2dtbook by Lukas Kohlhase" />
		<xsl:apply-templates select="ltx:date"/>
    	</head>
    	<book>
    	<frontmatter>
    	<xsl:choose>
    	<xsl:when test="//ltx:document/ltx:title">
    		<xsl:apply-templates select="/ltx:document/ltx:title"/>
    		<xsl:apply-templates select="ltx:creator[@role='author']"/>
    	</xsl:when>
    	<xsl:otherwise>
    		<doctitle id="{generate-id(.)}">No Title present</doctitle>
    	</xsl:otherwise>
     	</xsl:choose>
    		
    	</frontmatter>
    	<bodymatter>
    	    	<xsl:apply-templates select="*[not(self::ltx:title[parent::ltx:document]or self::ltx:date or self::ltx:creator[@role='author'])]"/>
    	</bodymatter>
    	</book>
    </dtbook>
    </xsl:template>
    
    <xsl:template match="ltx:acknowledgements[ancestor::ltx:section]">
    	<p>
    		<xsl:apply-templates/>
    	</p>
    </xsl:template>
    
    <xsl:template match="ltx:acknowledgements">
    	<level1>
    		<p>
    		<xsl:apply-templates/>
    		</p>
    	</level1>
    </xsl:template>
    
    <xsl:template match="ltx:date">
    	<meta name="dc:Date" content="{./text()}" />
    </xsl:template>
    
    <xsl:template match="ltx:document/ltx:title">
    	<doctitle id="{generate-id(.)}"><xsl:apply-templates/></doctitle>
    </xsl:template>
    
    <xsl:template match="ltx:personname">
    	<xsl:apply-templates/>
    	<br/>
    </xsl:template>
    
    <xsl:template match="ltx:contact">
    	<xsl:apply-templates/>
    	<br/>
    </xsl:template>
    
    <xsl:template match="ltx:creator[@role='author']">
    	<docauthor id="{generate-id(.)}">
    		<xsl:apply-templates/>
    	</docauthor>
    </xsl:template>
    
    <xsl:template match="ltx:para">
    	<xsl:apply-templates/>
    </xsl:template>
    
    <xsl:template match="ltx:text">
    	<xsl:apply-templates/>
    </xsl:template>
    <xsl:template match="ltx:resource"/>
    
    <xsl:template match="ltx:p">
    	<p>
    	<xsl:if test="@xml:id">
    		<xsl:attribute name="id"><xsl:value-of select="@xml:id"/></xsl:attribute>
    	</xsl:if>
    		<xsl:apply-templates/>
    	</p>
    </xsl:template>
    
    <xsl:template match="ltx:section">
    	<level1>
    	    	<xsl:if test="@xml:id">
    		<xsl:attribute name="id"><xsl:value-of select="@xml:id"/></xsl:attribute>
    	</xsl:if>
    		<xsl:apply-templates/>
    		<xsl:apply-templates select=".//ltx:note[@role='footnote' and not(ancestor::ltx:subsection)]" mode="print"/>
    	</level1>
    </xsl:template>
    
    <xsl:template match="ltx:subsubsection">
    	<level3>
    	    	<xsl:if test="@xml:id">
    		<xsl:attribute name="id"><xsl:value-of select="@xml:id"/></xsl:attribute>
    	</xsl:if>
    		<xsl:apply-templates/>
    		<xsl:apply-templates select=".//ltx:note[@role='footnote' and ancestor::ltx:subsection and not(ancestor::ltx:subsubsection)]" mode="print"/>
    	</level3>
    </xsl:template>
    
    <xsl:template match="*[ancestor::m:math]">
    	<xsl:copy>
    		<xsl:apply-templates select="@*|node()"/>
    	</xsl:copy>
   </xsl:template>
    
    <xsl:template match="@*[ancestor::m:math]">
    	<xsl:copy-of select="."/>
    </xsl:template>
    <xsl:template match="ltx:note[@role='footnote']" mode="print">
    <note id="{generate-id(.)}"><p> <sup><xsl:value-of select="@mark"/></sup><xsl:apply-templates/></p></note>
    </xsl:template>
    
    <xsl:template match="@stretchy[ancestor::m:math]"/>
    <xsl:template match="@xml:id[ancestor::m:math]"/>
    <xsl:template match="ltx:note[@role='footnote']">
    <noteref idref="{concat('#',generate-id(.))}"><xsl:value-of select="@mark"/></noteref>
    </xsl:template>
    
    <xsl:template match="ltx:TOC">
    <level1>
        	<xsl:if test="@xml:id">
    		<xsl:attribute name="id"><xsl:value-of select="@xml:id"/></xsl:attribute>
    	</xsl:if>
    	<xsl:apply-templates/>
    </level1>
    </xsl:template>
    
    <xsl:template match="ltx:tocentry">
    <li>
        	<xsl:if test="@xml:id">
    		<xsl:attribute name="id"><xsl:value-of select="@xml:id"/></xsl:attribute>
    	</xsl:if>
    	<xsl:apply-templates/>
    </li>
    </xsl:template>
    
    <xsl:template match="ltx:toclist">
    	<list type="ul">
    	    	<xsl:if test="@xml:id">
    		<xsl:attribute name="id"><xsl:value-of select="@xml:id"/></xsl:attribute>
    	</xsl:if>
    		<xsl:apply-templates/>
        </list>
    </xsl:template>
    
    <xsl:template match="ltx:ref[@idref]">
    <a href="{concat('#',@idref)}">
        	<xsl:if test="@xml:id">
    		<xsl:attribute name="id"><xsl:value-of select="@xml:id"/></xsl:attribute>
    	</xsl:if>
    	<xsl:apply-templates/>
    </a>
    </xsl:template>
    
     <xsl:template match="ltx:ref[@labelref and not(@idref)]">
  <xsl:variable name="bar" select="@labelref"/>
  <xsl:variable name="foo">
  <xsl:value-of select="//*[@labels=$bar]/@xml:id"/>
  </xsl:variable>
    <a href="{concat('#',$foo)}">
        	<xsl:if test="@xml:id">
    		<xsl:attribute name="id"><xsl:value-of select="@xml:id"/></xsl:attribute>
    	</xsl:if>
	<xsl:apply-templates/>
    </a>
    <xsl:if test="not($foo)">
    <xsl:message> this reference is not working </xsl:message>
    <xsl:comment> this reference is not working </xsl:comment>
    </xsl:if>
  </xsl:template>
  
  <xsl:template match="ltx:ref[not(@labelref) and not(@idref) and @href]">
  <a href="@href"><xsl:apply-templates/></a>
  </xsl:template>
  
  <xsl:template match="ltx:pagination"/>
    <xsl:template match="ltx:tocentry//ltx:tag">
    	<xsl:value-of select="concat(text(),' ')"/>
    </xsl:template>
    
    <xsl:template match="ltx:note[@role='pubyear']"/>
    
    <xsl:template match="ltx:description">
    	<list type="ol">
    	    	<xsl:if test="@xml:id">
    		<xsl:attribute name="id"><xsl:value-of select="@xml:id"/></xsl:attribute>
    	</xsl:if>
    		<xsl:apply-templates/>
    	</list>
    </xsl:template>
    
    <xsl:template match="ltx:note[@role='pagerange']"/>
    
    <xsl:template match="ltx:title/ltx:tag">
   	<xsl:value-of select="concat(text(),' ')"/>
    </xsl:template>
    
    <xsl:template match="ltx:appendix">
    	<level1>
    	    	<xsl:if test="@xml:id">
    		<xsl:attribute name="id"><xsl:value-of select="@xml:id"/></xsl:attribute>
    	</xsl:if>
    		<xsl:apply-templates/>
    	</level1>
    </xsl:template>
    
    <xsl:template match="ltx:appendix/ltx:title">
    	<h1>
    	    	<xsl:if test="@xml:id">
    		<xsl:attribute name="id"><xsl:value-of select="@xml:id"/></xsl:attribute>
    	</xsl:if>
    		<xsl:apply-templates/>
    	</h1>
    </xsl:template>
    <xsl:template match="ltx:p//ltx:picture">
    	Missing picture
    </xsl:template>
    
    <xsl:template match="ltx:picture">
    	<p>
    	    	<xsl:if test="@xml:id">
    		<xsl:attribute name="id"><xsl:value-of select="@xml:id"/></xsl:attribute>
    	</xsl:if>
    		Missing Picture
    	</p>
    </xsl:template>
    
        <xsl:template match="ltx:caption/ltx:tag">
   	<xsl:value-of select="concat(text(),' ')"/>
    </xsl:template>
    
    <xsl:template match="ltx:ERROR[ancestor::ltx:p]">
    	An Error occured here with element <xsl:apply-templates/>
    </xsl:template>
    
    <xsl:template match="ltx:ERROR[not(ancestor::ltx:p) and ancestor::ltx:section] ">
    	<p>
    	    	<xsl:if test="@xml:id">
    		<xsl:attribute name="id"><xsl:value-of select="@xml:id"/></xsl:attribute>
    	</xsl:if>

    		An Error occured here with element <xsl:apply-templates/>
    	</p>
    </xsl:template>
    
    <xsl:template match="ltx:ERROR[not(ancestor::ltx:section)]">
    <level1>
    	<p>
    	    	<xsl:if test="@xml:id">
    		<xsl:attribute name="id"><xsl:value-of select="@xml:id"/></xsl:attribute>
    	</xsl:if>
    		An Error occured here with element <xsl:apply-templates/>
    	</p>
    </level1>
    </xsl:template>
    
    <xsl:template match="ltx:text[@class='ltx_ref_title']">
    		<xsl:apply-templates/>
    	<!-- TODO think about adding some span styling here -->
    </xsl:template>
    
    <xsl:template match="ltx:section/ltx:title">
    <h1>
        	<xsl:if test="@xml:id">
    		<xsl:attribute name="id"><xsl:value-of select="@xml:id"/></xsl:attribute>
    	</xsl:if>
    	<xsl:apply-templates/>
    </h1>  
    </xsl:template>
    
    <xsl:template match="ltx:subsubsection/ltx:title">
    	<h3>
    	    	<xsl:if test="@xml:id">
    		<xsl:attribute name="id"><xsl:value-of select="@xml:id"/></xsl:attribute>
    	</xsl:if>
    		<xsl:apply-templates/>
    	</h3>
    </xsl:template>
    
    <xsl:template match="ltx:subsection">
    	<level2>
    	    	<xsl:if test="@xml:id">
    		<xsl:attribute name="id"><xsl:value-of select="@xml:id"/></xsl:attribute>
    	</xsl:if>
    		<xsl:apply-templates/>
    		<xsl:apply-templates select=".//ltx:note[@role='footnote' and not(ancestor::ltx:subsubsection)]" mode="print"/>
    	</level2>
    </xsl:template>
    
    <xsl:template match="ltx:subsection/ltx:title">
    	<h2>
    	    	<xsl:if test="@xml:id">
    		<xsl:attribute name="id"><xsl:value-of select="@xml:id"/></xsl:attribute>
    	</xsl:if>
    		<xsl:apply-templates/>
    	</h2>
    </xsl:template>
    
    <xsl:template match="ltx:enumerate">
    <p>
        	<xsl:if test="@xml:id">
    		<xsl:attribute name="id"><xsl:value-of select="@xml:id"/></xsl:attribute>
    	</xsl:if>
    <list type="ol">
	<xsl:apply-templates/>
    </list>
    </p>
    </xsl:template>
    
    <xsl:template match="ltx:p//ltx:itemize">
    	<list type="ul">
    	    	<xsl:if test="@xml:id">
    		<xsl:attribute name="id"><xsl:value-of select="@xml:id"/></xsl:attribute>
    	</xsl:if>
    		<xsl:apply-templates/>
    	</list>
    </xsl:template>
    
    <xsl:template match="ltx:p//ltx:enumerate">
    	<list type="ol">
    		<xsl:apply-templates/>
    	</list>
    </xsl:template>
    
    <xsl:template match="ltx:itemize">
    <p>
        	<xsl:if test="@xml:id">
    		<xsl:attribute name="id"><xsl:value-of select="@xml:id"/></xsl:attribute>
    	</xsl:if>
    	<list type="ul">
    		<xsl:apply-templates/>
    	</list>
    </p>
    </xsl:template>
    <xsl:template match="ltx:p[descendant::ltx:table]">
    <p>
    	<xsl:apply-templates select="//ltx:table" mode="display"/>
    </p>
    </xsl:template>
    
    <xsl:template match="ltx:table" mode="display">
        	<table>
        	    	<xsl:if test="@xml:id">
    		<xsl:attribute name="id"><xsl:value-of select="@xml:id"/></xsl:attribute>
    	</xsl:if>
     		<xsl:apply-templates select="ltx:caption"/>
     		<xsl:apply-templates select="ltx:tabular"/>
     	</table>
     </xsl:template>
    
    
    <xsl:template match="ltx:p//ltx:table"/>
    
    <xsl:template match="ltx:table">
    		<table>
    		    	<xsl:if test="@xml:id">
    		<xsl:attribute name="id"><xsl:value-of select="@xml:id"/></xsl:attribute>
    	</xsl:if>
     		<xsl:apply-templates select="ltx:caption"/>
     		<xsl:apply-templates select="ltx:tabular"/>
     	</table>
    </xsl:template>
    <xsl:template match="ltx:table/ltx:caption">
    <caption>
        	<xsl:if test="@xml:id">
    		<xsl:attribute name="id"><xsl:value-of select="@xml:id"/></xsl:attribute>
    	</xsl:if>
    	<xsl:apply-templates/>
    </caption>
    </xsl:template>
    
    <xsl:template match="ltx:cite">
    <xsl:apply-templates/>
    </xsl:template>
    
    <xsl:template match="ltx:note[@mark and @role='affiliation']">
    	<sup><xsl:value-of select="@mark"/></sup>
    </xsl:template>
    
    <xsl:template match="ltx:item//ltx:p">
    	<xsl:apply-templates/>
    </xsl:template>
    
    <xsl:template match="ltx:item/ltx:tag"/>

    <xsl:template match="ltx:enumerate/ltx:item">
    	<li>
    	    	<xsl:if test="@xml:id">
    		<xsl:attribute name="id"><xsl:value-of select="@xml:id"/></xsl:attribute>
    	</xsl:if>
    		<xsl:apply-templates/>
    	</li>
    </xsl:template>	
      <xsl:template match="ltx:itemize/ltx:item">
    	<li>
    	    	<xsl:if test="@xml:id">
    		<xsl:attribute name="id"><xsl:value-of select="@xml:id"/></xsl:attribute>
    	</xsl:if>
    		<xsl:apply-templates/>
    	</li>
    </xsl:template>	
    
    <xsl:template match="ltx:description/ltx:item">
    	<li>
    	    	<xsl:if test="@xml:id">
    		<xsl:attribute name="id"><xsl:value-of select="@xml:id"/></xsl:attribute>
    	</xsl:if>
    		<xsl:apply-templates/>
    	</li>
    </xsl:template>
    
    <xsl:template match="ltx:p//ltx:break">
    	<br/>
    </xsl:template>
    
    <xsl:template match="ltx:break"/>
    
    <xsl:template match="ltx:bibliography">
    <level1>
        	<xsl:if test="@xml:id">
    		<xsl:attribute name="id"><xsl:value-of select="@xml:id"/></xsl:attribute>
    	</xsl:if>
    	<xsl:apply-templates/>
    </level1>
    </xsl:template>
    
    <xsl:template match="ltx:toccaption"/>
    
    <xsl:template match="ltx:bibliography/ltx:title">
     <h1>
         	<xsl:if test="@xml:id">
    		<xsl:attribute name="id"><xsl:value-of select="@xml:id"/></xsl:attribute>
    	</xsl:if>
     	<xsl:apply-templates/>
     </h1>
     </xsl:template>
     
     <xsl:template match="ltx:biblist">
     	<xsl:apply-templates/>
     </xsl:template>
     
     <xsl:template match="ltx:bibitem">
     <p>
         	<xsl:if test="@xml:id">
    		<xsl:attribute name="id"><xsl:value-of select="@xml:id"/></xsl:attribute>
    	</xsl:if>
     <strong>
     <xsl:value-of select="ltx:bibtag[@role='refnum']/text()"/>
     </strong>
     	<xsl:apply-templates select="ltx:bibblock"/>
     </p>
     </xsl:template>
     
     <xsl:template match="ltx:bibblock">
     		<xsl:apply-templates/>
     </xsl:template>
     
     <xsl:template match="ltx:bib-title">
     	<xsl:apply-templates/>
     </xsl:template>
     
      <xsl:template match="ltx:bib-part">
     	<xsl:apply-templates/>
     </xsl:template>
      <xsl:template match="ltx:bib-date">
     	<xsl:apply-templates/>
     </xsl:template>
     
      <xsl:template match="ltx:bib-publisher">
     	<xsl:apply-templates/>
     </xsl:template>

 <xsl:template match="ltx:bib-note">
     	<xsl:apply-templates/>
     </xsl:template>
     
     <xsl:template match="ltx:bib-place">
     	<xsl:apply-templates/>
     </xsl:template>
     
      <xsl:template match="ltx:bib-type">
     	<xsl:apply-templates/>
     </xsl:template>
      <xsl:template match="ltx:bib-organization">
     	<xsl:apply-templates/>
     </xsl:template>
     <xsl:template match="ltx:bib-edition">
     	<xsl:apply-templates/>
     </xsl:template> 
     
     <xsl:template match="ltx:bibblock//ltx:text[@class]">
     	<xsl:apply-templates/>
     </xsl:template>
     
     <xsl:template match="ltx:equation">
     	<xsl:apply-templates/>
     </xsl:template>
     
     <xsl:template match="ltx:equationgroup">
     	<xsl:apply-templates/>
     </xsl:template>
     
     <xsl:template match="ltx:MathFork">
     	<xsl:apply-templates/>
     </xsl:template>
     
     <xsl:template match="ltx:MathBranch"/>
     
     <xsl:template match="ltx:Math">
     	<xsl:apply-templates/>
     </xsl:template>
     
     <xsl:template match="ltx:graphics">
     	<img src="{@imagesrc}" alt="Image inserted into the document">    	<xsl:if test="@xml:id">
    		<xsl:attribute name="id"><xsl:value-of select="@xml:id"/></xsl:attribute>
    	</xsl:if></img>
     </xsl:template>
     
     <xsl:template match="m:math">
     <xsl:copy>
     	<xsl:apply-templates select="@*|node()"/>
     </xsl:copy>
     </xsl:template>
     
     <xsl:template match="ltx:figure//ltx:p">
     	<xsl:apply-templates/>
     </xsl:template>
     
     
     <xsl:template match="m:math[@display='block']">
     	<p>
     	    	<xsl:if test="@xml:id">
    		<xsl:attribute name="id"><xsl:value-of select="@xml:id"/></xsl:attribute>
    	</xsl:if>
     	     <xsl:copy>
     	<xsl:apply-templates select="@*|node()"/>
     </xsl:copy>
     </p>
     </xsl:template>
     	
     <xsl:template match="ltx:XMArray">
     XMArray is not supported at the moment 
     </xsl:template>
     
     <xsl:template match="ltx:inline-block">
     	<xsl:apply-templates/>
     </xsl:template>
     
     <xsl:template match="ltx:tabular">
     	<table>
     	    	<xsl:if test="@xml:id">
    		<xsl:attribute name="id"><xsl:value-of select="@xml:id"/></xsl:attribute>
    	</xsl:if>
     		<xsl:apply-templates select="ltx:caption"/>
     		<xsl:apply-templates select="ltx:thead"/>
     		<xsl:apply-templates select="ltx:tfooter"/>
     		<xsl:apply-templates select="ltx:tbody"/>
     		<xsl:apply-templates select="ltx:tr"/>
     	</table>
     </xsl:template>
     
     
     <xsl:template match="ltx:table/ltx:tabular">
     <xsl:choose>
     	<xsl:when test="preceding-sibling::ltx:tabular or following-sibling::ltx:tabular">
     		<xsl:apply-templates select="ltx:caption" mode="asdf"/>
     		<xsl:apply-templates select="ltx:thead" mode="asdf"/>
     		<xsl:apply-templates select="ltx:tfooter" mode="asdf"/>
     		<xsl:apply-templates select="ltx:tbody" mode="asdf" />
     		<xsl:apply-templates select="ltx:tr"/>
     	</xsl:when>
     	<xsl:otherwise>
     		<xsl:apply-templates select="ltx:caption"/>
     		<xsl:apply-templates select="ltx:thead"/>
     		<xsl:apply-templates select="ltx:tfooter"/>
     		<xsl:apply-templates select="ltx:tbody"/>
     		<xsl:apply-templates select="ltx:tr"/>
     	</xsl:otherwise>
     </xsl:choose>
     </xsl:template>
     
     <xsl:template match="ltx:thead" mode="asdf">
     	<xsl:apply-templates/>
     </xsl:template>
     
     <xsl:template match="ltx:tbody" mode="asdf">
     	<xsl:apply-templates/>
     </xsl:template>
     
          <xsl:template match="ltx:tfooter" mode="asdf">
     	<xsl:apply-templates/>
     </xsl:template>
     
     <xsl:template match="ltx:tfooter">
     	<tfooter>
     	    	<xsl:if test="@xml:id">
    		<xsl:attribute name="id"><xsl:value-of select="@xml:id"/></xsl:attribute>
    	</xsl:if>
     		<xsl:apply-templates/>
     	</tfooter>
     </xsl:template>
     
     <xsl:template match="ltx:table//ltx:caption" mode="asdf">
     	<xsl:apply-templates/>
     </xsl:template>
     
     <xsl:template match="ltx:keywords"/>
     
     <xsl:template match="ltx:tr">
     	<tr>
     	    	<xsl:if test="@xml:id">
    		<xsl:attribute name="id"><xsl:value-of select="@xml:id"/></xsl:attribute>
    	</xsl:if>
     	    	<xsl:if test="@xml:id">
    		<xsl:attribute name="id"><xsl:value-of select="@xml:id"/></xsl:attribute>
    	</xsl:if>
     		<xsl:apply-templates/>
     	</tr>
     </xsl:template>
     
     <xsl:template match="ltx:td">
     	<td>
     	    	<xsl:if test="@xml:id">
    		<xsl:attribute name="id"><xsl:value-of select="@xml:id"/></xsl:attribute>
    	</xsl:if>
		<xsl:apply-templates/>
	</td>
     </xsl:template>
     
     <xsl:template match="ltx:tbody">
     	<xsl:if test="not(preceding-sibling::ltx:tbody)">
     	<tbody>
     	    	<xsl:if test="@xml:id">
    		<xsl:attribute name="id"><xsl:value-of select="@xml:id"/></xsl:attribute>
    	</xsl:if>
     		<xsl:apply-templates/>
     	</tbody>
     </xsl:if>
     <xsl:if test="preceding-sibling::ltx:tbody">
	<xsl:apply-templates/>
     </xsl:if>
     </xsl:template>
     
     
     <xsl:template match="ltx:thead">
     <xsl:if test="not(preceding-sibling::ltx:thead)">
     	<thead>
     	    	<xsl:if test="@xml:id">
    		<xsl:attribute name="id"><xsl:value-of select="@xml:id"/></xsl:attribute>
    	</xsl:if>
     		<xsl:apply-templates/>
     	</thead>
     </xsl:if>
     <xsl:if test="preceding-sibling::ltx:thead">
	<xsl:apply-templates/>
     </xsl:if>
     </xsl:template>
     <xsl:template match="ltx:emph">
     	<em>
     		<xsl:apply-templates/>
     	</em>
     </xsl:template>
     
     <xsl:template match="ltx:figure">
     <imggroup>
         	<xsl:if test="@xml:id">
    		<xsl:attribute name="id"><xsl:value-of select="@xml:id"/></xsl:attribute>
    	</xsl:if>
     	<xsl:apply-templates select="ltx:caption"/>
     	<xsl:apply-templates select="*[not(self::ltx:caption)]"/>
     </imggroup>
     </xsl:template>
     
     <xsl:template match="ltx:figure/ltx:caption">
     	<caption>
     	    	<xsl:if test="@xml:id">
    		<xsl:attribute name="id"><xsl:value-of select="@xml:id"/></xsl:attribute>
    	</xsl:if>
     		<xsl:apply-templates/>
     	</caption>
     </xsl:template>
     <xsl:template match="ltx:theorem">
     	<xsl:apply-templates/>
     </xsl:template>
     
     <xsl:template match="ltx:theorem/ltx:title">
     <p>
         	<xsl:if test="@xml:id">
    		<xsl:attribute name="id"><xsl:value-of select="@xml:id"/></xsl:attribute>
    	</xsl:if>
     	<strong>
     		<xsl:apply-templates/>
     	</strong>
     </p>
     </xsl:template>
     
     <xsl:template match="ltx:proof/ltx:title">
     <p>
         	<xsl:if test="@xml:id">
    		<xsl:attribute name="id"><xsl:value-of select="@xml:id"/></xsl:attribute>
    	</xsl:if>
     	<strong>
     		<xsl:apply-templates/>
     	</strong>
     </p>
     </xsl:template>
     
     <xsl:template match="ltx:proof">
     	<xsl:apply-templates/>
     </xsl:template>
     
     <xsl:template match="ltx:toctitle"/>
     
     <xsl:template match="ltx:abstract">
     <level1>
         	<xsl:if test="@xml:id">
    		<xsl:attribute name="id"><xsl:value-of select="@xml:id"/></xsl:attribute>
    	</xsl:if>
     	<xsl:apply-templates/>
     </level1>
     </xsl:template>
     
     <xsl:template match="ltx:classification"/>
     
     <xsl:template match="@xml:id">
     	<xsl:attribute name="id" select="."/>
     </xsl:template>
     
     
    </xsl:stylesheet>
