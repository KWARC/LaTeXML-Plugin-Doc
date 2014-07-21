<?xml version="1.0" encoding="utf-8"?>
<!--
/=====================================================================\ 
|  LaTeXML-ODT.xsl                                                    |
|  Stylesheet for converting LaTeXML documents to Open Document Text  |
|=====================================================================|
| not yet Part of LaTeXML: http://dlmf.nist.gov/LaTeXML/              |
|=====================================================================|
| Lukas Kohlhase                                              #_#     |
| Public domain software                                     (o o)    |
\=========================================================ooo==U==ooo=/
-->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:ltx="http://dlmf.nist.gov/LaTeXML" xmlns:office="urn:oasis:names:tc:opendocument:xmlns:office:1.0" xmlns:style="urn:oasis:names:tc:opendocument:xmlns:style:1.0" xmlns:text="urn:oasis:names:tc:opendocument:xmlns:text:1.0" xmlns:table="urn:oasis:names:tc:opendocument:xmlns:table:1.0" xmlns:draw="urn:oasis:names:tc:opendocument:xmlns:drawing:1.0" xmlns:fo="urn:oasis:names:tc:opendocument:xmlns:xsl-fo-compatible:1.0" xmlns:xlink="http://www.w3.org/1999/xlink" xmlns:dc="http://purl.org/dc/elements/1.1/" xmlns:meta="urn:oasis:names:tc:opendocument:xmlns:meta:1.0" xmlns:number="urn:oasis:names:tc:opendocument:xmlns:datastyle:1.0" xmlns:svg="urn:oasis:names:tc:opendocument:xmlns:svg-compatible:1.0" xmlns:chart="urn:oasis:names:tc:opendocument:xmlns:chart:1.0" xmlns:dr3d="urn:oasis:names:tc:opendocument:xmlns:dr3d:1.0" xmlns:math="http://www.w3.org/1998/Math/MathML" xmlns:form="urn:oasis:names:tc:opendocument:xmlns:form:1.0" xmlns:script="urn:oasis:names:tc:opendocument:xmlns:script:1.0" xmlns:ooo="http://openoffice.org/2004/office" xmlns:ooow="http://openoffice.org/2004/writer" xmlns:oooc="http://openoffice.org/2004/calc" xmlns:dom="http://www.w3.org/2001/xml-events" xmlns:xforms="http://www.w3.org/2002/xforms" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:rpt="http://openoffice.org/2005/report" xmlns:of="urn:oasis:names:tc:opendocument:xmlns:of:1.2" xmlns:xhtml="http://www.w3.org/1999/xhtml" xmlns:grddl="http://www.w3.org/2003/g/data-view#" xmlns:officeooo="http://openoffice.org/2009/office" xmlns:tableooo="http://openoffice.org/2009/table" xmlns:drawooo="http://openoffice.org/2010/draw" xmlns:calcext="urn:org:documentfoundation:names:experimental:calc:xmlns:calcext:1.0" xmlns:field="urn:openoffice:names:experimental:ooo-ms-interop:xmlns:field:1.0" xmlns:formx="urn:openoffice:names:experimental:ooxml-odf-interop:xmlns:form:1.0" xmlns:b="http://schemas.openxmlformats.org/officeDocument/2006/bibliography" xmlns:css3t="http://www.w3.org/TR/css3-text/" version="1.0" exclude-result-prefixes="ltx">
  <xsl:output method="xml" indent="yes" encoding="utf-8"/>
    <xsl:strip-space elements="*"/>
  
  <!-- fallback for debugging -->
  <xsl:template match="*">
    <xsl:message>cannot deal with element <xsl:value-of select="local-name()"/> yet!</xsl:message>
    <xsl:comment>cannot deal with element <xsl:value-of select="local-name()"/> here yet!</xsl:comment>
  </xsl:template> 
  
    <xsl:template match="ltx:text">
  	<xsl:apply-templates/>
  	<xsl:message> cannot deal with element <xsl:value-of select="name()"/> yet! </xsl:message>
  	<xsl:comment> Text formatting error here <xsl:copy-of select="."/></xsl:comment>
  </xsl:template>
  
  <xsl:variable name="bibliography" select="//ltx:bibliography"/>

  <xsl:template match="/">
    <xsl:comment>generated from LTXML</xsl:comment>
    <xsl:apply-templates/>
  </xsl:template> 

  <xsl:template match="ltx:document">
    <office:document-content xmlns:office="urn:oasis:names:tc:opendocument:xmlns:office:1.0" xmlns:style="urn:oasis:names:tc:opendocument:xmlns:style:1.0" xmlns:text="urn:oasis:names:tc:opendocument:xmlns:text:1.0" xmlns:table="urn:oasis:names:tc:opendocument:xmlns:table:1.0" xmlns:draw="urn:oasis:names:tc:opendocument:xmlns:drawing:1.0" xmlns:fo="urn:oasis:names:tc:opendocument:xmlns:xsl-fo-compatible:1.0" xmlns:xlink="http://www.w3.org/1999/xlink" xmlns:dc="http://purl.org/dc/elements/1.1/" xmlns:meta="urn:oasis:names:tc:opendocument:xmlns:meta:1.0" xmlns:number="urn:oasis:names:tc:opendocument:xmlns:datastyle:1.0" xmlns:svg="urn:oasis:names:tc:opendocument:xmlns:svg-compatible:1.0" xmlns:chart="urn:oasis:names:tc:opendocument:xmlns:chart:1.0" xmlns:dr3d="urn:oasis:names:tc:opendocument:xmlns:dr3d:1.0" xmlns:math="http://www.w3.org/1998/Math/MathML" xmlns:form="urn:oasis:names:tc:opendocument:xmlns:form:1.0" xmlns:script="urn:oasis:names:tc:opendocument:xmlns:script:1.0" xmlns:ooo="http://openoffice.org/2004/office" xmlns:ooow="http://openoffice.org/2004/writer" xmlns:oooc="http://openoffice.org/2004/calc" xmlns:dom="http://www.w3.org/2001/xml-events" xmlns:xforms="http://www.w3.org/2002/xforms" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:rpt="http://openoffice.org/2005/report" xmlns:of="urn:oasis:names:tc:opendocument:xmlns:of:1.2" xmlns:xhtml="http://www.w3.org/1999/xhtml" xmlns:grddl="http://www.w3.org/2003/g/data-view#" xmlns:officeooo="http://openoffice.org/2009/office" xmlns:tableooo="http://openoffice.org/2009/table" xmlns:drawooo="http://openoffice.org/2010/draw" xmlns:calcext="urn:org:documentfoundation:names:experimental:calc:xmlns:calcext:1.0" xmlns:field="urn:openoffice:names:experimental:ooo-ms-interop:xmlns:field:1.0" xmlns:formx="urn:openoffice:names:experimental:ooxml-odf-interop:xmlns:form:1.0" xmlns:css3t="http://www.w3.org/TR/css3-text/" office:version="1.2">
      <office:font-face-decls>
        <style:font-face style:name="Lohit Devanagari1" svg:font-family="'Lohit Devanagari'"/>
        <style:font-face style:name="AR PL UMing HK1" svg:font-family="'AR PL UMing HK'" style:font-family-generic="modern" style:font-pitch="fixed"/>
        <style:font-face style:name="DejaVu Sans Mono" svg:font-family="'DejaVu Sans Mono'" style:font-family-generic="modern" style:font-pitch="fixed"/>
        <style:font-face style:name="Lohit Devanagari2" svg:font-family="'Lohit Devanagari'" style:font-family-generic="modern" style:font-pitch="fixed"/>
        <style:font-face style:name="Times New Roman" svg:font-family="'Times New Roman'" style:font-family-generic="roman" style:font-pitch="variable"/>
        <style:font-face style:name="Arial" svg:font-family="Arial" style:font-family-generic="swiss" style:font-pitch="variable"/>
        <style:font-face style:name="AR PL UMing HK" svg:font-family="'AR PL UMing HK'" style:font-family-generic="system" style:font-pitch="variable"/>
        <style:font-face style:name="Lohit Devanagari" svg:font-family="'Lohit Devanagari'" style:font-family-generic="system" style:font-pitch="variable"/>
        <style:font-face style:name="Nimbus Mono L" svg:font-family="&apos;Nimbus Mono L&apos;" style:font-family-generic="modern" style:font-pitch="fixed"/>
      </office:font-face-decls>
      <office:automatic-styles>
        <style:style style:name="gr1" style:family="graphic">
          <!-- necessary to have mathimages actually display the math -->
          <style:graphic-properties draw:stroke="none" svg:stroke-width="0in" svg:stroke-color="#3465af" draw:marker-start="" draw:marker-start-width="0.0783in" draw:marker-start-center="false" draw:marker-end="" draw:marker-end-width="0.0783in" draw:marker-end-center="false" draw:fill="none" draw:fill-color="#729fcf" draw:textarea-horizontal-align="center" draw:textarea-vertical-align="middle" fo:padding-top="0.0492in" fo:padding-bottom="0.0492in" fo:padding-left="0.0984in" fo:padding-right="0.0984in" draw:shadow="hidden" draw:shadow-offset-x="0.0783in" draw:shadow-offset-y="0.0783in" draw:shadow-color="#808080" draw:color-mode="standard" draw:luminance="0%" draw:contrast="0%" draw:gamma="100%" draw:red="0%" draw:green="0%" draw:blue="0%" fo:clip="rect(0in, 0in, 0in, 0in)" draw:image-opacity="100%" style:mirror="none" fo:margin-top="0in" fo:margin-bottom="0in" style:run-through="foreground" style:wrap="run-through" style:number-wrapped-paragraphs="no-limit" style:vertical-pos="from-top" style:horizontal-pos="from-left" style:horizontal-rel="paragraph"/>
        </style:style>
        <style:style style:name="gr2" style:family="graphic" style:list-style-name="L1">
          <style:graphic-properties draw:stroke="none" svg:stroke-width="0in" svg:stroke-color="#3465af" draw:marker-start="" draw:marker-start-width="0.0783in" draw:marker-start-center="false" draw:marker-end="" draw:marker-end-width="0.0783in" draw:marker-end-center="false" draw:fill="none" draw:fill-color="#729fcf" draw:textarea-horizontal-align="center" draw:textarea-vertical-align="middle" fo:padding-top="0.0492in" fo:padding-bottom="0.0492in" fo:padding-left="0.0984in" fo:padding-right="0.0984in" draw:shadow="hidden" draw:shadow-offset-x="0.0783in" draw:shadow-offset-y="0.0783in" draw:shadow-color="#808080" draw:color-mode="standard" draw:luminance="0%" draw:contrast="0%" draw:gamma="100%" draw:red="0%" draw:green="0%" draw:blue="0%" fo:clip="rect(0in, 0in, 0in, 0in)" draw:image-opacity="100%" style:mirror="none" fo:margin-top="0in" fo:margin-bottom="0in" style:run-through="foreground" style:wrap="run-through" style:number-wrapped-paragraphs="no-limit" style:vertical-pos="from-top" style:horizontal-pos="from-left" style:horizontal-rel="paragraph"/>
        </style:style>
        <!-- Same reason as before -->
        <style:style style:name="fr1" style:family="graphic" style:parent-style-name="Graphics">
          <style:graphic-properties style:vertical-pos="top" style:vertical-rel="paragraph" style:mirror="none" fo:clip="rect(0in, 0in, 0in, 0in)" draw:luminance="0%" draw:contrast="0%" draw:red="0%" draw:green="0%" draw:blue="0%" draw:gamma="100%" draw:color-inversion="false" draw:image-opacity="100%" draw:color-mode="standard"/>
        </style:style>
        <style:style style:name="P2" style:family="paragraph" style:parent-style-name="Preformatted_20_Text">
          <style:text-properties officeooo:paragraph-rsid="001edd4d"/>
        </style:style>
        <style:style style:name="bold" style:family="text" style:parent-style-name="Preformatted_20_Text">
          <style:text-properties fo:font-weight="bold"/>
        </style:style>
        <style:style style:name="italic" style:family="text" style:parent-style-name="Preformatted_20_Text">
          <style:text-properties fo:font-style="italic"/>
        </style:style>
        <style:style style:name="typewriter" style:family="paragraph" style:parent-style-name="Preformatted_20_Text"><style:text-properties style:font-name="Nimbus Mono L" officeooo:paragraph-rsid="00077ad6"/></style:style> <!-- looked to be the closest approximation -->
        <style:style style:name="error" style:family="text" style:parent-style-name="Standard"><style:text-properties fo:color="#ff0000" fo:font-style="italic" style:text-underline-style="solid" style:text-underline-width="auto" style:text-underline-color="font-color" fo:font-weight="bold" style:font-style-asian="italic" style:font-weight-asian="bold" style:font-style-complex="italic" style:font-weight-complex="bold"/></style:style>
        <style:style style:name="super" style:family="text"><style:text-properties style:text-position="super 58%"/></style:style>
        <style:style style:name="smallcaps" style:family="text" style:parent-style-name="Preformatted_20_Text"><style:text-properties fo:font-variant="small-caps"/></style:style>
        <style:style style:name="small" style:family="text" style:parent-style-name="Preformatted_20_Text"><style:text-properties fo:font-size="8pt"/></style:style>
        <!-- Don't quite work yet 
      <style:style style:name="center" style:family="paragraph" style:parent-style-name="Standard"><style:paragraph-properties style:vertical-align="middle"/></style:style>	
      <style:style style:name="left" style:family="paragraph" style:parent-style-name="Standard"><style:paragraph-properties style:vertical-align="left"/></style:style>	
      <style:style style:name="right" style:family="paragraph" style:parent-style-name="Standard"><style:paragraph-properties style:vertical-align="right"/></style:style>	
      -->
        <!-- most text processing is done here -->
      </office:automatic-styles>
      <office:body>
        <office:text>
          <xsl:apply-templates/>
        </office:text>
      </office:body>
    </office:document-content>
  </xsl:template> 
  

  <xsl:template match="ltx:cite">
  <xsl:for-each select=".//ltx:ref">
  	<xsl:variable name="foo"><xsl:value-of select="//ltx:bibitem[@xml:id=current()/@idref]/@key"/></xsl:variable>
  	<xsl:apply-templates select="$bibfile/b:Sources/b:Source[./b:Tag[./text()=$foo]]"/>
  </xsl:for-each>
  </xsl:template>


  <xsl:template match="ltx:para">
    <xsl:apply-templates/>
  </xsl:template> 

  <xsl:template match="ltx:p">
    <text:p>
      <xsl:apply-templates/>
    </text:p>
  </xsl:template> 

  <xsl:template match="ltx:resource"/>
  <xsl:template match="ltx:section">
    <xsl:apply-templates/>
  </xsl:template> 

  <xsl:template match="ltx:appendix">
  	<xsl:apply-templates/>
  </xsl:template>
  
  <xsl:template match="ltx:section/ltx:title">
    <text:p text:style-name="heading1">
      <text:toc-mark-start text:id="{generate-id(.)}" text:outline-level="1"/>
      <xsl:apply-templates/>
      <text:toc-mark-end text:id="{generate-id(.)}"/>
    </text:p>
  </xsl:template> 
  
  <xsl:template match="ltx:appendix/ltx:title">
  	    <text:p text:style-name="heading1">
      <text:toc-mark-start text:id="{generate-id(.)}" text:outline-level="1"/>
      <xsl:apply-templates/>
      <text:toc-mark-end text:id="{generate-id(.)}"/>
    </text:p>
  </xsl:template>

  <xsl:template match="ltx:creator">
    <text:p text:style-name="author">
      <xsl:apply-templates/>
    </text:p>
  </xsl:template>
  
  <xsl:template match="ltx:date">
  	<text:p text:style-name="author">
  		<xsl:apply-templates/>
  	</text:p>
  </xsl:template>
  
  <xsl:template match="ltx:inline-block">
  	<xsl:apply-templates/>
  </xsl:template>
  
  
  <xsl:template match="ltx:contact">
  	<text:line-break/><xsl:apply-templates/>   
  </xsl:template>
  

  <xsl:template match="ltx:personname">
    <xsl:apply-templates/>
  </xsl:template> 
  
  <xsl:template match="ltx:acknowledgements">
  	<text:p>
  		<xsl:apply-templates/>
  	</text:p>
  </xsl:template>
  
  <xsl:template match="ltx:text[@class='ltx_markedasmath']">
  	<xsl:apply-templates/>
  </xsl:template>
  
  <xsl:template match="ltx:text[@class='ltx_caption']">
  	<xsl:apply-templates/>
  </xsl:template>
  
  <xsl:template match="ltx:text[@class='ltx_ref_title']">
  	<xsl:apply-templates/>
  </xsl:template>

