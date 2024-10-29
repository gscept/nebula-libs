#-------------------------------------------------------------------------------
#   Wrap ispc code generation
#

if(FIPS_LINUX)
    set(folder linux)
elseif(FIPS_MACOS)
    set(folder osx)
else()
    set(folder win64)
endif()

FIND_PROGRAM(ISPC
       NAMES ispc.exe ispc
       PATHS ${FIPS_PROJECT_DIR}/../nebula-libs/ispc/bin/${folder}
       NO_DEFAULT_PATH
       )


macro(compile_ispc)
    foreach(fb ${ARGN})
        get_filename_component(f_abs ${CurDir}${fb} ABSOLUTE)
        get_filename_component(f_dir ${f_abs} PATH)        
        STRING(REPLACE ".ispc" ".h" out_header ${fb})
        STRING(REPLACE ".ispc" ".o" out_obj ${fb})
        STRING(FIND "${CMAKE_CURRENT_SOURCE_DIR}"  "/" last REVERSE)
        STRING(SUBSTRING "${CMAKE_CURRENT_SOURCE_DIR}" ${last}+1 -1 folder)
        set(abs_output_folder "${CMAKE_BINARY_DIR}/ispc/${CurTargetName}/${CurDir}")
        
        set(output_header ${abs_output_folder}/${out_header})
        set(output_obj ${abs_output_folder}/${out_obj})
        
        add_custom_command(OUTPUT ${output_header} ${output_obj}
                PRE_BUILD COMMAND ${ISPC} --target=avx2 --arch=x86_64 "${f_abs}" --header-outfile=${output_header} -o "${output_obj}" 
                MAIN_DEPENDENCY ${f_abs}
                DEPENDS ${ISPC}
                WORKING_DIRECTORY ${FIPS_PROJECT_DIR}
                COMMENT "Compiling ${fb} ispc"
                VERBATIM
                )
        fips_files(${fb})

        target_sources(${CurTargetName} PRIVATE "${output_header}" "${output_obj}")
        target_include_directories(${CurTargetName} PRIVATE ${CMAKE_BINARY_DIR}/ispc)
        SOURCE_GROUP("${CurGroup}\\Generated\\ispc" FILES "${output_header}")
        source_group("${CurGroup}" FILES ${f_abs})
    endforeach()
endmacro()