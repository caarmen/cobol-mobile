cmake_minimum_required(VERSION 3.22.1)

project("answer")
find_program(COBC cobc REQUIRED)

set(COBOL_FILES
        AnswerToLife
        JNI
        ShowToast
)
set(COB_COPY_DIR "${CMAKE_CURRENT_SOURCE_DIR}/../cobol")
set(GENERATED_C_FILES)

foreach(COBOL_FILE ${COBOL_FILES})
    set(INPUT_COB "${CMAKE_CURRENT_SOURCE_DIR}/../cobol/${COBOL_FILE}.cob")
    set(OUTPUT_C "${CMAKE_CURRENT_BINARY_DIR}/generated_c/${COBOL_FILE}.c")
    add_custom_command(
            OUTPUT ${OUTPUT_C}
            COMMAND COB_COPY_DIR=${COB_COPY_DIR} ${COBC} -d -g -C ${INPUT_COB}
            WORKING_DIRECTORY "${CMAKE_CURRENT_BINARY_DIR}/generated_c"
            DEPENDS ${INPUT_COB}
            COMMENT "Transpiling ${COBOL_FILE}.cob to C"
    )
    list(APPEND GENERATED_C_FILES ${OUTPUT_C})
    set_source_files_properties(${OUTPUT_C} PROPERTIES GENERATED TRUE)
endforeach ()

add_custom_target(transpile_cobol DEPENDS ${GENERATED_C_FILES})

add_library(${PROJECT_NAME} SHARED
        AnswerToLifeJni.cpp
        ${GENERATED_C_FILES}
)
add_dependencies(${PROJECT_NAME} transpile_cobol)

find_package(cob REQUIRED CONFIG)
set_target_properties(cob::libcob PROPERTIES IMPORTED_SONAME "libcob.so")

target_link_libraries(${PROJECT_NAME}
        cob::libcob
        android
        log
)
get_target_property(LIBCOB_INCLUDE_DIRS cob::libcob INTERFACE_INCLUDE_DIRECTORIES)
#get_target_property(TEMP_PATHS cob::libcob INTERFACE_INCLUDE_DIRECTORIES)
#message(FATAL_ERROR "DEBUG: libcob headers are located at: ${LIBCOB_INCLUDE_DIRS}")

target_link_options(${PROJECT_NAME} PRIVATE
        "-Wl,-z,max-page-size=16384"
        "-Wl,-z,common-page-size=16384"
)

target_include_directories(${PROJECT_NAME} PRIVATE
        ${LIBCOB_INCLUDE_DIRS}
        ${CMAKE_CURRENT_BINARY_DIR}
)