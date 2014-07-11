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
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:ltx="http://dlmf.nist.gov/LaTeXML" xmlns:office="urn:oasis:names:tc:opendocument:xmlns:office:1.0" xmlns:style="urn:oasis:names:tc:opendocument:xmlns:style:1.0" xmlns:text="urn:oasis:names:tc:opendocument:xmlns:text:1.0" xmlns:table="urn:oasis:names:tc:opendocument:xmlns:table:1.0" xmlns:draw="urn:oasis:names:tc:opendocument:xmlns:drawing:1.0" xmlns:fo="urn:oasis:names:tc:opendocument:xmlns:xsl-fo-compatible:1.0" xmlns:xlink="http://www.w3.org/1999/xlink" xmlns:dc="http://purl.org/dc/elements/1.1/" xmlns:meta="urn:oasis:names:tc:opendocument:xmlns:meta:1.0" xmlns:number="urn:oasis:names:tc:opendocument:xmlns:datastyle:1.0" xmlns:svg="urn:oasis:names:tc:opendocument:xmlns:svg-compatible:1.0" xmlns:chart="urn:oasis:names:tc:opendocument:xmlns:chart:1.0" xmlns:dr3d="urn:oasis:names:tc:opendocument:xmlns:dr3d:1.0" xmlns:math="http://www.w3.org/1998/Math/MathML" xmlns:form="urn:oasis:names:tc:opendocument:xmlns:form:1.0" xmlns:script="urn:oasis:names:tc:opendocument:xmlns:script:1.0" xmlns:ooo="http://openoffice.org/2004/office" xmlns:ooow="http://openoffice.org/2004/writer" xmlns:oooc="http://openoffice.org/2004/calc" xmlns:dom="http://www.w3.org/2001/xml-events" xmlns:xforms="http://www.w3.org/2002/xforms" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:rpt="http://openoffice.org/2005/report" xmlns:of="urn:oasis:names:tc:opendocument:xmlns:of:1.2" xmlns:xhtml="http://www.w3.org/1999/xhtml" xmlns:grddl="http://www.w3.org/2003/g/data-view#" xmlns:officeooo="http://openoffice.org/2009/office" xmlns:tableooo="http://openoffice.org/2009/table" xmlns:drawooo="http://openoffice.org/2010/draw" xmlns:calcext="urn:org:documentfoundation:names:experimental:calc:xmlns:calcext:1.0" xmlns:field="urn:openoffice:names:experimental:ooo-ms-interop:xmlns:field:1.0" xmlns:formx="urn:openoffice:names:experimental:ooxml-odf-interop:xmlns:form:1.0" xmlns:css3t="http://www.w3.org/TR/css3-text/" version="1.0" exclude-result-prefixes="ltx">
  <xsl:output method="xml" encoding="utf-8"/>
  <!-- fallback for debugging -->
  <xsl:template match="*">
    <xsl:message>cannot deal with element <xsl:value-of select="local-name()"/> yet!</xsl:message>
    <xsl:comment>cannot deal with element <xsl:value-of select="local-name()"/> here yet!</xsl:comment>
  </xsl:template>
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
      </office:font-face-decls>
      <office:automatic-styles>
      <style:style style:name="P2" style:family="paragraph" style:parent-style-name="Preformatted_20_Text"><style:text-properties officeooo:paragraph-rsid="001edd4d"/></style:style>
      <style:style style:name="bold" style:family="text" style:parent-style-name="Preformatted_20_Text"><style:text-properties fo:font-weight="bold"/></style:style>
      <style:style style:name="italic" style:family="text" style:parent-style-name="Preformatted_20_Text"><style:text-properties fo:font-style="italic"/></style:style>
      <!-- most text processing is done here --> 
      </office:automatic-styles>
      <office:body>
        <office:text>
          <xsl:apply-templates/>
        </office:text>
      </office:body>
    </office:document-content>
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
  <xsl:template match="ltx:section/ltx:title">
  <text:p text:style-name="heading1"><text:toc-mark-start text:id="{generate-id(.)}" text:outline-level="1"/> <xsl:apply-templates/><text:toc-mark-end text:id="{generate-id(.)}"/></text:p>
  </xsl:template>
  <xsl:template match="ltx:creator">
  <text:p text:style-name="author"><xsl:apply-templates/></text:p>
  </xsl:template>
  <xsl:template match="ltx:personname">
  	<xsl:apply-templates/>
  </xsl:template>
  <xsl:template match="ltx:title/ltx:tag">
  	<xsl:apply-templates/>
  	<text:s/>
  </xsl:template>
  <xsl:template match="ltx:item/ltx:tag"/>
  <xsl:template match="ltx:subsection">
  	<xsl:apply-templates/>
  </xsl:template>
  <xsl:template match="ltx:subsection/ltx:title">
  	<text:p text:style-name="heading2">
  		<text:toc-mark-start text:id="{generate-id(.)}" text:outline-level="2"/> <xsl:apply-templates/><text:toc-mark-end text:id="{generate-id(.)}"/>
  	</text:p>
  </xsl:template>
    <xsl:template match="ltx:subsubsection">
  	<xsl:apply-templates/>
  </xsl:template>
  <xsl:template match="ltx:subsubsection/ltx:title">
  	<text:p text:style-name="heading2">
  		<text:toc-mark-start text:id="{generate-id(.)}" text:outline-level="3"/> <xsl:apply-templates/><text:toc-mark-end text:id="{generate-id(.)}"/>
  	</text:p>
  </xsl:template>
  <xsl:template match="ltx:TOC">
  <text:table-of-content>
  <text:table-of-content-source text:use-index-marks="true"/>
  <text:index-body><text:index-title text:style-name="Sect1" text:name="Table of Contents1_Head"><text:p text:style-name="Contents_20_Heading">Please update this Table</text:p></text:index-title></text:index-body> <!-- This message will disappear when the user updates the table. Till then, they are asked to update the table of contents -->
  </text:table-of-content>
  </xsl:template>
  <xsl:template match="ltx:break">
  <text:line-break/>
  </xsl:template>
  <xsl:template match="ltx:document/ltx:title">
  <text:p text:style-name="title"><xsl:apply-templates/></text:p>
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
  <xsl:template match="ltx:tr">
  <table:table-row>
  	<xsl:apply-templates/>
  </table:table-row>
  </xsl:template>
  <xsl:template match="ltx:td">
  <table:table-cell>
  	<text:p>
  		<xsl:apply-templates/>
  	</text:p>
  </table:table-cell>
  </xsl:template> <!-- TODO Add support for table-styles. --> 
  <xsl:template match="ltx:note[@role='footnote']">
  <text:note text:note-class="footnote">
  	<text:note-citation><xsl:value-of select="@mark"/></text:note-citation>
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
  
    <xsl:template match="ltx:text[@font='italic']">
  <text:span text:style-name="italic">
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
  <xsl:template match="ltx:item">
  <text:list-item >
  <xsl:apply-templates/>
  </text:list-item>
  </xsl:template>
  
  <xsl:template match="ltx:graphics[ancestor::ltx:p]">
  <draw:frame text:anchor-type="as-char" svg:y="-0.1366in" draw:z-index="0"><draw:image xlink:href="Pictures/10000201000001AB0000004C7C3B6A12.png" xlink:type="simple" xlink:show="embed" xlink:actuate="onLoad"><text:p/></draw:image><svg:title>TexMaths</svg:title><svg:desc>12§inline§$a^2+b^2=c^2$§png§600§TRUE</svg:desc></draw:frame>
  </xsl:template>
  <xsl:template match="bookmark">
  <text:bookmark text:name="@name"/>
  </xsl:template>
  <xsl:template match="ltx:ref[@idref]">
  <text:a xlink:type="simple" xlink:href="{concat('#',@idref)}"><xsl:apply-templates/></text:a>
  </xsl:template>
</xsl:stylesheet>
