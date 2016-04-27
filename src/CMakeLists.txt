cmake_minimum_required (VERSION 3.2)
project (formal-verification-final-project C)

SET(ARGS "-DN=4" CACHE STRING "User specified arguments to spin")
set(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/bin)


# Note: these make_promela_binary commands do not accempt multiple srcs
function(make_promela_binary_no_tests src)
    get_filename_component(srcname ${src} NAME_WE)
    add_custom_command (
        OUTPUT ${CMAKE_BINARY_DIR}/${srcname}.c
        COMMAND spin -m -a ${ARGS} ${src}
        COMMAND mv ${CMAKE_CURRENT_BINARY_DIR}/pan.c ${CMAKE_BINARY_DIR}/${srcname}.c
        COMMAND mv ${CMAKE_CURRENT_BINARY_DIR}/pan.* ${CMAKE_BINARY_DIR}/
    )
    add_executable (${srcname} ${CMAKE_BINARY_DIR}/${srcname}.c)
endfunction(make_promela_binary_no_tests)


function(make_promela_binary assertfile src)
    # get name of assert
    get_filename_component(assertname ${assertfile} NAME_WE)
    get_filename_component(srcname ${src} NAME_WE)

    add_custom_command (
        OUTPUT ${CMAKE_BINARY_DIR}/${srcname}_${assertname}.c
        COMMAND spin -m -a ${ARGS} -N ${assertfile} ${src}
        COMMAND mv ${CMAKE_CURRENT_BINARY_DIR}/pan.c ${CMAKE_BINARY_DIR}/${srcname}_${assertname}.c
        COMMAND mv ${CMAKE_CURRENT_BINARY_DIR}/pan.* ${CMAKE_BINARY_DIR}/
    )
    add_executable (${srcname}_${assertname} ${CMAKE_BINARY_DIR}/${srcname}_${assertname}.c)
endfunction(make_promela_binary)


# Given the srcs necessary to compile a test, build one binary per assertfile,
# or one binary with all srcs if no assertfiles exist
function(make_binaries srcs)
    file(GLOB_RECURSE assertfiles "../test/*")
    # if assert files are defined, compile with assert files
    foreach(assertfile ${assertfiles})
        make_promela_binary(${assertfile} ${srcs})
    endforeach()
    # if no assertfiles were defined, still have to compile
    if (NOT assertfiles)
        make_promela_binary_no_tests(${srcs})
    endif()
endfunction(make_binaries)


add_subdirectory (lamport)
add_subdirectory (tokenring)
add_subdirectory (szymanski)
add_subdirectory (philosophers)
