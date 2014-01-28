# /=====================================================================\ #
# |  LaTeXML::Post::Manifest::ODT                                       | #
# | Manifest creation for EPUB                                          | #
# |=====================================================================| #
# | Part of LaTeXML:                                                    | #
# |  Public domain software, produced as part of work done by the       | #
# |  United States Government & not subject to copyright in the US.     | #
# |---------------------------------------------------------------------| #
# | Bruce Miller <bruce.miller@nist.gov>                        #_#     | #
# | http://dlmf.nist.gov/LaTeXML/                              (o o)    | #
# \=========================================================ooo==U==ooo=/ #
package LaTeXML::Post::Manifest::ODT;
use strict;
use warnings;

use base qw(LaTeXML::Post::Manifest);
use LaTeXML::Util::Pathname;
use File::Spec::Functions qw(catdir);
use LaTeXML::Post;    # for error handling!

our $manifest_content = <<'EOL';
<?xml version="1.0"?>
<manifest:manifest office:version="1.2"
 xmlns:manifest="urn:oasis:names:tc:opendocument:xmlns:manifest:1.0" 
 xmlns:ltx="http://dlmf.nist.gov/LaTeXML" 
 xmlns:office="urn:oasis:names:tc:opendocument:xmlns:office:1.0">
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

sub initialize {
  my ($self, $doc) = @_;
  my $directory = $$self{siteDirectory};
  # Generate all auxiliary file and structure.
  # 1. Create mimetype declaration
  open my $odt_fh, ">", pathname_concat($directory, 'mimetype');
  print $odt_fh 'application/vnd.oasis.opendocument.text';
  close $odt_fh;
  # 2. Create META-INF metadata directory
  my $meta_inf_dir = catdir($directory, 'META-INF');
  mkdir $meta_inf_dir;
  # 2.1. Add the manifest.xml description (to be extended later)
  open my $manifest_fh, ">" . pathname_concat($meta_inf_dir, 'manifest.xml');
  print $manifest_fh $manifest_content;
  close $container_fh;
  # 3. Create OPS content container
  # 3.1 OPS/content.opf XML Spine
  # Metadata
  # Fish out any existing unique identifier for the book
  #       the UUID is the fallback default
  # Manifest
  # .. manifest generation
  # To store the generated content (since we are not writing to disk here yet) use the Manifest object:
    # $$self{OPS_directory} = $OPS_directory;
    # $$self{opf}           = $opf;
    # $$self{opf_spine}     = $spine;
    # $$self{opf_manifest}  = $manifest;
    # $$self{nav}           = $nav;
    # $$self{nav_map}       = $nav_map;
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
  $self->finalize;
  return; }

sub finalize {
  my ($self) = @_;
  # Write everything to disk:

  #Index all CSS files (written already)
  # Write the content.opf file to disk
  # my $directory = $$self{siteDirectory};
  # my $OPF_FH;
  # my $content_path = pathname_concat($OPS_directory, 'content.opf');
  # open($OPF_FH, ">", $content_path)
  #   or Fatal('I/O', 'content.opf', undef, "Couldn't open '$content_path' for writing: $_");
  # print $OPF_FH $$self{opf}->toString(1);
  # close $OPF_FH;

  # Write toc.ncx file to disk
  # my $NAV_FH;
  # my $nav_path = pathname_concat($OPS_directory, 'nav.xhtml');
  # open($NAV_FH, ">", $nav_path)
  #   or Fatal('I/O', 'nav.xhtml', undef, "Couldn't open '$nav_path' for writing: $!");
  # print $NAV_FH $$self{nav}->toString(1);
  # close $NAV_FH;

  return (); }

1;
