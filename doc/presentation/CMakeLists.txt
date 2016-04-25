cmake_minimum_required(VERSION 2.7)
project (presentation)
include (../UseLATEX.cmake)

set (doc-staging-area "./doc-staging")

add_latex_document (
  presentation.tex
  CONFIGURE presentation.tex
  DEFAULT_PDF
)
