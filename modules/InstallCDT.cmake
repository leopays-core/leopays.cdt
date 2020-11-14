add_custom_command( TARGET LeoPaysClang POST_BUILD COMMAND mkdir -p ${CMAKE_BINARY_DIR}/bin )
macro( leopays_clang_install file )
   set(BINARY_DIR ${CMAKE_BINARY_DIR}/leopays_llvm/bin)
   add_custom_command( TARGET LeoPaysClang POST_BUILD COMMAND ${CMAKE_COMMAND} -E copy ${BINARY_DIR}/${file} ${CMAKE_BINARY_DIR}/bin/ )
   install(FILES ${BINARY_DIR}/${file}
      DESTINATION ${CDT_INSTALL_PREFIX}/bin
      PERMISSIONS OWNER_READ OWNER_EXECUTE GROUP_READ GROUP_EXECUTE WORLD_READ WORLD_EXECUTE)
endmacro( leopays_clang_install )

macro( leopays_clang_install_and_symlink file symlink )
   set(BINARY_DIR ${CMAKE_BINARY_DIR}/leopays_llvm/bin)
   add_custom_command( TARGET LeoPaysClang POST_BUILD COMMAND ${CMAKE_COMMAND} -E copy ${BINARY_DIR}/${file} ${CMAKE_BINARY_DIR}/bin/ )
   add_custom_command( TARGET LeoPaysClang POST_BUILD COMMAND cd ${CMAKE_BINARY_DIR}/bin && ln -sf ${file} ${symlink} )
   install(FILES ${BINARY_DIR}/${file}
      DESTINATION ${CDT_INSTALL_PREFIX}/bin
      PERMISSIONS OWNER_READ OWNER_EXECUTE GROUP_READ GROUP_EXECUTE WORLD_READ WORLD_EXECUTE)
   install(CODE "execute_process( COMMAND ${CMAKE_COMMAND} -E make_directory ${CMAKE_INSTALL_PREFIX}/bin)")
   install(CODE "execute_process( COMMAND ${CMAKE_COMMAND} -E create_symlink ${CDT_INSTALL_PREFIX}/bin/${file} ${CMAKE_INSTALL_PREFIX}/bin/${symlink})")
endmacro( leopays_clang_install_and_symlink )

macro( leopays_tool_install file )
   set(BINARY_DIR ${CMAKE_BINARY_DIR}/tools/bin)
   add_custom_command( TARGET LeoPaysTools POST_BUILD COMMAND ${CMAKE_COMMAND} -E copy ${BINARY_DIR}/${file} ${CMAKE_BINARY_DIR}/bin/ )
   install(FILES ${BINARY_DIR}/${file}
      DESTINATION ${CDT_INSTALL_PREFIX}/bin
      PERMISSIONS OWNER_READ OWNER_EXECUTE GROUP_READ GROUP_EXECUTE WORLD_READ WORLD_EXECUTE)
endmacro( leopays_tool_install )

macro( leopays_tool_install_and_symlink file symlink )
   set(BINARY_DIR ${CMAKE_BINARY_DIR}/tools/bin)
   add_custom_command( TARGET LeoPaysTools POST_BUILD COMMAND ${CMAKE_COMMAND} -E copy ${BINARY_DIR}/${file} ${CMAKE_BINARY_DIR}/bin/ )
   install(FILES ${BINARY_DIR}/${file}
      DESTINATION ${CDT_INSTALL_PREFIX}/bin
      PERMISSIONS OWNER_READ OWNER_EXECUTE GROUP_READ GROUP_EXECUTE WORLD_READ WORLD_EXECUTE)
   install(CODE "execute_process( COMMAND ${CMAKE_COMMAND} -E make_directory ${CMAKE_INSTALL_PREFIX}/bin)")
   install(CODE "execute_process( COMMAND ${CMAKE_COMMAND} -E create_symlink ${CDT_INSTALL_PREFIX}/bin/${file} ${CMAKE_INSTALL_PREFIX}/bin/${symlink})")
