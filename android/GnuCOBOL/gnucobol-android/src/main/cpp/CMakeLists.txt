cmake_minimum_required(VERSION 3.22.1)
project("cobjni")

add_library(${CMAKE_PROJECT_NAME} SHARED
        native-lib.cpp
)
if(${ANDROID_ABI} STREQUAL "arm64-v8a")
    set(LIB_COB_FOLDER_ARCH "aarch64")
else()
    set(LIB_COB_FOLDER_ARCH ${ANDROID_ABI})
endif()

# BEGIN Hack to include libcob in the prefab aar
# https://medium.com/lightricks-tech-blog/packaging-native-code-with-prefab-a-solution-for-imported-prebuilt-binaries-801348e306c4
add_library(cob SHARED dummy.cpp)
add_custom_command(TARGET cob POST_BUILD
        COMMAND ${CMAKE_COMMAND} -E copy $ENV{HOME}/.local/cobol-android-${LIB_COB_FOLDER_ARCH}-linux-android/lib/libcob.so $<TARGET_FILE:cob>
)
# END hack

target_include_directories(${PROJECT_NAME} PRIVATE
        $ENV{HOME}/.local/cobol-android-${LIB_COB_FOLDER_ARCH}-linux-android/include
        ${CMAKE_CURRENT_BINARY_DIR}
)

target_link_directories(
        ${CMAKE_PROJECT_NAME}
        PRIVATE $ENV{HOME}/.local/cobol-android-${LIB_COB_FOLDER_ARCH}-linux-android/lib
)

target_link_libraries(${CMAKE_PROJECT_NAME}
        cob
        android
        log
)