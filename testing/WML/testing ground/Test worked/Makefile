CDS = quant2.ocd quant3.ocd
OMDoc = $(CDS:%.ocd=%.omdoc)
XHTML = $(CDS:%.ocd=%.xhtml)

JOMDOC = ~/omdoc/bin/jomdoc/bleeding-edge/jomdoc
CD2OMDOC = ~/omdoc/xsl2/adapt/cd2omdoc.xsl
$(XHTML): %.xhtml: %.omdoc 
	  $(JOMDOC) -t -X -o $@ render $<

$(OMDoc): %.omdoc: %.ocd $(CD2OMDOC)
	  xsltproc -o $@ $(CD2OMDOC) $<
