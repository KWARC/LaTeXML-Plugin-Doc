LaTeXML::Plugin::Doc
=======================

LaTeXML post-processing target for the DOC (MS Word), ODT (Open/LibreOffice Writer), and
DocBook formats. Still very much under development, but eventually, you should be able to
just type
```
latexmlc paper --destination=paper.docx
latexmlc paper --destination=paper.odt
latexmlc paper --format=DocBook --destination=paper.xml
```
to transform ```paper.tex``` into a document in one of the formats above. 
