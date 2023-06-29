#include <iostream>

#include "opencv2/imgcodecs.hpp"
#include <Python.h>
#include "numpy/arrayobject.h" // Include any other Numpy headers, UFuncs for example.

int main (int argc, char* argv[]){
    if(argc > 1){
        auto file_path = argv[1];
        auto img = cv::imread(file_path);
        auto img_size = img.size();
        // Print image info
        printf("%s, height: %d, width: %d, step: %d %d\n",file_path, img_size.height, img_size.width, img.step[0], img.step[1]);
        // Print pixel value, note channel is flattend
        printf("%d %d %d\n", img.at<u_char>(0, 0), img.at<u_char>(0, 1), img.at<u_char>(0, 2)); // The pixel's GBR value at (0, 0)
        printf("%d %d %d\n", img.at<u_char>(0, 3), img.at<u_char>(0, 4), img.at<u_char>(0, 5)); // The pixel's GBR value at (0, 1)
        printf("%d %d %d\n", img.at<u_char>(3, 3), img.at<u_char>(3, 4), img.at<u_char>(3, 5)); // The pixel's GBR value at (3, 1)
        auto userdata = (u_char*)(img.u->data);
        printf("%d %d %d\n", userdata[0], userdata[1], userdata[2]);
        printf("%d %d %d\n", userdata[3], userdata[4], userdata[5]);
        printf("%d %d %d\n", userdata[3*img.step[0]+3], userdata[3*img.step[0]+4], userdata[3*img.step[0]+5]);
        // Initialise the Python interpreter
        wchar_t *program = Py_DecodeLocale(argv[0], NULL);
        if (program == NULL) {
            fprintf(stderr, "Fatal error: cannot decode argv[0]\n");
            exit(1);
        }
        // Test integration with numpy
        Py_Initialize();
        // Initialise Numpy
        import_array();
        if (PyErr_Occurred()) {
            std::cout << "Failed to import numpy Python module(s)." << std::endl;
            return -1;
        }
        // assert(PyArray_API);
    }
    return 0;
}