<?xml version="1.0" encoding="utf-8"?>
<!--
/=====================================================================\ 
|  ltx2word.xsl                                                       |
|  Stylesheet for converting LaTeXML documents to DTBook              |
|=====================================================================|
| not yet Part of LaTeXML: http://dlmf.nist.gov/LaTeXML/              |
|=====================================================================|
| Michael Kohlhase http://kwarc.info/kohlhase                 #_#     |
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
  
    <xsl:template match="ltx:text">
  	<xsl:apply-templates/>
  	<xsl:message> cannot deal with element <xsl:value-of select="name()"/> yet! </xsl:message>
  	<xsl:comment> Text formatting error here <xsl:copy-of select="."/></xsl:comment>
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
    	</head>
    	<book>
    	<frontmatter>
    		<xsl:apply-templates select="/ltx:document/ltx:title"/>
    		<xsl:apply-templates select="ltx:creator[@role='author']"/>
    	</frontmatter>
    	<bodymatter>
    	    	<xsl:apply-templates select="*[not(self::ltx:title[parent::ltx:document] or self::ltx:creator[@role='author'])]"/>
    	</bodymatter>
    	</book>
    </dtbook>
    </xsl:template>
    
    <xsl:template match="ltx:document/ltx:title">
    	<doctitle id="{generate-id(.)}"><xsl:apply-templates/></doctitle>
    </xsl:template>
    
    <xsl:template match="ltx:personname">
    	<xsl:apply-templates/>
    </xsl:template>
    
    <xsl:template match="ltx:creator[@role='author']">
    	<docauthor id="{generate-id(.)}">
    		<xsl:apply-templates/>
    	</docauthor>
    </xsl:template>
    
    <xsl:template match="ltx:para">
    	<xsl:apply-templates/>
    </xsl:template>
    
    <xsl:template match="ltx:resource"/>
    
    <xsl:template match="ltx:p">
    	<p>
    		<xsl:apply-templates/>
    	</p>
    </xsl:template>
    
    <xsl:template match="ltx:section">
    	<level1>
    		<xsl:apply-templates/>
    		<xsl:apply-templates select=".//ltx:note[@role='footnote' and not(ancestor::ltx:subsection)]" mode="print"/>
    	</level1>
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
    
    <xsl:template match="ltx:note[@role='footnote']">
    <noteref idref="{concat('#',generate-id(.))}"><xsl:value-of select="@mark"/></noteref>
    </xsl:template>
    
    <xsl:template match="ltx:TOC">
    <level1>
    	<xsl:apply-templates/>
    </level1>
    </xsl:template>
    
    <xsl:template match="ltx:tocentry">
    <li>
    	<xsl:apply-templates/>
    </li>
    </xsl:template>
    
    <xsl:template match="ltx:toclist">
    	<list type="ul">
    		<xsl:apply-templates/>
        </list>
    </xsl:template>
    
    <xsl:template match="ltx:ref[@idref]">
    <a href="{concat('#',@idref)}">
    	<xsl:apply-templates/>
    </a>
    </xsl:template>
    
    <xsl:template match="ltx:tocentry//ltx:tag">
    	<xsl:value-of select="concat(text(),' ')"/>
    </xsl:template>
    
    <xsl:template match="ltx:title/ltx:tag">
   	<xsl:value-of select="concat(text(),' ')"/>
    </xsl:template>
    
    <xsl:template match="ltx:text[@class='ltx_ref_title']">
    		<xsl:apply-templates/>
    	<!-- TODO think about adding some span styling here -->
    </xsl:template>
    
    <xsl:template match="ltx:section/ltx:title">
    <h1>
    	<xsl:apply-templates/>
    </h1>  
    </xsl:template>
    
    <xsl:template match="ltx:subsection">
    	<level2>
    		<xsl:apply-templates/>
    		<xsl:apply-templates select=".//ltx:note[@role='footnote' and not(ancestor::ltx:subsubsection)]" mode="print"/>
    	</level2>
    </xsl:template>
    
    <xsl:template match="ltx:subsection/ltx:title">
    	<h2>
    		<xsl:apply-templates/>
    	</h2>
    </xsl:template>
    
    <xsl:template match="ltx:enumerate">
    <list type="ol">
	<xsl:apply-templates/>
    </list>
    </xsl:template>
    
    <xsl:template match="ltx:cite">
    <xsl:apply-templates/>
    </xsl:template>
    
    <xsl:template match="ltx:item//ltx:p">
    	<xsl:apply-templates/>
    </xsl:template>
    
    <xsl:template match="ltx:item/ltx:tag"/>

    <xsl:template match="ltx:enumerate/ltx:item">
    	<li>
    		<xsl:apply-templates/>
    	</li>
    </xsl:template>	
    
    <xsl:template match="ltx:break">
    	<br/>
    </xsl:template>
    
    <xsl:template match="ltx:bibliography">
    <level1>
    	<xsl:apply-templates/>
    </level1>
    </xsl:template>
    
    <xsl:template match="ltx:bibliography/ltx:title">
     <h1>
     	<xsl:apply-templates/>
     </h1>
     </xsl:template>
     
     <xsl:template match="ltx:biblist">
     	<xsl:apply-templates/>
     </xsl:template>
     
     <xsl:template match="ltx:bibitem">
     	<xsl:apply-templates select="ltx:bibblock"/>
     </xsl:template>
     
     <xsl:template match="ltx:bibblock">
     	<p>
     		<xsl:apply-templates/>
     	</p>
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
     
     <xsl:template match="m:math">
     <xsl:copy>
     	<xsl:apply-templates select="@*|node()"/>
     </xsl:copy>
     </xsl:template>
    </xsl:stylesheet>
