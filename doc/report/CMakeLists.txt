cmake_minimum_required(VERSION 2.7)
project (report)
include (../UseLATEX.cmake)

set (doc-staging-area "./doc-staging")
set (CMAKE_CXX_COMPILER "/usr/bin/gcc")

add_latex_document (
  report.tex
  CONFIGURE report.tex
  DEFAULT_PDF
)
