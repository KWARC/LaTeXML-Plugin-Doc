#======================================================================
# Makefile Maker for LaTeXML::Plugin::Doc - LaTeXML Doc post-processor
# [emails]
#======================================================================
use strict;
use warnings;

use ExtUtils::MakeMaker;

WriteMakefile(
  NAME => 'LaTeXML::Plugin::Doc',
  AUTHOR => 'Lukas Kohlahse <email>',
  ABSTRACT => "LaTeXML::Plugin::Doc - A LaTeXML post-processor for Word and OpenOffice",
  VERSION_FROM => 'lib/LaTeXML/Post/Manifest/Doc.pm',
  PREREQ_PM => {
    'LaTeXML' => '0.7.9',
  },
  test => {TESTS => 't/*.t'}
);
