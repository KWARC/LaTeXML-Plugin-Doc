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

sub new {
  my ($class, %options) = @_;
  my $self = $class->SUPER::new(%options);
  return $self; }

sub initialize {
  my ($self, $doc) = @_; #I am assuming that tex2docx was applied to *.tex already
  my $directory = $$self{siteDirectory};
  # Copy static files from ODT-Skeleton
  my $content_types = pathname_find('[Content_Types]',types=>['xml'],installation_subdir=>catdir('resources','WML-Skeleton'));
  my $skeleton_directory = pathname_directory($content_types);
  if ($skeleton_directory) {
    foreach my $subdirectory (qw/_rels word docProps/, catdir('word','_rels'), catdir('word','media')) { #create the file structure
      mkdir(catdir($directory, $subdirectory)); }
    # Annoying, but let's copy each of the 6 static files individually:
    my @static_files = (
      [ catfile($skeleton_directory,'docProps','app.xml'), catdir($directory,'docProps') ],
      [ catfile($skeleton_directory,'docProps','core.xml'), catdir($directory,'docProps') ],
      [ catfile($skeleton_directory,'word','fontTable.xml'), catdir($directory,'word') ],
      [ catfile($skeleton_directory,'word','settings.xml'), catdir($directory,'word') ],
      [ catfile($skeleton_directory,'word','styles.xml'), catdir($directory,'word') ],
      [ catfile($skeleton_directory,'[Content_Types].xml'), catdir($directory,'.')]);
    foreach my $static_file(@static_files) {
      pathname_copy($static_file->[0],  $static_file->[1]); } } #populate the file structure
  else {
    Error('I/O',$content_types,undef,"Couldn't find WML static resource: $content_types.xml"); }
  
  my $document_final =catfile($directory,'word','document.xml');
  my $cleanup_stylesheet = LaTeXML::Post::XSLt->new (stylesheet ==> 'cleaner.xsl', noresources => 1); 
  my $final_document = $cleanup_stylesheet->process($doc); #We create document.xml by applying cleaner.xsl to document1.xml
  $final_document->{destination} =$document_final;
  my $document_rels = catfile($directory,'word','_rels','document.xml.rels');
  my $rels_stylesheet = LaTeXML::Post::XSLT->new(stylesheet => 'relations.xsl', noresources => 1);
    # We need to create the document.xml.rels by applying a stylesheet to document1.xml:
  # TODO Rename relations.xsl to docx-relations.xsl
  my $rels_document = $rels_stylesheet->process($doc);
  $rels_document->{destination} = $document_rels;
  # TODO: Think about whether just using LibXML won't be simpler
  my $writer = LaTeXML::Post::Writer->new(format=>'xml',omit_doctype=>0);
  $writer->process($rels_document,$rels_document->getDocumentElement);
  # TODO Sort pictures into media 
  # TODO zip everything and rename it. 
  
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
