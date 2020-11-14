--- singleton_example Project ---

 -- How to Build with CMake and Make --
   - cd into the 'build' directory
   - run the command 'cmake ..'
   - run the command 'make'

 - After build -
   - The built smart contract is under the 'singleton_example' directory in the 'build' directory
   - You can then do a 'set contract' action with 'leopays-cli' and point to the './build/singleton_example' directory

 - Additions to CMake should be done to the CMakeLists.txt in the './src' directory and not in the top level CMakeLists.txt

 -- How to build with leopays-cpp --
   - cd into the 'build' directory
   - run the command 'leopays-cpp -abigen ../src/singleton_example.cpp -o singleton_example.wasm -I ../include/'

 - After build -
   - The built smart contract is in the 'build' directory
   - You can then do a 'set contract' action with 'leopays-cli' and point to the 'build' directory
