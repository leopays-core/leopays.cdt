--- hello Project ---

 -- How to Build with CMake and Make --
   - mkdir build
   - cd into the 'build' directory
   - run the command 'cmake ..'
   - run the command 'make'

 - After build -
   - The built smart contract is under the 'hello' directory in the 'build' directory
   - You can then do a 'set contract' action with 'leopays-cli' and point to the './build/hello' directory

- Additions to cmake should be done to the CMakeLists.txt in the './src' directory and not in the top level CMakeLists.txt

 -- How to build with leopays-cpp --
   - mkdir build
   - cd into the 'build' directory
   - run the command 'leopays-cpp -abigen ../src/hello.cpp -o hello.wasm -I ../include/'

 - After build -
   - The built smart contract is in the 'build' directory
   - You can then do a 'set contract' action with 'leopays-cli' and point to the 'build' directory
