cmake_minimum_required(VERSION 2.7)
project (report C)
include (../UseLATEX.cmake)

set (doc-staging-area "./doc-staging")

add_latex_document (
  report.tex
  BIBFILES research.bib
  CONFIGURE report.tex
  DEFAULT_PDF
  COMMAND bibtex report
  COMMAND pdflatex report.tex
)
