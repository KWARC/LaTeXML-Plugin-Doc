# /=====================================================================\ #
# | LaTeXML::Post::Manifest::Docx                                       | #
# | Manifest creation for Docx                                          | #
# |=====================================================================| #
# | Part of LaTeXML:                                                    | #
# |  Public domain software, produced as part of work done by the       | #
# |  United States Government & not subject to copyright in the US.     | #
# |---------------------------------------------------------------------| #
# | Lukas Kohlhase <l.kohlhase@jacobs-university.de>            #_#     | #
# | Michael Kohlhase <m.kohlhase@jacobs-university.de>          #_#     | #
# | http://dlmf.nist.gov/LaTeXML/                              (o o)    | #
# \=========================================================ooo==U==ooo=/ #

#This is for transforming to .docx when there is no .bib file present or the user wants it to have most functions in non Microsoft Word text editors. 
package LaTeXML::Post::Manifest::Docx;
use strict;
use warnings;
use base qw(LaTeXML::Post::Manifest);
use File::Spec::Functions qw(catdir catfile);
use XML::LibXML;
use LaTeXML::Util::Pathname;
use LaTeXML::Post;    # for error handling!
use LaTeXML::Post::XSLT;
use LaTeXML::Post::Writer;
use File::Find;
use Cwd; 

sub new {
  my ($class, %options) = @_;
  my $self = $class->SUPER::new(%options);
  return $self; }

