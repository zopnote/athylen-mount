
find_package(LLVM REQUIRED CONFIG)

if(NOT LLVM_BINARY_DIR)
    message(FATAL_ERROR "LLVM not found. Specify LLVM_BINARY_DIR and LLVM_LIBRARY_DIR directly.")
endif()

if(CMAKE_SYSTEM_NAME STREQUAL Windows)
    set(LLVM_SHARED_LIB_BINARIES
        ${LLVM_BINARY_DIR}/bin/LLVM-C${PLATFORM_DYLIB_ENDING}
        ${LLVM_BINARY_DIR}/bin/libclang${PLATFORM_DYLIB_ENDING}
    )
    file(GLOB LLVM_LIBRARIES ${LLVM_LIBRARY_DIR}/*.lib)

else()
    set(LLVM_SHARED_LIB_BINARIES
        ${LLVM_LIBRARY_DIR}/libLLVM${PLATFORM_DYLIB_ENDING}
        ${LLVM_LIBRARY_DIR}/libclang${PLATFORM_DYLIB_ENDING}
    )
    file(GLOB LLVM_LIBRARIES ${LLVM_LIBRARY_DIR}/lib*.a)
endif()

add_library(LLVM INTERFACE)

target_include_directories(LLVM INTERFACE ${LLVM_INCLUDE_DIRS})

target_link_libraries(LLVM INTERFACE ${LLVM_LIBRARIES})

install(FILES ${LLVM_SHARED_LIB_BINARIES} DESTINATION bin)