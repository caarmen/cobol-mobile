#============================================================================
# Build the AnswerToLife procedure from COBOL source to a shared library
# libanswer.so.
#============================================================================
cmake_minimum_required(VERSION 3.22.1)

project("answer")
set(COBOL_FILES
        AnswerToLife
)
set(C_FILES
        AnswerToLifeJni.c
)
set(GENERATED_C_FILES)

find_program(COBC cobc REQUIRED)

foreach(COBOL_FILE ${COBOL_FILES})
    set(INPUT_COB "${CMAKE_CURRENT_SOURCE_DIR}/../../../../shared/src/commonMain/cobol/${COBOL_FILE}.cob")
    set(OUTPUT_C "${CMAKE_CURRENT_BINARY_DIR}/generated_c/${COBOL_FILE}.c")
    add_custom_command(
            OUTPUT ${OUTPUT_C}
            COMMAND ${COBC} -g -C ${INPUT_COB}
            WORKING_DIRECTORY "${CMAKE_CURRENT_BINARY_DIR}/generated_c"
            DEPENDS ${INPUT_COB}
            COMMENT "Transpiling ${COBOL_FILE}.cob to C"
    )
    list(APPEND GENERATED_C_FILES ${OUTPUT_C})
    set_source_files_properties(${OUTPUT_C} PROPERTIES GENERATED TRUE)
endforeach ()
add_custom_target(transpile_cobol DEPENDS ${GENERATED_C_FILES})

add_library(${PROJECT_NAME} SHARED
        ${C_FILES}
        ${GENERATED_C_FILES}
)
add_dependencies(${PROJECT_NAME} transpile_cobol)

find_package(gnucobol-android REQUIRED CONFIG)
set_target_properties(gnucobol-android::cob PROPERTIES IMPORTED_SONAME "libcob.so")
get_target_property(LIBCOB_INCLUDE_DIRS gnucobol-android::cob INTERFACE_INCLUDE_DIRECTORIES)

target_link_libraries(${PROJECT_NAME}
        gnucobol-android::cob
        android
        log
)

target_link_options(${PROJECT_NAME} PRIVATE
        "-Wl,-z,max-page-size=16384"
        "-Wl,-z,common-page-size=16384"
)

target_include_directories(${PROJECT_NAME} PRIVATE
        ${LIBCOB_INCLUDE_DIRS}
        ${CMAKE_CURRENT_BINARY_DIR}
)