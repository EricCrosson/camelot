cmake_minimum_required (VERSION 2.8.11)
project (Promela)

file(GLOB sources "*.pml")


function(make_binary pmlfile)

    get_filename_component(shortfile ${pmlfile} NAME_WE)
    message(${CMAKE_CURRENT_BINARY_DIR}/${shortfile})
    add_custom_command (
        OUTPUT ${CMAKE_CURRENT_BINARY_DIR}/${shortfile}.c
        COMMAND spin -m -a ${pmlfile}
        COMMAND mv ${CMAKE_CURRENT_BINARY_DIR}/pan.c ${CMAKE_CURRENT_BINARY_DIR}/${shortfile}.c
    )
    
    add_executable (${shortfile} ${CMAKE_CURRENT_BINARY_DIR}/${shortfile}.c)
endfunction(make_binary)


foreach(source ${sources})
    message (${source})
    make_binary (${source})
endforeach()
