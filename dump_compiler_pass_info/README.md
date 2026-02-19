

## Here is an example of how to dump the compiler pass information:


I will use lammps as an example to dump the compiler pass information.

Firstly, we need to install `bear` to trace the compilation cmd:
`https://github.com/rizsotto/Bear`
After installation, we can use `bear` to trace the compilation cmd..

Then build lammps with `-O3` optimization:
```bash
cd lammps

cmake -S cmake -B build -DCMAKE_CXX_FLAGS="-O3 -g" -DCMAKE_C_FLAGS="-O3 -g" -DCMAKE_CXX_COMPILER=clang++ -DCMAKE_C_COMPILER=clang

bear cmake --build build
```

Then we can get the `compile_commands.json` file. 

Here is one example from `compile_commands.json`:
```json
 {
        "arguments": [
            "clang++",
            "-c",
            "-DLAMMPS_GZIP",
            "-DLAMMPS_MEMALIGN=64",
            "-DLAMMPS_SMALLBIG",
            "-DMPICH_SKIP_MPICXX",
            "-DOMPI_SKIP_MPICXX",
            "-D_MPICC_H",
            "-I/home/xiachunwei/Software/lammps/src",
            "-I/home/xiachunwei/Software/lammps/third_party",
            "-I/home/xiachunwei/Software/lammps/build/styles",
            "-isystem",
            "/home/xiachunwei/anaconda3/include",
            "-O3",
            "-Rpass=loop-unroll",
            "-O2",
            "-g",
            "-DNDEBUG",
            "-fPIC",
            "-std=c++17",
            "-o",
            "CMakeFiles/lammps.dir/home/xiachunwei/Software/lammps/src/npair_skip_size_off2on_oneside.cpp.o",
            "../src/npair_skip_size_off2on_oneside.cpp"
        ],
        "directory": "/home/xiachunwei/Software/lammps/build",
        "file": "../src/npair_skip_size_off2on_oneside.cpp"
    }
```

Then we can add `-Rpass=.*` to the compilation command to dump the compiler pass information.
Convert the json to a cmd like this:
```bash
clang++ -c -DLAMMPS_GZIP -DLAMMPS_MEMALIGN=64 -DLAMMPS_SMALLBIG -DMPICH_SKIP_MPICXX -DOMPI_SKIP_MPICXX -D_MPICC_H -I/home/xiachunwei/Software/lammps/src -I/home/xiachunwei/Software/lammps/third_party -I/home/xiachunwei/Software/lammps/build/styles -isystem /home/xiachunwei/anaconda3/include -O3 -Rpass=.* -O2 -g -DNDEBUG -fPIC -std=c++17 -o CMakeFiles/lammps.dir/home/xiachunwei/Software/lammps/src/npair_skip_size_off2on_oneside.cpp.o ../src/npair_skip_size_off2on_oneside.cpp
```

We can also only dump loop related pass by using `-Rpass=loop*`.
```bash
clang++ -c -DLAMMPS_GZIP -DLAMMPS_MEMALIGN=64 -DLAMMPS_SMALLBIG -DMPICH_SKIP_MPICXX -DOMPI_SKIP_MPICXX -D_MPICC_H -I/home/xiachunwei/Software/lammps/src -I/home/xiachunwei/Software/lammps/third_party -I/home/xiachunwei/Software/lammps/build/styles -isystem /home/xiachunwei/anaconda3/include -O3 -Rpass=loop* -O2 -g -DNDEBUG -fPIC -std=c++17 -o CMakeFiles/lammps.dir/home/xiachunwei/Software/lammps/src/npair_skip_size_off2on_oneside.cpp.o ../src/npair_skip_size_off2on_oneside.cpp
```

Then we can get all the compiler pass information from the compiler.
Here is the example output:

```bash
../src/npair_skip_size_off2on_oneside.cpp:79:44: remark: Transformed loop-strided store in _ZN9LAMMPS_NS30NPairSkipSizeOff2onOnesideTempILi0EE5buildEPNS_9NeighListE function into a call to llvm.memset.p0.i64() intrinsic [-Rpass=loop-idiom]
   79 |   for (i = 0; i < nlocal; i++) numneigh[i] = 0;
      |                                            ^
../src/npair_skip_size_off2on_oneside.cpp:79:3: remark: Loop deleted because it is invariant [-Rpass=loop-delete]
   79 |   for (i = 0; i < nlocal; i++) numneigh[i] = 0;
      |   ^
../src/npair_skip_size_off2on_oneside.cpp:138:44: remark: Transformed loop-strided store in _ZN9LAMMPS_NS30NPairSkipSizeOff2onOnesideTempILi0EE5buildEPNS_9NeighListE function into a call to llvm.memset.p0.i64() intrinsic [-Rpass=loop-idiom]
  138 |   for (i = 0; i < nlocal; i++) numneigh[i] = 0;
      |                                            ^
../src/npair_skip_size_off2on_oneside.cpp:138:3: remark: Loop deleted because it is invariant [-Rpass=loop-delete]
  138 |   for (i = 0; i < nlocal; i++) numneigh[i] = 0;
      |   ^
../src/npair_skip_size_off2on_oneside.cpp:79:44: remark: Transformed loop-strided store in _ZN9LAMMPS_NS30NPairSkipSizeOff2onOnesideTempILi1EE5buildEPNS_9NeighListE function into a call to llvm.memset.p0.i64() intrinsic [-Rpass=loop-idiom]
   79 |   for (i = 0; i < nlocal; i++) numneigh[i] = 0;
      |                                            ^
../src/npair_skip_size_off2on_oneside.cpp:79:3: remark: Loop deleted because it is invariant [-Rpass=loop-delete]
   79 |   for (i = 0; i < nlocal; i++) numneigh[i] = 0;
      |   ^
../src/npair_skip_size_off2on_oneside.cpp:138:44: remark: Transformed loop-strided store in _ZN9LAMMPS_NS30NPairSkipSizeOff2onOnesideTempILi1EE5buildEPNS_9NeighListE function into a call to llvm.memset.p0.i64() intrinsic [-Rpass=loop-idiom]
  138 |   for (i = 0; i < nlocal; i++) numneigh[i] = 0;
      |                                            ^
../src/npair_skip_size_off2on_oneside.cpp:138:3: remark: Loop deleted because it is invariant [-Rpass=loop-delete]
  138 |   for (i = 0; i < nlocal; i++) numneigh[i] = 0;
      |   ^
```

Then we can pass this information to LLM to assist the optimization.