<xsl:template match="ltx:text[@fontsize='small']">
	<text:span text:style-name="small">
		<xsl:apply-templates/>
	</text:span>
</xsl:template>

  <xsl:template match="ltx:caption/ltx:tag">
    <xsl:apply-templates/>
    <text:s/>
  </xsl:template> 
  
    <xsl:template match="ltx:title/ltx:tag">
    <xsl:apply-templates/>
    <text:s/>
  </xsl:template> 

  <xsl:template match="ltx:item/ltx:tag"/>
  <xsl:template match="ltx:subsection">
    <xsl:apply-templates/>
  </xsl:template>
  
  <xsl:template match="ltx:item">
  	<xsl:apply-templates/>
  </xsl:template>
  
  <xsl:template match="ltx:quote">
  	<xsl:apply-templates/>
  </xsl:template>
  
  <xsl:template match="ltx:quote/ltx:p">
  	<text:p text:style-name="italic">
  		<xsl:apply-templates/>
  	</text:p>
  </xsl:template>
  
  <xsl:template match="ltx:abstract">
  <xsl:apply-templates/>
  </xsl:template>
  <xsl:template match="ltx:abstract/ltx:p">
  <text:p text:style-name="abstract">
  	<xsl:apply-templates/>
  </text:p>
  </xsl:template>
  
  <xsl:template match="ltx:toctile"/>

  <xsl:template match="ltx:subsection/ltx:title">
    <text:p text:style-name="heading2">
      <text:toc-mark-start text:id="{generate-id(.)}" text:outline-level="2"/>
      <xsl:apply-templates/>
      <text:toc-mark-end text:id="{generate-id(.)}"/>
    </text:p>
  </xsl:template> 
  
  <xsl:template match="ltx:classification"/>
  
  <xsl:template match="ltx:ERROR[ancestor::ltx:p]">
  	<text:span text:style-name="error">
  		Error with element <xsl:apply-templates/>
  	</text:span>
  </xsl:template>
  
  <xsl:template match="ltx:sup">
  <text:span text:style-name="sup">
  	<xsl:apply-templates/>
  </text:span>
  </xsl:template>

  <xsl:template match="ltx:ERROR">
  <text:p>
  <text:span text:style-name="error">
  		Error with element <xsl:apply-templates/>
  	</text:span>
  </text:p>
  </xsl:template>

  <xsl:template match="ltx:subsubsection">
    <xsl:apply-templates/>
  </xsl:template> 

  <xsl:template match="ltx:subsubsection/ltx:title">
    <text:p text:style-name="heading2">
      <text:toc-mark-start text:id="{generate-id(.)}" text:outline-level="3"/>
      <xsl:apply-templates/>
      <text:toc-mark-end text:id="{generate-id(.)}"/>
    </text:p>
  </xsl:template> 

  <xsl:template match="ltx:TOC">
    <text:table-of-content>
      <text:table-of-content-source text:use-index-marks="true"/>
      <text:index-body>
        <text:index-title text:style-name="Sect1" text:name="Table of Contents1_Head">
          <text:p text:style-name="Contents_20_Heading">Please update this Table</text:p>
        </text:index-title>
      </text:index-body>
      <!-- This message will disappear when the user updates the table. Till then, they are asked to update the table of contents -->
    </text:table-of-content>
  </xsl:template> 

  <xsl:template match="ltx:break">
    <text:line-break/>
  </xsl:template> 

  <xsl:template match="ltx:document/ltx:title">
    <text:p text:style-name="title">
      <xsl:apply-templates/>
    </text:p>
  </xsl:template> 

  <xsl:template match="ltx:table">
  	<xsl:apply-templates/>
  </xsl:template>
  <xsl:template match="ltx:tabular">
    <xsl:variable name="foo">
      <xsl:if test="not(./ltx:tbody/ltx:tr)">0</xsl:if>
      <xsl:for-each select="./ltx:tbody/ltx:tr">
        <xsl:sort select="count(./ltx:td) "/>
        <xsl:if test="position()=last()">
          <xsl:value-of select="count(./ltx:td)"/>
        </xsl:if>
      </xsl:for-each>
    </xsl:variable>
    <xsl:variable name="bar">
      <xsl:if test="not(./ltx:tr)">0</xsl:if>
      <xsl:for-each select="./ltx:tr">
        <xsl:sort select="count(./ltx:td)"/>
        <xsl:if test="position()=last()">
          <xsl:value-of select="count(./ltx:td)"/>
        </xsl:if>
      </xsl:for-each>
    </xsl:variable>
    <table:table>
      <xsl:call-template name="ntimes">
        <xsl:with-param name="i" select="number($foo)+number($bar)"/>
      </xsl:call-template>
      <xsl:apply-templates/>
    </table:table>
  </xsl:template> 

  <xsl:template name="ntimes">
    <xsl:param name="i"/>
    <xsl:if test="$i&gt;0">
      <table:table-column/>
      <xsl:call-template name="ntimes">
        <xsl:with-param name="i" select="$i - 1"/>
      </xsl:call-template>
    </xsl:if>
    <xsl:if test="$i = 0">
   </xsl:if>
  </xsl:template> 

  <xsl:template match="ltx:tbody">
    <xsl:apply-templates/>
  </xsl:template> 
  
  <xsl:template match="ltx:thead">
  	<xsl:apply-templates/>
  </xsl:template>

  <xsl:template match="ltx:tr">
    <table:table-row>
      <xsl:apply-templates/>
    </table:table-row>
  </xsl:template> 

  <xsl:template match="ltx:td">
    <table:table-cell>
      <text:p>
        <!-- Doesn't quite work yet
  	<xsl:if test="@align='left'">
  	<xsl:attribute name="text:style-name">left</xsl:attribute>
  	</xsl:if>
  	<xsl:if test="@align='right'">
  	<xsl:attribute name="text:style-name">right</xsl:attribute>
  	</xsl:if>
  	<xsl:if test="@align='center'">
  	<xsl:attribute name="text:style-name">center</xsl:attribute>
  	</xsl:if> 
  	-->
        <xsl:apply-templates/>
      </text:p>
    </table:table-cell>
  </xsl:template> 

  <!-- TODO Add support for table-styles. -->
  <!-- TODO add upport for alignments in tables -->
  <xsl:template match="ltx:note[@role='footnote']">
    <text:note text:note-class="footnote">
      <text:note-citation>
        <xsl:value-of select="@mark"/>
      </text:note-citation>
      <text:note-body>
        <text:p>
          <xsl:apply-templates/>
        </text:p>
      </text:note-body>
    </text:note>
  </xsl:template>
  
  <xsl:template match="ltx:note[@role='thanks']">
  <text:note text:note-class="footnote">
      <text:note-citation>
        <xsl:value-of select="@mark"/>
      </text:note-citation>
      <text:note-body>
        <text:p>
          <xsl:apply-templates/>
        </text:p>
      </text:note-body>
    </text:note>
  </xsl:template>
  
  <xsl:template match="ltx:note[@role='footnotetext']">
  <text:note text:note-class="footnote">
      <text:note-citation>
        <xsl:value-of select="@mark"/>
      </text:note-citation>
      <text:note-body>
        <text:p>
          <xsl:apply-templates/>
        </text:p>
      </text:note-body>
    </text:note>
  </xsl:template>

  <!-- Text processing templates begin here -->
  <xsl:template match="ltx:text[@font='bold']">
    <text:span text:style-name="bold">
      <xsl:apply-templates/>
    </text:span>
  </xsl:template>
  
  <xsl:template match="ltx:text[@color='#000000']">
  	<xsl:apply-templates/>
  </xsl:template>
  
  <xsl:template match="ltx:text[@font='smallcaps']">
  <text:span text:style-name="smallcaps">
  	<xsl:apply-templates/>
  </text:span>
  </xsl:template>

  <xsl:template match="ltx:text[@font='bold italic']">
    <text:span text:style-name="italic">
    	<text:span text:style-name="bold">
      <xsl:apply-templates/>
        </text:span>
    </text:span>
  </xsl:template> 
  
  <xsl:template match="ltx:emph">
  <text:span text:style-name="italic">
      <xsl:apply-templates/>
    </text:span>
   </xsl:template>
   
  <xsl:template match="ltx:text[@font='typewriter']">
  	<text:span text:style-name="typewriter">
  		<xsl:apply-templates/>
  	</text:span>
  </xsl:template>

  <!-- Text procesing templates end here -->
  <xsl:template match="ltx:enumerate">
    <text:list text:style-name="WW8StyleNum2">
      <xsl:apply-templates/>
    </text:list>
  </xsl:template> 

  <xsl:template match="ltx:itemize">
    <text:list text:style-name="WW8StyleNum1">
      <xsl:apply-templates/>
    </text:list>
  </xsl:template> 

  <xsl:template match="ltx:enumerate/ltx:item">
    <text:list-item>
      <xsl:apply-templates/>
    </text:list-item>
  </xsl:template> 
  
  <xsl:template match="itemize/ltx:item">
    <text:list-item>
      <xsl:apply-templates/>
    </text:list-item>
  </xsl:template> 
  
  <xsl:template match="ltx:description/ltx:item">
  <text:p>
  	<xsl:apply-templates select="./ltx:tag"/>
	<xsl:apply-templates select=".//ltx:p"/>