sub initialize {
  my ($self, $xml) = @_;
  my $bibnode = $xml->findnode('//ltx:bibliography');
  if ($bibnode && $bibnode->getAttribute('files')) {
  	my $bibs=$bibnode->getAttribute('files'); #Find the bibliography that is used 
  	my $transform_stylesheet = LaTeXML::Post::XSLT-> new (stylesheet => 'tex2word.xsl', noresources=>1);
  	my $doc = $transform_stylesheet->process($xml); #Apply tex2word.xsl to the processed document.
  	my $directory = $$self{siteDirectory};
  	# Copy static files from ODT-Skeleton
  	my $content_types = pathname_find('[Content_Types]',types=>['xml'],installation_subdir=>catdir('resources','WML-Skeleton'));
  	my $skeleton_directory = pathname_directory($content_types);
  	if ($skeleton_directory) {
    		foreach my $subdirectory (qw/_rels word docProps customXML/, catdir('word','_rels'),catdir('customXML','_rels'),catdir('word','media')) { #create the file structure
      		mkdir(catdir($directory, $subdirectory)); }
   	 # Annoying, but let's copy each of the static files individually:
   	 my @static_files = (
      		[ catfile($skeleton_directory,'docProps','app.xml'), catdir($directory,'docProps') ],
	      [ catfile($skeleton_directory,'docProps','core.xml'), catdir($directory,'docProps') ],
	      [ catfile($skeleton_directory,'word','fontTable.xml'), catdir($directory,'word') ],
	      [ catfile($skeleton_directory,'word','settings.xml'), catdir($directory,'word') ],
	      [ catfile($skeleton_directory,'word','styles.xml'), catdir($directory,'word') ],
	      [ catfile($skeleton_directory,'word','footnotes.xml'), catdir($directory,'word') ],
	      [ catfile($skeleton_directory,'customXML','_rels','item1.xml.rels'), catdir($directory,'customXML','_rels') ],
	      [ catfile($skeleton_directory,'customXML','itemProps1.xml'), catdir($directory,'customXML') ],
	      [ catfile($skeleton_directory,'_rels','.rels'), catdir($directory,'_rels') ],
	      [ catfile($skeleton_directory,'[Content_Types].xml'), catdir($directory,'.')]);
    	foreach my $static_file(@static_files) {
     		 pathname_copy($static_file->[0],  $static_file->[1]); } } #populate the file structure
 	 else {
   		 Error('I/O',$content_types,undef,"Couldn't find WML static resource: $content_types.xml"); }
  	my $document_footnotes =catfile($directory,'word','footnotes.xml');
  	my $footnotes_stylesheet = LaTeXML::Post::XSLT-> new (stylesheet => 'docx-footnotes.xsl', noresources=>1);
  	my $footnotes_document = $footnotes_stylesheet->process($doc); #We create footnotes.xml by applying footnotes.xsl to document1.xml 
 	 $footnotes_document->{destination}= $document_footnotes;
  	my $document_final =catfile($directory,'word','document.xml');
  	my $cleanup_stylesheet = LaTeXML::Post::XSLT->new (stylesheet => 'docx-cleaner.xsl', noresources => 1); 
 	 my $final_document = $cleanup_stylesheet->process($doc); #We create document.xml by applying cleaner.xsl to document1.xml
  	$final_document->{destination} =$document_final;
  	my $document_rels = catfile($directory,'word','_rels','document.xml.rels');
  	my $rels_stylesheet = LaTeXML::Post::XSLT->new(stylesheet => 'docx-relations.xsl', noresources => 1);
  	  # We need to create the document.xml.rels by applying a stylesheet to document1.xml:
  	my $rels_document = $rels_stylesheet->process($doc);
 	 $rels_document->{destination} = $document_rels;
 	 my $writer = LaTeXML::Post::Writer->new(format=>'xml',omit_doctype=>0);
 	 $writer->process($rels_document,$rels_document->getDocumentElement);
 	 $writer->process($final_document,$final_document->getDocumentElement); 
  	$writer->process($footnotes_document,$footnotes_document->getDocumentElement); 

 	 my $current=cwd();                             
 	 $bibs=$bibnode->getAttribute('files');
	 my $bib=catfile($directory,'bibfile.bib');
   	 my @values = split(',', $bibnode->getAttribute('files'));
	open my $out, ">>$bib" or die "Cannot open temporary bibliography \n";
	foreach my $file (@values)
	{
		$file=$file.'.bib';
		open my $in, "<$file" or die "Cannot open $file!\n";
		while(<$in>)
		{
			print $out $_;
		}
		close $in;
	}	
	close $out;
	  my $bib_pathname= catfile(catdir($directory,'customXML'),'item1.xml');
	  my $cmd= "latexmlc $bib --destination=$bib_pathname";
	  system($cmd);
	  $xml->{destination}=catfile($directory,'paper.ltxml');
	  $writer->process($xml,$xml->getDocumentElement);
	  my $xslt = XML::LibXSLT->new();
	  my $source = XML::LibXML->load_xml(location =>$bib_pathname);
	  my $stylesheetus=catfile(catdir($skeleton_directory,'..','XSLT'),'docx-bibliographies.xsl'); 
	  my $style_doc = XML::LibXML->load_xml(location=>$stylesheetus);
	  my $stylesheet = $xslt->parse_stylesheet($style_doc); 
	  my $temp=catfile($directory,'paper.ltxml');
	  my $results = $stylesheet->transform($source, test =>"'$temp'");
	  $stylesheet->output_file($results,$bib_pathname);
	  unlink $temp;
 
  }
  else { 
	  my $transform_stylesheet = LaTeXML::Post::XSLT-> new (stylesheet => 'tex2docx.xsl', noresources=>1);
	  my $doc = $transform_stylesheet->process($xml); #Apply tex2docx.xsl to the processed document.
	  my $directory = $$self{siteDirectory};
	  # Copy static files from ODT-Skeleton
	  my $content_types = pathname_find('[Content_Types]',types=>['xml'],installation_subdir=>catdir('resources','WML-Skeleton'));
	  my $skeleton_directory = pathname_directory($content_types);
  	if ($skeleton_directory) {
	    foreach my $subdirectory (qw/_rels word docProps customXML/, catdir('word','_rels'),catdir('customXML','_rels'),catdir('word','media')) { #create the file structure
	      	mkdir(catdir($directory, $subdirectory)); }
   		 # Annoying, but let's copy each of the static files individually:
   		 my @static_files = (
		      [ catfile($skeleton_directory,'docProps','app.xml'), catdir($directory,'docProps') ],
		      [ catfile($skeleton_directory,'docProps','core.xml'), catdir($directory,'docProps') ],
		      [ catfile($skeleton_directory,'word','fontTable.xml'), catdir($directory,'word') ],
		      [ catfile($skeleton_directory,'word','settings.xml'), catdir($directory,'word') ],
		      [ catfile($skeleton_directory,'word','styles.xml'), catdir($directory,'word') ],
		      [ catfile($skeleton_directory,'word','footnotes.xml'), catdir($directory,'word') ],
		      [ catfile($skeleton_directory,'customXML','_rels','item1.xml.rels'), catdir($directory,'customXML','_rels') ],
		      [ catfile($skeleton_directory,'customXML','itemProps1.xml'), catdir($directory,'customXML') ],
		      [ catfile($skeleton_directory,'customXML','item1.xml'), catdir($directory,'customXML') ],
		      [ catfile($skeleton_directory,'_rels','.rels'), catdir($directory,'_rels') ],
		      [ catfile($skeleton_directory,'[Content_Types].xml'), catdir($directory,'.')]);
    		foreach my $static_file(@static_files) {
      			pathname_copy($static_file->[0],  $static_file->[1]); } } #populate the file structure
  	else {
   	 Error('I/O',$content_types,undef,"Couldn't find WML static resource: $content_types.xml"); }
 	 my $document_footnotes =catfile($directory,'word','footnotes.xml');
 	 my $footnotes_stylesheet = LaTeXML::Post::XSLT-> new (stylesheet => 'docx-footnotes.xsl', noresources=>1);
 	 my $footnotes_document = $footnotes_stylesheet->process($doc); #We create footnotes.xml by applying footnotes.xsl to document1.xml 
  	$footnotes_document->{destination}= $document_footnotes;
  	my $document_final =catfile($directory,'word','document.xml');
  	my $cleanup_stylesheet = LaTeXML::Post::XSLT->new (stylesheet => 'docx-cleaner.xsl', noresources => 1); 
  	my $final_document = $cleanup_stylesheet->process($doc); #We create document.xml by applying cleaner.xsl to document1.xml
 	 $final_document->{destination} =$document_final;
  	my $document_rels = catfile($directory,'word','_rels','document.xml.rels');
  	my $rels_stylesheet = LaTeXML::Post::XSLT->new(stylesheet => 'docx-relations.xsl', noresources => 1);
   	 # We need to create the document.xml.rels by applying a stylesheet to document1.xml:
 	 my $rels_document = $rels_stylesheet->process($doc);
 	 $rels_document->{destination} = $document_rels;
 
 	 my $writer = LaTeXML::Post::Writer->new(format=>'xml',omit_doctype=>0);
 	 $writer->process($rels_document,$rels_document->getDocumentElement);
 	 $writer->process($final_document,$final_document->getDocumentElement); 
 	 $writer->process($footnotes_document,$footnotes_document->getDocumentElement); 

  	my $current=cwd();
  }                             
  return; }

sub process {
  my ($self, @docs) = @_;
  $self->initialize($docs[0]);
  # If needed: generate data from each of the @docs.
  $self->finalize($docs[0]);
  return; }

sub finalize {
  my ($self,$doc) = @_;
}

1;
