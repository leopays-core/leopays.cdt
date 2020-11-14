include(ExternalProject)
# if no cdt root is given use default path
if(LEOPAYS_CDT_ROOT STREQUAL "" OR NOT LEOPAYS_CDT_ROOT)
   find_package(leopays.cdt)
endif()

ExternalProject_Add(
   multi_index_example_project
   SOURCE_DIR ${CMAKE_SOURCE_DIR}/src
   BINARY_DIR ${CMAKE_BINARY_DIR}/multi_index_example
   CMAKE_ARGS -DCMAKE_TOOLCHAIN_FILE=${LEOPAYS_CDT_ROOT}/lib/cmake/leopays.cdt/LeoPaysWasmToolchain.cmake
   UPDATE_COMMAND ""
   PATCH_COMMAND ""
   TEST_COMMAND ""
   INSTALL_COMMAND ""
   BUILD_ALWAYS 1
)