</text:p>
  </xsl:template>
  
  <xsl:template match="ltx:description/ltx:item//ltx:p">
  	<text:s/>
    	<xsl:apply-templates/>
  </xsl:template>
  
  <xsl:template match="ltx:XMTok">
  	<xsl:apply-templates/>
  </xsl:template>
  
  <xsl:template match="ltx:description">
  	<xsl:apply-templates/>
  </xsl:template>
  
  <xsl:template match="ltx:description/ltx:item/ltx:tag">
  	<text:span text:style-name="bold">
  		<xsl:apply-templates/>
  	</text:span>
  </xsl:template>
  
  <xsl:template match="ltx:p//ltx:picture">
  	<text:span text:style-name="error">
  		The \picture macro is currently not supported. Transform it to a .png or .jpg and insert manually 
  	</text:span>
  </xsl:template>
  
  <xsl:template match="ltx:picture">
  	<text:p>
  		<text:span text:style-name="error">
  		The \picture macro is currently not supported. Transform it to a .png or .jpg and insert manually 
  		</text:span>
  	</text:p>
  </xsl:template>
  
  <xsl:template match="ltx:rule[contains(@width,'%')]">
  <xsl:variable name="foo" select="@width"/>
  <xsl:variable name="bar"><xsl:value-of select="substring-before($foo,'%')"/></xsl:variable>
  <draw:line text:anchor-type="paragraph" draw:z-index="0"  svg:x1="0in" svg:y1="0in" svg:x2="{concat(format-number($bar*8.27 div 100,'#.00'),'in')}" svg:y2="0in"></draw:line>
  </xsl:template>
  
  <xsl:template match="ltx:rule[contains(@width,'pt')]">
  <xsl:variable name="foo" select="@width"/>
  <draw:line text:anchor-type="as-char" svg:x1="0in" svg:y1="0in" svg:x2="{$foo}" svg:y2="0in"/>
  </xsl:template>
  			
  <xsl:template match="ltx:pagination"/>

  <xsl:template match="ltx:graphics[ancestor::ltx:p]">
    <draw:frame text:anchor-type="as-char" svg:y="-0.1366in" draw:z-index="0">
      <draw:image xlink:href="Pictures/10000201000001AB0000004C7C3B6A12.png" xlink:type="simple" xlink:show="embed" xlink:actuate="onLoad">
        <text:p/>
      </draw:image>
      <svg:title>TexMaths</svg:title>
      <svg:desc>12§inline§$a^2+b^2=c^2$§png§600§TRUE</svg:desc>
    </draw:frame>
  </xsl:template> 

  <xsl:template match="bookmark">
    <text:bookmark text:name="{@name}"/>
  </xsl:template> 
  <xsl:template match="bookmark[not(ancestor::ltx:p)]">
  <text:p text:style-name="hidden">
  <text:bookmark text:name="{@name}"/>
  </text:p>
  </xsl:template>

  <xsl:template match="ltx:ref[@idref]">
    <text:a xlink:type="simple" xlink:href="{concat('#',@idref)}">
      <xsl:apply-templates/>
    </text:a>
  </xsl:template> 
  
  <xsl:template match="ltx:ref[@class='ltx_url']">
   <text:a xlink:type="simple" xlink:href="{@href}">
      <xsl:apply-templates/>
    </text:a>
  </xsl:template>
  
  <xsl:template match="ltx:rdf"/>

  <!-- ============================================================== Math starts here ==================================================================================== -->
  <xsl:template match="ltx:Math[@mode='inline']">
    <xsl:variable name="height" select="format-number(@imageheight div 100,'#.00')"/>
    <xsl:variable name="width" select="format-number(@imagewidth div 100,'#.00')"/>
    <draw:frame text:anchor-type="as-char" svg:y="-0.1154in" draw:z-index="1" draw:style-name="gr1" svg:width="{concat($width,'in')}" svg:height="{concat($height,'in')}">
      <!-- I assume a dpi of 100 -->
      <draw:image xlink:href="{@imagesrc}" xlink:type="simple" xlink:show="embed" xlink:actuate="onLoad">
        <text:p/>
      </draw:image>
      <svg:title>TexMaths</svg:title>
      <svg:desc>12§inline§<xsl:value-of select="@tex"/>§png§600§FALSE</svg:desc>
    </draw:frame>
  </xsl:template> 
  
  <xsl:template match="ltx:Math">
    <xsl:variable name="height" select="format-number(@imageheight div 100,'#.00')"/>
    <xsl:variable name="width" select="format-number(@imagewidth div 100,'#.00')"/>
  <draw:frame text:anchor-type="as-char" svg:y="-0.1154in" draw:z-index="1" draw:style-name="gr1" svg:width="{concat($width,'in')}" svg:height="{concat($height,'in')}">
      <!-- I assume a dpi of 100 -->
      <draw:image xlink:href="{@imagesrc}" xlink:type="simple" xlink:show="embed" xlink:actuate="onLoad">
        <text:p/>
      </draw:image>
      <svg:title>TexMaths</svg:title>
      <svg:desc>12§inline§<xsl:value-of select="@tex"/>§png§600§FALSE</svg:desc>
    </draw:frame>
    </xsl:template> <!-- If the math doesn't specify, I am assuming it is inline -->

  <xsl:template match="ltx:Math[@mode='display']">
    <xsl:variable name="height" select="format-number(@imageheight div 100,'#.00')"/>
    <xsl:variable name="width" select="format-number(@imagewidth div 100,'#.00')"/>
    <draw:frame text:anchor-type="as-char" svg:y="-0.1181in" draw:z-index="1" draw:style-name="gr2" svg:width="{concat($width,'in')}" svg:height="{concat($height,'in')}">
      <draw:image xlink:href="{@imagesrc}" xlink:type="simple" xlink:show="embed" xlink:actuate="onLoad">
        <text:p/>
      </draw:image>
      <svg:title>TexMaths</svg:title>
      <svg:desc>12§display§<xsl:value-of select="@tex"/>§png§600§FALSE</svg:desc>
    </draw:frame>
  </xsl:template> 

  <xsl:template match="ltx:equation">
    <text:p>
      <xsl:apply-templates/>
    </text:p>
  </xsl:template> 

  <xsl:template match="ltx:equationgroup">
    <xsl:variable name="foo">
      <xsl:for-each select="./ltx:equation">
        <xsl:sort select="count(.//ltx:td) "/>
        <xsl:if test="position()=last()">
          <xsl:value-of select="count(.//ltx:td)"/>
        </xsl:if>
      </xsl:for-each>
    </xsl:variable>
    <table:table>
      <xsl:call-template name="ntimes">
        <xsl:with-param name="i" select="number($foo)"/>
      </xsl:call-template>
      <xsl:apply-templates/>
    </table:table>
  </xsl:template> 

  <xsl:template match="ltx:MathFork">
    <xsl:apply-templates/>
  </xsl:template> 

  <xsl:template match="ltx:MathFork/ltx:Math">
  <image src="{@imagesrc}"/>
  </xsl:template>
  <xsl:template match="ltx:MathBranch">
    <xsl:apply-templates/>
  </xsl:template> 

  <xsl:template match="ltx:equationgroup/ltx:equation">
    <table:table-row>
      <xsl:apply-templates/>
    </table:table-row>
  </xsl:template> 
  
  <xsl:template match="ltx:theorem">
  	<xsl:apply-templates/>
  </xsl:template>
  
  <xsl:template match="ltx:theorem/ltx:title[@font='bold']">
  <text:p>
  <text:span text:style-name="bold">
  	<xsl:apply-templates/>
  </text:span>
  </text:p>
  </xsl:template>
  
  <xsl:template match="ltx:toctitle"/>
  <xsl:template match="ltx:toccaption"/>
  
  <xsl:template match="ltx:proof">
  	<xsl:apply-templates/>
  </xsl:template>
  
  <xsl:template match="ltx:proof/ltx:title[@font='italic']">
  <text:p>
  <text:span text:style-name="italic">
  	<xsl:apply-templates/>
  </text:span>
  </text:p>  
  </xsl:template>
  
  <xsl:template match="ltx:theorem/ltx:title[@font='italic']">
  <text:p>
  <text:span text:style-name="italic">
  	<xsl:apply-templates/>
  </text:span>
  </text:p>  
  </xsl:template>
  
  <xsl:template match="ltx:caption">
  	<text:p>
  		<xsl:apply-templates/>
  	</text:p>
  </xsl:template> <!-- TODO change this to a different style if it looks weird -->
  
  <xsl:template match="ltx:ref[@labelref and not(@idref)]">
  <xsl:variable name="bar" select="@labelref"/>
  <xsl:variable name="foo">
  <xsl:value-of select="//*[@labels=$bar]/@xml:id"/>
  </xsl:variable>
  <text:a xlink:type="simple" xlink:href="{concat('#',$foo)}">
      <xsl:apply-templates/>
    </text:a>
    <xsl:if test="not($foo)">
    <xsl:message> this reference is not working </xsl:message>
    <xsl:comment> this reference is not working </xsl:comment>
    </xsl:if>
  </xsl:template>
  
  <xsl:template match="ltx:text[@class='ltx_ref_tag']">
  	<xsl:apply-templates/>
  </xsl:template>

  <!-- ============================================================== Math ends here ====================================================================================== -->
  <xsl:template match="ltx:graphics[ancestor::ltx:p]">
    <xsl:variable name="height" select="format-number(@imageheight div 100,'#.00')"/>
    <xsl:variable name="width" select="format-number(@imagewidth div 100,'#.00')"/>
    <draw:frame draw:style-name="fr1" draw:name="graphics1" text:anchor-type="as-char" svg:width="{concat($width,'in')}" svg:height="{concat($height,'in')}">
      <draw:image xlink:href="{@imagesrc}" xlink:type="simple" xlink:show="embed" xlink:actuate="onLoad"/>
    </draw:frame>
  </xsl:template> 

  <xsl:template match="ltx:graphics">
    <xsl:variable name="height" select="format-number(@imageheight div 100,'#.00')"/>
    <xsl:variable name="width" select="format-number(@imagewidth div 100,'#.00')"/>
    <text:p>
      <draw:frame draw:style-name="fr1" draw:name="graphics1" text:anchor-type="as-char" svg:width="{concat($width,'in')}" svg:height="{concat($height,'in')}">
        <draw:image xlink:href="{@imagesrc}" xlink:type="simple" xlink:show="embed" xlink:actuate="onLoad"/>
      </draw:frame>
    </text:p>
  </xsl:template> 

  <!-- TODO look at whether these are all occurring graphic types. -->
  <!-- Bibliography management begins here -->
  <xsl:param name="temporary"/>
  <xsl:variable name="bibfile" select="document($temporary)"/> <!-- If I change the name here, I have to change the name in Odt.pm as well. Vice versa as well. -->
  <!-- TODO change this to something with parameteres -->
  <xsl:template match="ltx:bibliography">
    <text:bibliography text:style-name="Sect2" text:protected="true" text:name="Bibliography1">
          <text:bibliography-source>
            <text:index-title-template text:style-name="Heading_20_1">References</text:index-title-template>
            <text:bibliography-entry-template text:bibliography-type="article" text:style-name="Bibliography_20_1">
              <text:index-entry-span text:style-name="References_20_-_20_Default">[</text:index-entry-span>
              <text:index-entry-bibliography text:style-name="References_20_-_20_Default" text:bibliography-data-field="custom1"/>
              <text:index-entry-span text:style-name="References_20_-_20_Default">] </text:index-entry-span>
              <text:index-entry-bibliography text:style-name="References_20_-_20_Default" text:bibliography-data-field="author"/>
              <text:index-entry-span text:style-name="References_20_-_20_Default">, </text:index-entry-span>
              <text:index-entry-bibliography text:style-name="References_20_-_20_Italic" text:bibliography-data-field="title"/>
              <text:index-entry-span text:style-name="References_20_-_20_Default">, </text:index-entry-span>
              <text:index-entry-bibliography text:style-name="References_20_-_20_Default" text:bibliography-data-field="publisher"/>
              <text:index-entry-span text:style-name="References_20_-_20_Default">, </text:index-entry-span>
              <text:index-entry-bibliography text:bibliography-data-field="address"/>
              <text:index-entry-span>, </text:index-entry-span>
              <text:index-entry-bibliography text:style-name="References_20_-_20_Default" text:bibliography-data-field="year"/>
              <text:index-entry-span>.</text:index-entry-span>
            </text:bibliography-entry-template>
            <text:bibliography-entry-template text:bibliography-type="book" text:style-name="Bibliography_20_1">
              <text:index-entry-span text:style-name="References_20_-_20_Default">[</text:index-entry-span>
              <text:index-entry-bibliography text:style-name="References_20_-_20_Default" text:bibliography-data-field="custom1"/>
              <text:index-entry-span text:style-name="References_20_-_20_Default">] </text:index-entry-span>
              <text:index-entry-bibliography text:style-name="References_20_-_20_Default" text:bibliography-data-field="author"/>
              <text:index-entry-span text:style-name="References_20_-_20_Default">, </text:index-entry-span>
              <text:index-entry-bibliography text:style-name="References_20_-_20_Italic" text:bibliography-data-field="title"/>
              <text:index-entry-span text:style-name="References_20_-_20_Default">, </text:index-entry-span>
              <text:index-entry-bibliography text:style-name="References_20_-_20_Default" text:bibliography-data-field="publisher"/>
              <text:index-entry-span text:style-name="References_20_-_20_Default">, </text:index-entry-span>
              <text:index-entry-bibliography text:style-name="References_20_-_20_Default" text:bibliography-data-field="address"/>
              <text:index-entry-span text:style-name="References_20_-_20_Default">, </text:index-entry-span>
              <text:index-entry-bibliography text:style-name="References_20_-_20_Default" text:bibliography-data-field="year"/>
              <text:index-entry-span text:style-name="References_20_-_20_Default">.</text:index-entry-span>
            </text:bibliography-entry-template>
            <text:bibliography-entry-template text:bibliography-type="booklet" text:style-name="Bibliography_20_1">
              <text:index-entry-span text:style-name="References_20_-_20_Default">[</text:index-entry-span>
              <text:index-entry-bibliography text:style-name="References_20_-_20_Default" text:bibliography-data-field="custom1"/>
              <text:index-entry-span text:style-name="References_20_-_20_Default">] </text:index-entry-span>
              <text:index-entry-bibliography text:style-name="References_20_-_20_Default" text:bibliography-data-field="author"/>
              <text:index-entry-span text:style-name="References_20_-_20_Default">, </text:index-entry-span>
              <text:index-entry-bibliography text:style-name="References_20_-_20_Italic" text:bibliography-data-field="title"/>
              <text:index-entry-span text:style-name="References_20_-_20_Default">, </text:index-entry-span>
              <text:index-entry-bibliography text:style-name="References_20_-_20_Default" text:bibliography-data-field="publisher"/>
              <text:index-entry-span text:style-name="References_20_-_20_Default">, </text:index-entry-span>
              <text:index-entry-bibliography text:bibliography-data-field="address"/>
              <text:index-entry-span>, </text:index-entry-span>
              <text:index-entry-bibliography text:style-name="References_20_-_20_Default" text:bibliography-data-field="year"/>
              <text:index-entry-span>.</text:index-entry-span>
            </text:bibliography-entry-template>
            <text:bibliography-entry-template text:bibliography-type="conference" text:style-name="Bibliography_20_1">
              <text:index-entry-span text:style-name="References_20_-_20_Default">[</text:index-entry-span>
              <text:index-entry-bibliography text:style-name="References_20_-_20_Default" text:bibliography-data-field="custom1"/>
              <text:index-entry-span text:style-name="References_20_-_20_Default">] </text:index-entry-span>
              <text:index-entry-bibliography text:style-name="References_20_-_20_Default" text:bibliography-data-field="author"/>
              <text:index-entry-span text:style-name="References_20_-_20_Default">, </text:index-entry-span>
              <text:index-entry-bibliography text:style-name="References_20_-_20_Italic" text:bibliography-data-field="title"/>
              <text:index-entry-span text:style-name="References_20_-_20_Default">, </text:index-entry-span>
              <text:index-entry-bibliography text:style-name="References_20_-_20_Default" text:bibliography-data-field="publisher"/>
              <text:index-entry-span text:style-name="References_20_-_20_Default">, </text:index-entry-span>
              <text:index-entry-bibliography text:bibliography-data-field="address"/>
              <text:index-entry-span>, </text:index-entry-span>
              <text:index-entry-bibliography text:style-name="References_20_-_20_Default" text:bibliography-data-field="year"/>
              <text:index-entry-span>.</text:index-entry-span>
            </text:bibliography-entry-template>
            <text:bibliography-entry-template text:bibliography-type="custom1" text:style-name="Bibliography_20_1">
              <text:index-entry-span text:style-name="References_20_-_20_Default">[</text:index-entry-span>
              <text:index-entry-bibliography text:style-name="References_20_-_20_Default" text:bibliography-data-field="custom1"/>
              <text:index-entry-span text:style-name="References_20_-_20_Default">] </text:index-entry-span>
              <text:index-entry-bibliography text:style-name="References_20_-_20_Default" text:bibliography-data-field="author"/>
              <text:index-entry-span text:style-name="References_20_-_20_Default">, </text:index-entry-span>
              <text:index-entry-bibliography text:style-name="References_20_-_20_Italic" text:bibliography-data-field="title"/>
              <text:index-entry-span text:style-name="References_20_-_20_Default">, </text:index-entry-span>
              <text:index-entry-bibliography text:style-name="References_20_-_20_Default" text:bibliography-data-field="publisher"/>
              <text:index-entry-span text:style-name="References_20_-_20_Default">, </text:index-entry-span>
              <text:index-entry-bibliography text:bibliography-data-field="address"/>
              <text:index-entry-span>, </text:index-entry-span>
              <text:index-entry-bibliography text:style-name="References_20_-_20_Default" text:bibliography-data-field="year"/>
              <text:index-entry-span>.</text:index-entry-span>
            </text:bibliography-entry-template>
            <text:bibliography-entry-template text:bibliography-type="custom2" text:style-name="Bibliography_20_1">
              <text:index-entry-span text:style-name="References_20_-_20_Default">[</text:index-entry-span>
              <text:index-entry-bibliography text:style-name="References_20_-_20_Default" text:bibliography-data-field="custom1"/>
              <text:index-entry-span text:style-name="References_20_-_20_Default">] </text:index-entry-span>
              <text:index-entry-bibliography text:style-name="References_20_-_20_Default" text:bibliography-data-field="author"/>
              <text:index-entry-span text:style-name="References_20_-_20_Default">, </text:index-entry-span>
              <text:index-entry-bibliography text:style-name="References_20_-_20_Italic" text:bibliography-data-field="title"/>
              <text:index-entry-span text:style-name="References_20_-_20_Default">, </text:index-entry-span>
              <text:index-entry-bibliography text:style-name="References_20_-_20_Default" text:bibliography-data-field="publisher"/>
              <text:index-entry-span text:style-name="References_20_-_20_Default">, </text:index-entry-span>
              <text:index-entry-bibliography text:bibliography-data-field="address"/>
              <text:index-entry-span>, </text:index-entry-span>
              <text:index-entry-bibliography text:style-name="References_20_-_20_Default" text:bibliography-data-field="year"/>
              <text:index-entry-span>.</text:index-entry-span>
            </text:bibliography-entry-template>
            <text:bibliography-entry-template text:bibliography-type="custom3" text:style-name="Bibliography_20_1">
              <text:index-entry-span text:style-name="References_20_-_20_Default">[</text:index-entry-span>
              <text:index-entry-bibliography text:style-name="References_20_-_20_Default" text:bibliography-data-field="custom1"/>
              <text:index-entry-span text:style-name="References_20_-_20_Default">] </text:index-entry-span>
              <text:index-entry-bibliography text:style-name="References_20_-_20_Default" text:bibliography-data-field="author"/>
              <text:index-entry-span text:style-name="References_20_-_20_Default">, </text:index-entry-span>
              <text:index-entry-bibliography text:style-name="References_20_-_20_Italic" text:bibliography-data-field="title"/>
              <text:index-entry-span text:style-name="References_20_-_20_Default">, </text:index-entry-span>
              <text:index-entry-bibliography text:style-name="References_20_-_20_Default" text:bibliography-data-field="publisher"/>
              <text:index-entry-span text:style-name="References_20_-_20_Default">, </text:index-entry-span>
              <text:index-entry-bibliography text:bibliography-data-field="address"/>
              <text:index-entry-span>, </text:index-entry-span>
              <text:index-entry-bibliography text:style-name="References_20_-_20_Default" text:bibliography-data-field="year"/>
              <text:index-entry-span>.</text:index-entry-span>
            </text:bibliography-entry-template>
            <text:bibliography-entry-template text:bibliography-type="custom4" text:style-name="Bibliography_20_1">
              <text:index-entry-span text:style-name="References_20_-_20_Default">[</text:index-entry-span>
              <text:index-entry-bibliography text:style-name="References_20_-_20_Default" text:bibliography-data-field="custom1"/>
              <text:index-entry-span text:style-name="References_20_-_20_Default">] </text:index-entry-span>
              <text:index-entry-bibliography text:style-name="References_20_-_20_Default" text:bibliography-data-field="author"/>
              <text:index-entry-span text:style-name="References_20_-_20_Default">, </text:index-entry-span>
              <text:index-entry-bibliography text:style-name="References_20_-_20_Italic" text:bibliography-data-field="title"/>
              <text:index-entry-span text:style-name="References_20_-_20_Default">, </text:index-entry-span>
              <text:index-entry-bibliography text:style-name="References_20_-_20_Default" text:bibliography-data-field="publisher"/>
              <text:index-entry-span text:style-name="References_20_-_20_Default">, </text:index-entry-span>
              <text:index-entry-bibliography text:bibliography-data-field="address"/>
              <text:index-entry-span>, </text:index-entry-span>
              <text:index-entry-bibliography text:style-name="References_20_-_20_Default" text:bibliography-data-field="year"/>
              <text:index-entry-span>.</text:index-entry-span>
            </text:bibliography-entry-template>
            <text:bibliography-entry-template text:bibliography-type="custom5" text:style-name="Bibliography_20_1">
              <text:index-entry-span text:style-name="References_20_-_20_Default">[</text:index-entry-span>
              <text:index-entry-bibliography text:style-name="References_20_-_20_Default" text:bibliography-data-field="custom1"/>
              <text:index-entry-span text:style-name="References_20_-_20_Default">] </text:index-entry-span>
              <text:index-entry-bibliography text:style-name="References_20_-_20_Default" text:bibliography-data-field="author"/>
              <text:index-entry-span text:style-name="References_20_-_20_Default">, </text:index-entry-span>
              <text:index-entry-bibliography text:style-name="References_20_-_20_Italic" text:bibliography-data-field="title"/>
              <text:index-entry-span text:style-name="References_20_-_20_Default">, </text:index-entry-span>
              <text:index-entry-bibliography text:style-name="References_20_-_20_Default" text:bibliography-data-field="publisher"/>
              <text:index-entry-span text:style-name="References_20_-_20_Default">, </text:index-entry-span>
              <text:index-entry-bibliography text:bibliography-data-field="address"/>
              <text:index-entry-span>, </text:index-entry-span>
              <text:index-entry-bibliography text:style-name="References_20_-_20_Default" text:bibliography-data-field="year"/>
              <text:index-entry-span>.</text:index-entry-span>
            </text:bibliography-entry-template>
            <text:bibliography-entry-template text:bibliography-type="email" text:style-name="Bibliography_20_1">
              <text:index-entry-span text:style-name="References_20_-_20_Default">[</text:index-entry-span>
              <text:index-entry-bibliography text:style-name="References_20_-_20_Default" text:bibliography-data-field="custom1"/>
              <text:index-entry-span text:style-name="References_20_-_20_Default">] </text:index-entry-span>
              <text:index-entry-bibliography text:style-name="References_20_-_20_Default" text:bibliography-data-field="author"/>
              <text:index-entry-span text:style-name="References_20_-_20_Default">, </text:index-entry-span>
              <text:index-entry-bibliography text:style-name="References_20_-_20_Italic" text:bibliography-data-field="title"/>
              <text:index-entry-span text:style-name="References_20_-_20_Default">, </text:index-entry-span>
              <text:index-entry-bibliography text:style-name="References_20_-_20_Default" text:bibliography-data-field="publisher"/>
              <text:index-entry-span text:style-name="References_20_-_20_Default">, </text:index-entry-span>
              <text:index-entry-bibliography text:bibliography-data-field="address"/>
              <text:index-entry-span>, </text:index-entry-span>
              <text:index-entry-bibliography text:style-name="References_20_-_20_Default" text:bibliography-data-field="year"/>
              <text:index-entry-span>.</text:index-entry-span>
            </text:bibliography-entry-template>
            <text:bibliography-entry-template text:bibliography-type="inbook" text:style-name="Bibliography_20_1">
              <text:index-entry-span text:style-name="References_20_-_20_Default">[</text:index-entry-span>
              <text:index-entry-bibliography text:style-name="References_20_-_20_Default" text:bibliography-data-field="custom1"/>
              <text:index-entry-span text:style-name="References_20_-_20_Default">] </text:index-entry-span>
              <text:index-entry-bibliography text:style-name="References_20_-_20_Default" text:bibliography-data-field="author"/>
              <text:index-entry-span text:style-name="References_20_-_20_Default">, </text:index-entry-span>
              <text:index-entry-bibliography text:style-name="References_20_-_20_Italic" text:bibliography-data-field="title"/>
              <text:index-entry-span text:style-name="References_20_-_20_Default">, </text:index-entry-span>
              <text:index-entry-bibliography text:style-name="References_20_-_20_Default" text:bibliography-data-field="publisher"/>
              <text:index-entry-span text:style-name="References_20_-_20_Default">, </text:index-entry-span>
              <text:index-entry-bibliography text:bibliography-data-field="address"/>
              <text:index-entry-span>, </text:index-entry-span>
              <text:index-entry-bibliography text:style-name="References_20_-_20_Default" text:bibliography-data-field="year"/>
              <text:index-entry-span>.</text:index-entry-span>
            </text:bibliography-entry-template>
            <text:bibliography-entry-template text:bibliography-type="incollection" text:style-name="Bibliography_20_1">
              <text:index-entry-span text:style-name="References_20_-_20_Default">[</text:index-entry-span>
              <text:index-entry-bibliography text:style-name="References_20_-_20_Default" text:bibliography-data-field="custom1"/>
              <text:index-entry-span text:style-name="References_20_-_20_Default">] </text:index-entry-span>
              <text:index-entry-bibliography text:style-name="References_20_-_20_Default" text:bibliography-data-field="author"/>
              <text:index-entry-span text:style-name="References_20_-_20_Default">, </text:index-entry-span>
              <text:index-entry-bibliography text:style-name="References_20_-_20_Italic" text:bibliography-data-field="title"/>
              <text:index-entry-span text:style-name="References_20_-_20_Default">, </text:index-entry-span>
              <text:index-entry-bibliography text:style-name="References_20_-_20_Default" text:bibliography-data-field="publisher"/>
              <text:index-entry-span text:style-name="References_20_-_20_Default">, </text:index-entry-span>
              <text:index-entry-bibliography text:bibliography-data-field="address"/>
              <text:index-entry-span>, </text:index-entry-span>
              <text:index-entry-bibliography text:style-name="References_20_-_20_Default" text:bibliography-data-field="year"/>
              <text:index-entry-span>.</text:index-entry-span>
            </text:bibliography-entry-template>
            <text:bibliography-entry-template text:bibliography-type="inproceedings" text:style-name="Bibliography_20_1">
              <text:index-entry-span text:style-name="References_20_-_20_Default">[</text:index-entry-span>
              <text:index-entry-bibliography text:style-name="References_20_-_20_Default" text:bibliography-data-field="custom1"/>
              <text:index-entry-span text:style-name="References_20_-_20_Default">] </text:index-entry-span>
              <text:index-entry-bibliography text:style-name="References_20_-_20_Default" text:bibliography-data-field="author"/>
              <text:index-entry-span text:style-name="References_20_-_20_Default">, </text:index-entry-span>
              <text:index-entry-bibliography text:style-name="References_20_-_20_Italic" text:bibliography-data-field="title"/>
              <text:index-entry-span text:style-name="References_20_-_20_Default">, </text:index-entry-span>
              <text:index-entry-bibliography text:style-name="References_20_-_20_Default" text:bibliography-data-field="publisher"/>
              <text:index-entry-span text:style-name="References_20_-_20_Default">, </text:index-entry-span>
              <text:index-entry-bibliography text:bibliography-data-field="address"/>
              <text:index-entry-span>, </text:index-entry-span>
              <text:index-entry-bibliography text:style-name="References_20_-_20_Default" text:bibliography-data-field="year"/>
              <text:index-entry-span>.</text:index-entry-span>
            </text:bibliography-entry-template>
            <text:bibliography-entry-template text:bibliography-type="journal" text:style-name="Bibliography_20_1">
              <text:index-entry-span text:style-name="References_20_-_20_Default">[</text:index-entry-span>
              <text:index-entry-bibliography text:style-name="References_20_-_20_Default" text:bibliography-data-field="custom1"/>
              <text:index-entry-span text:style-name="References_20_-_20_Default">] </text:index-entry-span>
              <text:index-entry-bibliography text:style-name="References_20_-_20_Default" text:bibliography-data-field="author"/>
              <text:index-entry-span text:style-name="References_20_-_20_Default">, </text:index-entry-span>
              <text:index-entry-bibliography text:style-name="References_20_-_20_Italic" text:bibliography-data-field="title"/>
              <text:index-entry-span text:style-name="References_20_-_20_Default">, </text:index-entry-span>
              <text:index-entry-bibliography text:style-name="References_20_-_20_Default" text:bibliography-data-field="publisher"/>
              <text:index-entry-span text:style-name="References_20_-_20_Default">, </text:index-entry-span>
              <text:index-entry-bibliography text:bibliography-data-field="address"/>
              <text:index-entry-span>, </text:index-entry-span>
              <text:index-entry-bibliography text:style-name="References_20_-_20_Default" text:bibliography-data-field="year"/>
              <text:index-entry-span>.</text:index-entry-span>
            </text:bibliography-entry-template>
            <text:bibliography-entry-template text:bibliography-type="manual" text:style-name="Bibliography_20_1">
              <text:index-entry-span text:style-name="References_20_-_20_Default">[</text:index-entry-span>
              <text:index-entry-bibliography text:style-name="References_20_-_20_Default" text:bibliography-data-field="custom1"/>
              <text:index-entry-span text:style-name="References_20_-_20_Default">] </text:index-entry-span>
              <text:index-entry-bibliography text:style-name="References_20_-_20_Default" text:bibliography-data-field="author"/>
              <text:index-entry-span text:style-name="References_20_-_20_Default">, </text:index-entry-span>
              <text:index-entry-bibliography text:style-name="References_20_-_20_Italic" text:bibliography-data-field="title"/>
              <text:index-entry-span text:style-name="References_20_-_20_Default">, </text:index-entry-span>
              <text:index-entry-bibliography text:style-name="References_20_-_20_Default" text:bibliography-data-field="publisher"/>
              <text:index-entry-span text:style-name="References_20_-_20_Default">, </text:index-entry-span>
              <text:index-entry-bibliography text:bibliography-data-field="address"/>
              <text:index-entry-span>, </text:index-entry-span>
              <text:index-entry-bibliography text:style-name="References_20_-_20_Default" text:bibliography-data-field="year"/>
              <text:index-entry-span>.</text:index-entry-span>
            </text:bibliography-entry-template>
            <text:bibliography-entry-template text:bibliography-type="mastersthesis" text:style-name="Bibliography_20_1">
              <text:index-entry-span text:style-name="References_20_-_20_Default">[</text:index-entry-span>
              <text:index-entry-bibliography text:style-name="References_20_-_20_Default" text:bibliography-data-field="custom1"/>
              <text:index-entry-span text:style-name="References_20_-_20_Default">] </text:index-entry-span>
              <text:index-entry-bibliography text:style-name="References_20_-_20_Default" text:bibliography-data-field="author"/>
              <text:index-entry-span text:style-name="References_20_-_20_Default">, </text:index-entry-span>
              <text:index-entry-bibliography text:style-name="References_20_-_20_Italic" text:bibliography-data-field="title"/>
              <text:index-entry-span text:style-name="References_20_-_20_Default">, </text:index-entry-span>
              <text:index-entry-bibliography text:style-name="References_20_-_20_Default" text:bibliography-data-field="publisher"/>
              <text:index-entry-span text:style-name="References_20_-_20_Default">, </text:index-entry-span>
              <text:index-entry-bibliography text:bibliography-data-field="address"/>
              <text:index-entry-span>, </text:index-entry-span>
              <text:index-entry-bibliography text:style-name="References_20_-_20_Default" text:bibliography-data-field="year"/>
              <text:index-entry-span>.</text:index-entry-span>
            </text:bibliography-entry-template>
            <text:bibliography-entry-template text:bibliography-type="misc" text:style-name="Bibliography_20_1">
              <text:index-entry-span text:style-name="References_20_-_20_Default">[</text:index-entry-span>
              <text:index-entry-bibliography text:style-name="References_20_-_20_Default" text:bibliography-data-field="custom1"/>
              <text:index-entry-span text:style-name="References_20_-_20_Default">] </text:index-entry-span>
              <text:index-entry-bibliography text:style-name="References_20_-_20_Default" text:bibliography-data-field="author"/>
              <text:index-entry-span text:style-name="References_20_-_20_Default">, </text:index-entry-span>
              <text:index-entry-bibliography text:style-name="References_20_-_20_Italic" text:bibliography-data-field="title"/>
              <text:index-entry-span text:style-name="References_20_-_20_Default">, </text:index-entry-span>
              <text:index-entry-span>, </text:index-entry-span>
              <text:index-entry-bibliography text:style-name="References_20_-_20_Default" text:bibliography-data-field="year"/>
              <text:index-entry-span>.</text:index-entry-span>
            </text:bibliography-entry-template>
            <text:bibliography-entry-template text:bibliography-type="phdthesis" text:style-name="Bibliography_20_1">
              <text:index-entry-span text:style-name="References_20_-_20_Default">[</text:index-entry-span>
              <text:index-entry-bibliography text:style-name="References_20_-_20_Default" text:bibliography-data-field="custom1"/>
              <text:index-entry-span text:style-name="References_20_-_20_Default">] </text:index-entry-span>
              <text:index-entry-bibliography text:style-name="References_20_-_20_Default" text:bibliography-data-field="author"/>
              <text:index-entry-span text:style-name="References_20_-_20_Default">, </text:index-entry-span>
              <text:index-entry-bibliography text:style-name="References_20_-_20_Italic" text:bibliography-data-field="title"/>
              <text:index-entry-span text:style-name="References_20_-_20_Default">, </text:index-entry-span>
              <text:index-entry-bibliography text:style-name="References_20_-_20_Default" text:bibliography-data-field="publisher"/>
              <text:index-entry-span text:style-name="References_20_-_20_Default">, </text:index-entry-span>
              <text:index-entry-bibliography text:bibliography-data-field="address"/>
              <text:index-entry-span>, </text:index-entry-span>
              <text:index-entry-bibliography text:style-name="References_20_-_20_Default" text:bibliography-data-field="year"/>
              <text:index-entry-span>.</text:index-entry-span>
            </text:bibliography-entry-template>
            <text:bibliography-entry-template text:bibliography-type="proceedings" text:style-name="Bibliography_20_1">
              <text:index-entry-span text:style-name="References_20_-_20_Default">[</text:index-entry-span>
              <text:index-entry-bibliography text:style-name="References_20_-_20_Default" text:bibliography-data-field="custom1"/>
              <text:index-entry-span text:style-name="References_20_-_20_Default">] </text:index-entry-span>
              <text:index-entry-bibliography text:style-name="References_20_-_20_Default" text:bibliography-data-field="author"/>
              <text:index-entry-span text:style-name="References_20_-_20_Default">, </text:index-entry-span>
              <text:index-entry-bibliography text:style-name="References_20_-_20_Italic" text:bibliography-data-field="title"/>
              <text:index-entry-span text:style-name="References_20_-_20_Default">, </text:index-entry-span>
              <text:index-entry-bibliography text:style-name="References_20_-_20_Default" text:bibliography-data-field="publisher"/>
              <text:index-entry-span text:style-name="References_20_-_20_Default">, </text:index-entry-span>
              <text:index-entry-bibliography text:bibliography-data-field="address"/>
              <text:index-entry-span>, </text:index-entry-span>
              <text:index-entry-bibliography text:style-name="References_20_-_20_Default" text:bibliography-data-field="year"/>
              <text:index-entry-span>.</text:index-entry-span>
            </text:bibliography-entry-template>
            <text:bibliography-entry-template text:bibliography-type="techreport" text:style-name="Bibliography_20_1">
              <text:index-entry-span text:style-name="References_20_-_20_Default">[</text:index-entry-span>
              <text:index-entry-bibliography text:style-name="References_20_-_20_Default" text:bibliography-data-field="custom1"/>
              <text:index-entry-span text:style-name="References_20_-_20_Default">] </text:index-entry-span>
              <text:index-entry-bibliography text:style-name="References_20_-_20_Default" text:bibliography-data-field="author"/>
              <text:index-entry-span text:style-name="References_20_-_20_Default">, </text:index-entry-span>
              <text:index-entry-bibliography text:style-name="References_20_-_20_Italic" text:bibliography-data-field="title"/>
              <text:index-entry-span text:style-name="References_20_-_20_Default">, </text:index-entry-span>
              <text:index-entry-bibliography text:style-name="References_20_-_20_Default" text:bibliography-data-field="publisher"/>
              <text:index-entry-span text:style-name="References_20_-_20_Default">, </text:index-entry-span>
              <text:index-entry-bibliography text:bibliography-data-field="address"/>
              <text:index-entry-span>, </text:index-entry-span>
              <text:index-entry-bibliography text:style-name="References_20_-_20_Default" text:bibliography-data-field="year"/>
              <text:index-entry-span>.</text:index-entry-span>
            </text:bibliography-entry-template>
            <text:bibliography-entry-template text:bibliography-type="unpublished" text:style-name="Bibliography_20_1">
              <text:index-entry-span text:style-name="References_20_-_20_Default">[</text:index-entry-span>
              <text:index-entry-bibliography text:style-name="References_20_-_20_Default" text:bibliography-data-field="custom1"/>
              <text:index-entry-span text:style-name="References_20_-_20_Default">] </text:index-entry-span>
              <text:index-entry-bibliography text:style-name="References_20_-_20_Default" text:bibliography-data-field="author"/>
              <text:index-entry-span text:style-name="References_20_-_20_Default">, </text:index-entry-span>
              <text:index-entry-bibliography text:style-name="References_20_-_20_Italic" text:bibliography-data-field="title"/>
              <text:index-entry-span text:style-name="References_20_-_20_Default">, </text:index-entry-span>
              <text:index-entry-bibliography text:style-name="References_20_-_20_Default" text:bibliography-data-field="publisher"/>
              <text:index-entry-span text:style-name="References_20_-_20_Default">, </text:index-entry-span>
              <text:index-entry-bibliography text:bibliography-data-field="address"/>
              <text:index-entry-span>, </text:index-entry-span>
              <text:index-entry-bibliography text:style-name="References_20_-_20_Default" text:bibliography-data-field="year"/>
              <text:index-entry-span>.</text:index-entry-span>
            </text:bibliography-entry-template>
            <text:bibliography-entry-template text:bibliography-type="www" text:style-name="Bibliography_20_1">
              <text:index-entry-span text:style-name="References_20_-_20_Default">[</text:index-entry-span>
              <text:index-entry-bibliography text:style-name="References_20_-_20_Default" text:bibliography-data-field="custom1"/>
              <text:index-entry-span text:style-name="References_20_-_20_Default">] </text:index-entry-span>
              <text:index-entry-bibliography text:style-name="References_20_-_20_Default" text:bibliography-data-field="author"/>
              <text:index-entry-span text:style-name="References_20_-_20_Default">, </text:index-entry-span>
              <text:index-entry-bibliography text:style-name="References_20_-_20_Italic" text:bibliography-data-field="title"/>
              <text:index-entry-span text:style-name="References_20_-_20_Default">, </text:index-entry-span>
              <text:index-entry-bibliography text:style-name="References_20_-_20_Default" text:bibliography-data-field="publisher"/>
              <text:index-entry-span text:style-name="References_20_-_20_Default">, </text:index-entry-span>
              <text:index-entry-bibliography text:bibliography-data-field="address"/>
              <text:index-entry-span>, </text:index-entry-span>
              <text:index-entry-bibliography text:style-name="References_20_-_20_Default" text:bibliography-data-field="year"/>
              <text:index-entry-span>.</text:index-entry-span>
            </text:bibliography-entry-template>
          </text:bibliography-source>
          <text:index-body>
             <xsl:apply-templates/>
          </text:index-body>
        </text:bibliography>
  </xsl:template> 
  
  <xsl:template match="ltx:bibliography/ltx:title">
  	<text:p text:style-name="heading1">
  		<xsl:apply-templates/>
  	</text:p>
  </xsl:template>
  
  <xsl:template match="ltx:bibblock//*">
  	<xsl:apply-templates/>
  </xsl:template>
  
  <xsl:template match="ltx:bibblock//ltx:text">
  	<xsl:apply-templates/>
  	<xsl:message> cannot deal with element <xsl:value-of select="name()"/> yet! </xsl:message>
  	<xsl:comment> Text formatting error here </xsl:comment>
  </xsl:template>
  
  <xsl:template match="ltx:bibblock//ltx:text[@class]">
  	<xsl:apply-templates/>
  </xsl:template>
  
  <xsl:template match="ltx:bibblock//ltx:text[@font='bold']">
  <text:span text:style-name="bold">
  <xsl:apply-templates/>
  </text:span>
  </xsl:template>
  
  <xsl:template match="ltx:bibblock//ltx:text[@fontsize='small']">
  	<text:span text:style-name="small">
  		<xsl:apply-templates/>
  	</text:span>
  </xsl:template>
  
  <xsl:template match="ltx:text[@font='italic']">
  	<text:span text:style-name="italic">
  		<xsl:apply-templates/>
  	</text:span>
  </xsl:template>
  
  <xsl:template match="ltx:paragraph">
  	<xsl:apply-templates/>
  </xsl:template>
  
  <xsl:template match="ltx:paragraph/ltx:title">
  	<text:p text:style-name="heading3">
  		<xsl:apply-templates/>
  	</text:p>
  </xsl:template>
  
  <xsl:template match="ltx:text[@font='medium']">
  	<xsl:apply-templates/>
  </xsl:template>
  
  <xsl:template match="ltx:figure">
  	<xsl:apply-templates/>
  </xsl:template>
  
  <xsl:template match="ltx:bibblock//ltx:text[@font='italic']">
  	<text:span text:style-name="italic">
  		<xsl:apply-templates/>
  	</text:span>
  </xsl:template>
  
  <xsl:template match="ltx:text[@font='normal']">
  	<xsl:apply-templates/>
  </xsl:template>

  <xsl:template match="ltx:bib-publisher">
    <xsl:apply-templates/>
  </xsl:template> 



  
  
