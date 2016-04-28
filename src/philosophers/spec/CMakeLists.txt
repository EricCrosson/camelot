cmake_minimum_required (VERSION 3.0.2)

project(philosophers C)
SET(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/bin/${PROJECT_NAME})

SET (ARGS "-DN=5" CACHE STRING "Compile-time arguments passed to spin")

file(GLOB philosophers-srcs "*.pml")
make_binaries (${philosophers-srcs})