endmacro( leopays_tool_install_and_symlink )

macro( leopays_cmake_install_and_symlink file symlink )
   set(BINARY_DIR ${CMAKE_BINARY_DIR}/modules)
   install(CODE "execute_process( COMMAND ${CMAKE_COMMAND} -E make_directory ${CMAKE_INSTALL_PREFIX}/lib/cmake/leopays.cdt)")
   install(CODE "execute_process( COMMAND ${CMAKE_COMMAND} -E create_symlink ${CDT_INSTALL_PREFIX}/lib/cmake/leopays.cdt/${file} ${CMAKE_INSTALL_PREFIX}/lib/cmake/leopays.cdt/${symlink})")
endmacro( leopays_cmake_install_and_symlink )

macro( leopays_libraries_install)
   execute_process(COMMAND ${CMAKE_COMMAND} -E make_directory ${CMAKE_BINARY_DIR}/lib)
   execute_process(COMMAND ${CMAKE_COMMAND} -E make_directory ${CMAKE_BINARY_DIR}/include)
   install(DIRECTORY ${CMAKE_BINARY_DIR}/lib/ DESTINATION ${CDT_INSTALL_PREFIX}/lib)
   install(DIRECTORY ${CMAKE_BINARY_DIR}/include/ DESTINATION ${CDT_INSTALL_PREFIX}/include)
endmacro( leopays_libraries_install )

leopays_clang_install_and_symlink(llvm-ranlib leopays-ranlib)
leopays_clang_install_and_symlink(llvm-ar leopays-ar)
leopays_clang_install_and_symlink(llvm-nm leopays-nm)
leopays_clang_install_and_symlink(llvm-objcopy leopays-objcopy)
leopays_clang_install_and_symlink(llvm-objdump leopays-objdump)
leopays_clang_install_and_symlink(llvm-readobj leopays-readobj)
leopays_clang_install_and_symlink(llvm-readelf leopays-readelf)
leopays_clang_install_and_symlink(llvm-strip leopays-strip)

leopays_clang_install(opt)
leopays_clang_install(llc)
leopays_clang_install(lld)
leopays_clang_install(ld.lld)
leopays_clang_install(ld64.lld)
leopays_clang_install(clang-7)
leopays_clang_install(wasm-ld)

leopays_tool_install_and_symlink(leopays-pp leopays-pp)
leopays_tool_install_and_symlink(leopays-wast2wasm leopays-wast2wasm)
leopays_tool_install_and_symlink(leopays-wasm2wast leopays-wasm2wast)
leopays_tool_install_and_symlink(leopays-cc leopays-cc)
leopays_tool_install_and_symlink(leopays-cpp leopays-cpp)
leopays_tool_install_and_symlink(leopays-ld leopays-ld)
leopays_tool_install_and_symlink(leopays-abigen leopays-abigen)
leopays_tool_install_and_symlink(leopays-abidiff leopays-abidiff)
leopays_tool_install_and_symlink(leopays-init leopays-init)

leopays_clang_install(../lib/LLVMLeoPaysApply${CMAKE_SHARED_LIBRARY_SUFFIX})
leopays_clang_install(../lib/LLVMLeoPaysSoftfloat${CMAKE_SHARED_LIBRARY_SUFFIX})
leopays_clang_install(../lib/leopays_plugin${CMAKE_SHARED_LIBRARY_SUFFIX})

leopays_cmake_install_and_symlink(leopays.cdt-config.cmake leopays.cdt-config.cmake)
leopays_cmake_install_and_symlink(LeoPaysWasmToolchain.cmake LeoPaysWasmToolchain.cmake)
leopays_cmake_install_and_symlink(LeoPaysCDTMacros.cmake LeoPaysCDTMacros.cmake)

leopays_libraries_install()
