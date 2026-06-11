cmake_minimum_required(VERSION 3.22.1)

project("answer")
find_program(COBC cobc REQUIRED)

add_custom_command(
        OUTPUT ${CMAKE_CURRENT_BINARY_DIR}/AnswerToLife.c
        COMMAND ${COBC} -C ${CMAKE_CURRENT_SOURCE_DIR}/../cobol/AnswerToLife.cob
        WORKING_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}
        DEPENDS ${CMAKE_CURRENT_SOURCE_DIR}/../cobol/AnswerToLife.cob
        COMMENT "Transpiling COBOL to C"
)
add_custom_target(transpile_cobol DEPENDS ${CMAKE_CURRENT_BINARY_DIR}/AnswerToLife.c)

add_library(${PROJECT_NAME} SHARED
        AnswerToLifeJni.c
        ${CMAKE_CURRENT_BINARY_DIR}/AnswerToLife.c
)
add_dependencies(${PROJECT_NAME} transpile_cobol)

find_package(cob REQUIRED CONFIG)
set_target_properties(cob::libcob PROPERTIES IMPORTED_SONAME "libcob.so")
get_target_property(LIBCOB_INCLUDE_DIRS cob::libcob INTERFACE_INCLUDE_DIRECTORIES)

target_link_libraries(${PROJECT_NAME}
        cob::libcob
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