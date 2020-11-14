configure_file(${CMAKE_CURRENT_SOURCE_DIR}/eosio-cc.cpp.in ${CMAKE_BINARY_DIR}/leopays-cc.cpp)

configure_file(${CMAKE_CURRENT_SOURCE_DIR}/eosio-cpp.cpp.in ${CMAKE_BINARY_DIR}/leopays-cpp.cpp)

add_tool(leopays-cc)
add_tool(leopays-cpp)
