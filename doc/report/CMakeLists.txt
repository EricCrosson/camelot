cmake_minimum_required(VERSION 2.7)
project (report)
include (../UseLATEX.cmake C)

set (doc-staging-area "./doc-staging")

add_latex_document (
  report.tex
  CONFIGURE report.tex
  DEFAULT_PDF
)
