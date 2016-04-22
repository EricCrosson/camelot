cmake_minimum_required (VERSION 3.2)
project (Promela)

SET (ARGS "-DN=5" CACHE STRING "Compile-time arguments passed to spin")

function(make_simple_promela_command pmlfile)
    get_filename_component(shortfile ${pmlfile} NAME_WE)
    add_custom_command (
        OUTPUT ${CMAKE_CURRENT_BINARY_DIR}/${shortfile}.c
        COMMAND spin -m -a ${ARGS} ${pmlfile}
        COMMAND mv ${CMAKE_CURRENT_BINARY_DIR}/pan.c ${CMAKE_CURRENT_BINARY_DIR}/${shortfile}.c
    )
    add_executable (${shortfile} ${CMAKE_CURRENT_BINARY_DIR}/${shortfile}.c)
endfunction(make_simple_promela_command)

function(make_promela_command pmlfile assertfile)
    get_filename_component(shortfile ${pmlfile} NAME_WE)
    get_filename_component(assertname ${assertfile} NAME)
    get_filename_component(assertname ${assertname} EXT)
    string(REPLACE "." "" assertname ${assertname})
    add_custom_command (
        OUTPUT ${CMAKE_CURRENT_BINARY_DIR}/${shortfile}_${assertname}.c
        COMMAND spin -m -a ${ARGS} -N ${assertfile} ${pmlfile}
        COMMAND mv ${CMAKE_CURRENT_BINARY_DIR}/pan.c ${CMAKE_CURRENT_BINARY_DIR}/${shortfile}_${assertname}.c
    )
    add_executable (${shortfile}_${assertname} ${CMAKE_CURRENT_BINARY_DIR}/${shortfile}_${assertname}.c)
endfunction(make_promela_command)

function(make_binary pmlfile)
    get_filename_component(shortfile ${pmlfile} NAME_WE)
    file(GLOB assertfiles "${shortfile}.*")
    # if assert files are defined, compile with assert files
    foreach(assertfile ${assertfiles})
        if(assertfile STREQUAL pmlfile)
            continue()
        endif()
        make_promela_command(${pmlfile} ${assertfile})
    endforeach()
    # if no assertfiles were defined, still have to compile
    if (not assertfiles)
        make_simple_promela_command(${pmlfile})
    endif()

endfunction(make_binary)


file(GLOB sources "*.pml")
foreach(source ${sources})
    make_binary (${source})
endforeach()