<xsl:template match="ltx:bib-note">
	<xsl:apply-templates/>
</xsl:template>
  <xsl:template match="ltx:biblist">
    <xsl:apply-templates/>
  </xsl:template> 
  
  <xsl:template match="ltx:bibtag"/>

   <xsl:template match="ltx:bibitem">
    <text:p>
      <text:span text:style-name="bold">
      	[<xsl:value-of select="./ltx:bibtag[@role='refnum']"/>]
	</text:span>
      <xsl:apply-templates/>
    </text:p>
  </xsl:template>

  <xsl:template match="b:Sources">
    <xsl:apply-templates/>
  </xsl:template> 
  
  <xsl:template match="ltx:bibblock">
  	<xsl:apply-templates/>
  </xsl:template>

  <xsl:template match="b:Source">
    <text:bibliography-mark text:bibliography-type="{./b:SourceType/text()}" text:custom2="{./b:Tag/text()}">
      <xsl:if test="./b:Author">
        <xsl:attribute name="text:author">
          <xsl:for-each select="./b:Author/b:Author/b:NameList/b:Person">
            <xsl:if test="not(position()=1)">,</xsl:if>
            <xsl:value-of select="concat(./b:First,' ')"/>
            <xsl:value-of select="./b:Last"/>
          </xsl:for-each>
        </xsl:attribute>
      </xsl:if>
      <xsl:variable name="foo"><xsl:value-of select="./b:Tag/text()"/></xsl:variable>
      <xsl:attribute name="text:identifier"><xsl:value-of select="$bibliography/ltx:biblist/ltx:bibitem[@key=$foo]/ltx:bibtag[@role='refnum']"/></xsl:attribute>
      <xsl:if test="./b:Title">
        <xsl:attribute name="text:title">
          <xsl:value-of select="./b:Title/text()"/>
        </xsl:attribute>
      </xsl:if>
      <xsl:if test="./b:Year">
        <xsl:attribute name="text:year">
          <xsl:value-of select="./b:Year/text()"/>
        </xsl:attribute>
      </xsl:if>
      <xsl:if test="./b:Publisher">
        <xsl:attribute name="text:publisher">
          <xsl:value-of select="./b:Publisher/text()"/>
        </xsl:attribute>
      </xsl:if>
      <xsl:if test="./b:City">
        <xsl:attribute name="text:address">
          <xsl:value-of select="./b:City/text()"/>
        </xsl:attribute>
      </xsl:if>
      <xsl:if test="./b:Month">
        <xsl:attribute name="text:month">
          <xsl:value-of select="./b:Month/text()"/>
        </xsl:attribute>
      </xsl:if>
      <xsl:if test="./b:BookTitle">
        <xsl:attribute name="text:booktitle">
          <xsl:value-of select="./b:BookTitle/text()"/>
        </xsl:attribute>
      </xsl:if>
      <xsl:if test="./b:Pages">
        <xsl:attribute name="text:pages">
          <xsl:value-of select="./b:Pages/text()"/>
        </xsl:attribute>
      </xsl:if>
      <xsl:if test="./b:ConferenceName">
        <xsl:attribute name="text:organziation">
          <xsl:value-of select="./b:ConferenceName/text()"/>
        </xsl:attribute>
      </xsl:if>
      <xsl:if test="./b:Url">
        <xsl:attribute name="text:url">
          <xsl:value-of select="./b:Url/text()"/>
        </xsl:attribute>
      </xsl:if>
      <xsl:if test="b:issn">
        <xsl:attribute name="text:issn"><xsl:value-of select="./b:issn/text()"/></xsl:attribute>
      </xsl:if>
      <xsl:if test="b:isbn">
        <xsl:attribute name="text:isbn"><xsl:value-of select="./b:isbn/text()"/></xsl:attribute>
      </xsl:if>
      <xsl:if test="b:chapter">
      	<xsl:attribute name="text:chapter"><xsl:value-of select="./b:chapter/text()"/></xsl:attribute>
      </xsl:if>
      <xsl:if test="./b:Note">
      	<xsl:attribute name="text:note"><xsl:value-of select="./b:Note/text()"/></xsl:attribute>
      </xsl:if>
      <xsl:if test="./b:Edition">
      	<xsl:attribute name="text:edition"><xsl:value-of select="./b:Edition"/></xsl:attribute>
      </xsl:if>
      <xsl:attribute name="text:custom1"><xsl:value-of select="$bibliography/ltx:biblist/ltx:bibitem[@key=$foo]/ltx:bibtag[@role='refnum']"/></xsl:attribute>
      <xsl:apply-templates/>
    </text:bibliography-mark>
  </xsl:template> 

  <xsl:template match="b:SourceType"/>
  <xsl:template match="b:Tag"/>
  <xsl:template match="b:Author"/>
  <xsl:template match="b:Title"/>
  <xsl:template match="b:Year"/>
  <xsl:template match="b:Publisher"/>
  <xsl:template match="b:City"/>
  <xsl:template match="b:Month"/>
  <xsl:template match="b:BookTitle"/>
  <xsl:template match="b:Pages"/>
  <xsl:template match="b:ConferenceName"/>
  <xsl:template match="b:Url"/>
  <xsl:template match="b:issn"/>
  <xsl:template match="b:isbn"/>
  <xsl:template match="b:chapter"/>
  <xsl:template match="b:Note"/>
  <xsl:template match="b:Edition"/>
</xsl:stylesheet>
