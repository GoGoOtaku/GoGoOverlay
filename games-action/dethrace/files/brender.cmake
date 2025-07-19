cmake_minimum_required(VERSION 3.10)

set(BRender_DIR "BRender-1.3.2/")
find_package(BRender COMPONENTS Full DDI  REQUIRED GLOBAL)
include_directories(${BRENDER_INCLUDE_DIR})

