cmake_minimum_required (VERSION 3.0.2)

project(tolerant_szymanski)
SET(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/bin/${PROJECT_NAME})

SET (ARGS "-N 4 -E-I../lib/" CACHE STRING "Compile-time arguments passed to spin")

file(GLOB tolerant_szymanski-srcs "*.pml")
make_binaries (${tolerant_szymanski-srcs})
