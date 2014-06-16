
<xsl:stylesheet
    version     = "1.0"
    xmlns:ltx   = "http://dlmf.nist.gov/LaTeXML"
    xmlns:exsl="http://exslt.org/common"
    xmlns:xsl   = "http://www.w3.org/1999/XSL/Transform"
<<<<<<< HEAD
    extension-element-prefixes="exsl"
=======
    xmlns:exsl  = "http://exslt.org/common"
>>>>>>> b7491a989e1830b663cfa593a2158a5e6b977eaa
    exclude-result-prefixes = "ltx">
    <xsl:output method="xml" indent="yes"/>
<xsl:template match="ltx:document">
<root>
 <xsl:apply-templates/> </root>
 </xsl:template>
    <xsl:template match="text()"/>
    <xsl:variable name="foo">
    <ltx:bibtag class="ltx_bib_author" role="authors">asdfasdfasf</ltx:bibtag>
    </xsl:variable>
    <xsl:template match="ltx:resource">
    <xsl:apply-templates select="exsl:node-set($foo)"/>
    </xsl:template>
    <xsl:template match="ltx:bibtag">
    <xsl:copy-of select="."/>
    </xsl:template>
    </xsl:stylesheet>



