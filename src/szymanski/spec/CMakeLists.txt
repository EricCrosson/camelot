cmake_minimum_required (VERSION 3.0.2)

project(szymanski C)
SET(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/bin/${PROJECT_NAME})

SET (ARGS "-E-I../lib/ -L" CACHE STRING "Compile-time arguments passed to spin")

file(GLOB szymanski-srcs "*.pml")
foreach(szymanski-source ${szymanski-srcs})
  make_binaries (${szymanski-source})
endforeach()
