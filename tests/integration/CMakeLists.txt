cmake_minimum_required( VERSION 3.5 )

set(LEOPAYS_VERSION_MIN "0.1")
set(LEOPAYS_VERSION_SOFT_MAX "0.1")
#set(LEOPAYS_VERSION_HARD_MAX "")

find_package(leopays)

### Check the version of LeoPays
set(VERSION_MATCH_ERROR_MSG "")
LEOPAYS_CHECK_VERSION(VERSION_OUTPUT "${LEOPAYS_VERSION}"
                                   "${LEOPAYS_VERSION_MIN}"
                                   "${LEOPAYS_VERSION_SOFT_MAX}"
                                   "${LEOPAYS_VERSION_HARD_MAX}"
                                   VERSION_MATCH_ERROR_MSG)
if(VERSION_OUTPUT STREQUAL "MATCH")
   message(STATUS "Using LeoPays version ${LEOPAYS_VERSION}")
elseif(VERSION_OUTPUT STREQUAL "WARN")
   message(WARNING "Using LeoPays version ${LEOPAYS_VERSION} even though it exceeds the maximum supported version of ${LEOPAYS_VERSION_SOFT_MAX}; continuing with configuration, however build may fail.\nIt is recommended to use LeoPays version ${LEOPAYS_VERSION_SOFT_MAX}.x")
else() # INVALID OR MISMATCH
   message(FATAL_ERROR "Found LeoPays version ${LEOPAYS_VERSION} but it does not satisfy version requirements: ${VERSION_MATCH_ERROR_MSG}\nPlease use LeoPays version ${LEOPAYS_VERSION_SOFT_MAX}.x")
endif(VERSION_OUTPUT STREQUAL "MATCH")


enable_testing()

configure_file(${CMAKE_SOURCE_DIR}/contracts.hpp.in ${CMAKE_BINARY_DIR}/contracts.hpp)

include_directories(${CMAKE_BINARY_DIR})

file(GLOB INT_TESTS "*.cpp" "*.hpp")

add_leopays_test( integration_tests ${INT_TESTS} )
