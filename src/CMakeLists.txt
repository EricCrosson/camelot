cmake_minimum_required (VERSION 3.2)
project (formal-verification-final-project)

set(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/bin)


# I WONDER: does this work with multiple srcs? first line would be the worrisome
# part
function(make_promela_binary_no_tests srcs)
    add_custom_command (
        OUTPUT ${CMAKE_BINARY_DIR}/${PROJECT_NAME}.c
        COMMAND spin -m -a ${ARGS} ${srcs}
        COMMAND mv ${CMAKE_CURRENT_BINARY_DIR}/pan.c ${CMAKE_BINARY_DIR}/${PROJECT_NAME}.c
        COMMAND mv ${CMAKE_CURRENT_BINARY_DIR}/pan.* ${CMAKE_BINARY_DIR}/
    )
    add_executable (${PROJECT_NAME} ${CMAKE_BINARY_DIR}/${PROJECT_NAME}.c)
endfunction(make_promela_binary_no_tests)


function(make_promela_binary assertfile srcs)
    # get name of assert
    get_filename_component(assertname ${assertfile} NAME_WE)

    add_custom_command (
        OUTPUT ${CMAKE_BINARY_DIR}/${PROJECT_NAME}_${assertname}.c
        COMMAND spin -m -a ${ARGS} -N ${assertfile} ${srcs}
        COMMAND mv ${CMAKE_CURRENT_BINARY_DIR}/pan.c ${CMAKE_BINARY_DIR}/${PROJECT_NAME}_${assertname}.c
        COMMAND mv ${CMAKE_CURRENT_BINARY_DIR}/pan.* ${CMAKE_BINARY_DIR}/
    )
    add_executable (${PROJECT_NAME}_${assertname} ${CMAKE_BINARY_DIR}/${PROJECT_NAME}_${assertname}.c)
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
add_subdirectory (tolerant_szymanski)
