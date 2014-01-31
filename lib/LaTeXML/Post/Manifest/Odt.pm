# /=====================================================================\ #
# | LaTeXML::Post::Manifest::ODT                                        | #
# | Manifest creation for ODT                                           | #
# |=====================================================================| #
# | Part of LaTeXML:                                                    | #
# |  Public domain software, produced as part of work done by the       | #
# |  United States Government & not subject to copyright in the US.     | #
# |---------------------------------------------------------------------| #
# | Lukas Kohlhase <l.kohlhase@jacobs-university.de>            #_#     | #
# | Michael Kohlhase <m.kohlhase@jacobs-university.de>          #_#     | #
# | http://dlmf.nist.gov/LaTeXML/                              (o o)    | #
# \=========================================================ooo==U==ooo=/ #
package LaTeXML::Post::Manifest::Odt;
use strict;
use warnings;

use base qw(LaTeXML::Post::Manifest);
use File::Spec::Functions qw(catdir catfile);
use XML::LibXML;
use LaTeXML::Util::Pathname;
use LaTeXML::Post;    # for error handling!
our $odt_manifest_namespace = "urn:oasis:names:tc:opendocument:xmlns:manifest:1.0";
our $manifest_static = <<"EOL";
<?xml version="1.0"?>
<manifest:manifest manifest:version="1.2" xmlns:manifest="$odt_manifest_namespace"> 
  <manifest:file-entry manifest:media-type="application/vnd.oasis.opendocument.text" manifest:full-path="/"/>
  <manifest:file-entry manifest:media-type="text/xml" manifest:full-path="content.xml"/>
  <manifest:file-entry manifest:media-type="text/xml" manifest:full-path="meta.xml"/>
  <manifest:file-entry manifest:media-type="text/xml" manifest:full-path="settings.xml"/>
  <manifest:file-entry manifest:media-type="text/xml" manifest:full-path="styles.xml"/>
</manifest:manifest>
EOL

sub new {
  my ($class, %options) = @_;
  my $self = $class->SUPER::new(%options);
  return $self; }

our %media_types = ('png'=>'image/png','jpg'=>'','jpeg'=>'');
sub initialize {
  my ($self, $doc) = @_;
  my $directory = $$self{siteDirectory};
  my $pictures_directory = catdir($directory,'Pictures');
  # Generate all auxiliary file and structure.
  # 1. Create mimetype declaration
  open my $odt_fh, ">", pathname_concat($directory, 'mimetype');
  print $odt_fh 'application/vnd.oasis.opendocument.text';
  close $odt_fh;
  # 2. Create META-INF metadata directory
  my $meta_inf_dir = catdir($directory, 'META-INF');
  mkdir $meta_inf_dir;
  # 2.1. Add the manifest.xml description (to be extended later)
  my $manifest_dom = XML::LibXML->load_xml(string => $manifest_static);
  #Index all CSS files (written already)
  opendir(my $pictures_handle, $pictures_directory);
  my @files = readdir($pictures_handle);
  closedir $pictures_handle;
  my $relative_pictures_directory = pathname_relative($pictures_directory,$directory);
  my @images = map {catfile($relative_pictures_directory,$_)}
  	grep { /\.(png|jpg|jpeg)$/i && -f pathname_concat($pictures_directory, $_) } @files;
  my $manifest_element = $manifest_dom->documentElement;
  foreach my $image_file(@images) {
  	my $extension;
  	if ($image_file =~ /\.(png|jpg|jpeg)$/) {$extension = $1;}
  	my $file_entry = $manifest_element->addNewChild($odt_manifest_namespace, "file-entry");
  	$file_entry->setAttributeNS($odt_manifest_namespace,'full-path',$image_file);
  	$file_entry->setAttributeNS($odt_manifest_namespace,'media-type',$media_types{$extension}); }
  my $manifest_content = $manifest_dom->toString(1);
  open my $manifest_fh, ">" . pathname_concat($meta_inf_dir, 'manifest.xml');
  print $manifest_fh $manifest_content;
  close $manifest_fh;

  # Copy static files from ODT-Skeleton
  foreach my $static_resource(qw(settings meta styles)) {
    my $static_path = pathname_find($static_resource,types=>['xml'],installation_subdir=>catdir('resources','ODT-Skeleton'));
    if ($static_path) {
    	pathname_copy($static_path,$directory); }
    else { Error('I/O',$static_resource,undef,"Couldn't find ODT static resource: $static_resource.xml");} }
  return; }

sub process {
  my ($self, @docs) = @_;
  $self->initialize($docs[0]);
  foreach my $doc (@docs) {
    # Add each document to the spine manifest
    if (my $destination = $doc->getDestination) {
      # my (undef, $name, $ext) = pathname_split($destination);
      # my $file = "$name.$ext";
      # my $relative_destination = pathname_relative($destination, $$self{OPS_directory});

      # Add to manifest
        # my $manifest = $$self{opf_manifest};
        # my $item = $manifest->addNewChild(undef, 'item');
        # $item->setAttribute('id',         $file);
        # $item->setAttribute('href',       $relative_destination);
        # $item->setAttribute('media-type', "application/xhtml+xml");
        # my @properties;
        # push @properties, 'mathml' if $doc->findnode('//*[local-name() = "math"]');
        # push @properties, 'svg'    if $doc->findnode('//*[local-name() = "svg"]');
        # my $properties = join(" ", @properties);
        # $item->setAttribute('properties', $properties) if $properties;

      # Add to spine
        # my $spine = $$self{opf_spine};
        # my $itemref = $spine->addNewChild(undef, 'itemref');
        # $itemref->setAttribute('idref', $file);

      # Add to navigation
        # my $nav_map = $$self{nav_map};
        # my $nav_li  = $nav_map->addNewChild(undef, 'li');
        # my $nav_a   = $nav_li->addNewChild(undef, 'a');
        # $nav_a->setAttribute('href', $file);
        # $nav_a->appendText($file); } 
  } }
  return; }

1;
