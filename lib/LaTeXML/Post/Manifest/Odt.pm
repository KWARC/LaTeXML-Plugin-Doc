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
package LaTeXML::Post::Manifest::Odt;
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
use XML::LibXSLT;



sub new {
  my ($class, %options) = @_;
  my $self = $class->SUPER::new(%options);
  return $self; }

sub initialize {
  my ($self, $xml) = @_;
  my $stuff=$$xml{destination};
  my $writer = LaTeXML::Post::Writer->new(format=>'xml',omit_doctype=>0);
    my $content_types = pathname_find('[Content_Types]',types=>['xml'],installation_subdir=>catdir('resources','WML-Skeleton'));
  my $skeleton_directory1 = pathname_directory($content_types); #Searching for content.xml didn't lead me to the correct place, so I used the same code as in Word.pm, just sightly modified. 
  #TODO make this code independent of find [Content_Types] . 
  my $skeleton_directory= catdir($skeleton_directory1,'..','ODT-Skeleton');   
  my $transform_stylesheet = LaTeXML::Post::XSLT-> new (stylesheet => 'odt-preparer.xsl', noresources=>1);
  my $doc = $transform_stylesheet->process($xml); #Apply odt-preparer.xsl to the document. This adds some extra bookmarks, so that internal links work better. 
  my $directory = $$self{siteDirectory};
  my $temp=catfile($directory,'temporary.xml');
  my $current=cwd();                             
  $doc->{destination}=catfile($directory,'temporary.xml');
  $writer->process($doc,$doc->getDocumentElement); #Write temporary.xml . odt-bibliographies-interim.xsl will use this file to only transform the needed nodes. 
  my $bibnode = $xml->findnode('//ltx:bibliography');
  my ($bib,$bibs,$bib_pathname,$cmd);
  $bib=catfile($directory,'bibfile.bib');
  if($bibnode){
   	$bibs=$bibnode->getAttribute('files'); #Find the bibliography that is used 
  	 if ($bibs){
  	 	  my @values = split(',', $bibs);
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

  	 	 $bib_pathname= catfile($directory,$bib.'.xml');
  	 	 if(-e $bib){
 	 	 my $cmd= "latexmlc $bib --destination=$bib_pathname"; #Convert the .bib file into semantic XML
	 	 system($cmd);
 		 my $xslt = XML::LibXSLT->new();
 		 my $source = XML::LibXML->load_xml(location =>$bib_pathname);
 	 	 my $stylesheetus=catfile(catdir($skeleton_directory,'..','XSLT'),'odt-bibliographies-interim.xsl'); 
		 my $style_doc = XML::LibXML->load_xml(location=>$stylesheetus);
 		 my $stylesheet = $xslt->parse_stylesheet($style_doc); 
 		 my $results = $stylesheet->transform($source, test =>"'$temp'");
 		 $stylesheet->output_file($results,$bib_pathname);
 		 }
 		 else {
 		 print " \n Bibliography is not at the correct place  \n ";
 		 }
 	 }
  }
  # Copy static files from ODT-Skeleton
  if ($skeleton_directory) {
    foreach my $subdirectory (qw/META-INF/) { #create the file structure
      mkdir(catdir($directory, $subdirectory)); }
    my @static_files = (
      [ catfile($skeleton_directory,'mimetype'), catdir($directory) ],
      [ catfile($skeleton_directory,'styles.xml'), catdir($directory) ]);
    foreach my $static_file(@static_files) {
      pathname_copy($static_file->[0],  $static_file->[1]); } } #populate the file structure
  my $document_final =catfile($directory,'content.xml');
  my $xslt2 = XML::LibXSLT->new();
  my $source2 = XML::LibXML->load_xml(location =>$temp);
  my $stylesheetus2=catfile(catdir($skeleton_directory,'..','XSLT'),'tex2odt.xsl');
  my $style_doc2 = XML::LibXML->load_xml(location=>$stylesheetus2);
  my $stylesheet2 = $xslt2->parse_stylesheet($style_doc2); 
  my $results2 = $stylesheet2->transform($source2, temporary =>"'$bib_pathname'");
  $stylesheet2->output_file($results2,$document_final);
  my $document_rels = catfile($directory,'META-INF','manifest.xml');
  my $xslt3 = XML::LibXSLT->new();
  my $source3= XML::LibXML->load_xml(location =>$document_final);
  my $stylesheetus3=catfile(catdir($skeleton_directory,'..','XSLT'),'odt-manifest.xsl');
  my $style_doc3 = XML::LibXML->load_xml(location=>$stylesheetus3);
  my $stylesheet3 = $xslt3->parse_stylesheet($style_doc3);
  my $asdf=pathname_name($stuff).'.'.pathname_type($stuff);
  my $results3 = $stylesheet3->transform($source3, example =>"'$asdf'");
  $stylesheet3->output_file($results3,$document_rels);
  
  unlink $temp; #remove temporary.xml once it isn't needed anymore. 
  if($bibnode){
  unlink $bib_pathname;
  unlink $bib;
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
