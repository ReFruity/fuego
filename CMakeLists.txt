cmake_minimum_required(VERSION 3.6)
project(fuego)

set(CMAKE_CXX_STANDARD 14)

# TODO: Exclude mains from glob
file(GLOB SOURCE_FILES **/*.cpp)
add_executable(fuego ${SOURCE_FILES})

target_include_directories(fuego PUBLIC fuegomain smartgame go gouct gtpengine features simpleplayers)

target_include_directories(fuego PUBLIC "$ENV{BOOST_ROOT}/include")
target_link_directories(fuego PUBLIC "$ENV{BOOST_ROOT}/lib")
target_link_libraries(fuego PUBLIC libboost_chrono.a)
target_link_libraries(fuego PUBLIC libboost_date_time.a)
target_link_libraries(fuego PUBLIC libboost_filesystem.a)
target_link_libraries(fuego PUBLIC libboost_prg_exec_monitor.a)
target_link_libraries(fuego PUBLIC libboost_program_options.a)
target_link_libraries(fuego PUBLIC libboost_system.a)
target_link_libraries(fuego PUBLIC libboost_test_exec_monitor.a)
target_link_libraries(fuego PUBLIC libboost_thread.a)
target_link_libraries(fuego PUBLIC libboost_timer.a)
target_link_libraries(fuego PUBLIC libboost_unit_test_framework.a)
