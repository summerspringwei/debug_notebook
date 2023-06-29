cmake_minimum_required(VERSION 3.5.0)

project(imdecoder)
set(OPENCV_PATH "/home/xiachunwei/opencv2")
include_directories(${OPENCV_PATH}/include/opencv4/)
include_directories(/home/xiachunwei/anaconda3/lib/python3.8/site-packages/numpy/core/include)
include_directories(/home/xiachunwei/anaconda3/include/python3.8)

link_directories(${OPENCV_PATH}/build/lib)
link_directories(/home/xiachunwei/anaconda3/lib/)
link_directories(/home/xiachunwei/anaconda3/lib/python3.8/site-packages/numpy/core/lib)


add_executable(test_imread test_imread.cpp)
target_link_libraries(test_imread opencv_core opencv_imgcodecs python3.8)