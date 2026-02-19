```bash

```
clang -c tmp1.c -O0 -o tmp1.o
clang -c tmp2.c -O0 -o tmp2.o
```bash
rm -r ./tmp1/*
analyzeHeadless ./tmp1 tmp1 -import tmp1.o -noanalysis
rm -r ./tmp2/*
analyzeHeadless ./tmp2 tmp2 -import tmp2.o -noanalysis
```

```bash
touch tmp1.BinExport
touch tmp2.BinExport
```

```bash
analyzeHeadless ./tmp1/ tmp1 -process tmp1.o -preScript BinExport.java tmp1.BinExport "Prepend Namespace to Function Names" -noanalysis
analyzeHeadless ./tmp2/ tmp2 -process tmp2.o -preScript BinExport.java tmp2.BinExport "Prepend Namespace to Function Names" -noanalysis
```


```bash
~/Software/bindiff/build/out/bindiff --output_format log tmp1.BinExport tmp2.BinExport 
```

End-to-end example
```bash
clang -c tmp1.c -O0 -o tmp1.o
clang -c tmp2.c -O0 -o tmp2.o
rm -r ./tmp1/*
analyzeHeadless ./tmp1 tmp1 -import tmp1.o -noanalysis
rm -r ./tmp2/*
analyzeHeadless ./tmp2 tmp2 -import tmp2.o -noanalysis
touch tmp1.BinExport
touch tmp2.BinExport
analyzeHeadless ./tmp1/ tmp1 -process tmp1.o -preScript BinExport.java tmp1.BinExport "Prepend Namespace to Function Names" -noanalysis
analyzeHeadless ./tmp2/ tmp2 -process tmp2.o -preScript BinExport.java tmp2.BinExport "Prepend Namespace to Function Names" -noanalysis
~/Software/bindiff/build/out/bindiff --output_format log tmp1.BinExport tmp2.BinExport 
```

```decompile
${GHIDRA_HOME}/support/analyzeHeadless tmp1 tmp1 -import tmp1.o -overwrite -postscript ghidra_decompile_script.py s314

${GHIDRA_HOME}/support/analyzeHeadless tmp2 tmp2 -import tmp2.o -overwrite -postscript ghidra_decompile_script.py s314
```

cmake -S . -B build/out -G Ninja \
  -DCMAKE_BUILD_TYPE=Release \
  -DCMAKE_INSTALL_PREFIX=build/out \
  -DBINDIFF_BINEXPORT_DIR=/home/xiachunwei/Software/BinExport/ \
  "-DIdaSdk_ROOT_DIR=/home/xiachunwei/Software/ida-sdk"

cmake .. \
    -G Ninja \
    -DCMAKE_BUILD_TYPE=Release \
    "-DCMAKE_INSTALL_PREFIX=${PWD}" \
    -DBINEXPORT_ENABLE_IDAPRO=ON \
    "-DIdaSdk_ROOT_DIR=/home/xiachunwei/Software/ida-sdk/src" \
    -DBINEXPORT_ENABLE_BINARYNINJA=ON \

we remove -lbinexport_plugin_shared
  
 /usr/bin/c++ -fPIC -O3 -DNDEBUG -flto -fno-fat-lto-objects  -Wl,-gc-sections -shared  -o ida/bindiff8_ida64.so ida/CMakeFiles/bindiff8_ida64.so.dir/bindiff_icon.cc.o ida/CMakeFiles/bindiff8_ida64.so.dir/main_plugin.cc.o ida/CMakeFiles/bindiff8_ida64.so.dir/matched_functions_chooser.cc.o ida/CMakeFiles/bindiff8_ida64.so.dir/names.cc.o ida/CMakeFiles/bindiff8_ida64.so.dir/results.cc.o ida/CMakeFiles/bindiff8_ida64.so.dir/statistics_chooser.cc.o ida/CMakeFiles/bindiff8_ida64.so.dir/unmatched_functions_chooser.cc.o ida/CMakeFiles/bindiff8_ida64.so.dir/visual_diff.cc.o  /home/xiachunwei/Software/ida-sdk/src/lib/x64_linux_gcc_64/libida.so  -Wl,--version-script  /home/xiachunwei/Software/ida-sdk/src/plugins/exports.def  _deps/binexport-build/libbinexport_core.a    libbindiff_shared.a  _deps/absl-build/absl/time/libabsl_time.a  libsqlite.a  -ldl  libbindiff_config.a  _deps/binexport-build/libbinexport_shared.a  libbindiff_version.a  _deps/protobuf-build/libprotobuf.a  _deps/absl-build/absl/log/libabsl_log_initialize.a  _deps/absl-build/absl/status/libabsl_statusor.a  _deps/absl-build/absl/status/libabsl_status.a  _deps/absl-build/absl/log/libabsl_log_internal_check_op.a  _deps/absl-build/absl/debugging/libabsl_leak_check.a  _deps/absl-build/absl/log/libabsl_die_if_null.a  _deps/absl-build/absl/log/libabsl_log_internal_conditions.a  _deps/absl-build/absl/log/libabsl_log_internal_message.a  _deps/absl-build/absl/base/libabsl_strerror.a  _deps/absl-build/absl/log/libabsl_log_internal_nullguard.a  _deps/absl-build/absl/debugging/libabsl_examine_stack.a  _deps/absl-build/absl/log/libabsl_log_internal_format.a  _deps/absl-build/absl/log/libabsl_log_internal_structured_proto.a  _deps/absl-build/absl/log/libabsl_log_internal_proto.a  _deps/absl-build/absl/log/libabsl_log_internal_log_sink_set.a  _deps/absl-build/absl/log/libabsl_log_internal_globals.a  _deps/absl-build/absl/log/libabsl_log_sink.a  _deps/absl-build/absl/flags/libabsl_flags_internal.a  _deps/absl-build/absl/flags/libabsl_flags_marshalling.a  _deps/absl-build/absl/flags/libabsl_flags_reflection.a  _deps/absl-build/absl/container/libabsl_raw_hash_set.a  _deps/absl-build/absl/strings/libabsl_cord.a  _deps/absl-build/absl/strings/libabsl_cordz_info.a  _deps/absl-build/absl/strings/libabsl_cord_internal.a  _deps/absl-build/absl/strings/libabsl_cordz_functions.a  _deps/absl-build/absl/strings/libabsl_cordz_handle.a  _deps/absl-build/absl/crc/libabsl_crc_cord_state.a  _deps/absl-build/absl/crc/libabsl_crc32c.a  _deps/absl-build/absl/strings/libabsl_str_format_internal.a  _deps/absl-build/absl/crc/libabsl_crc_internal.a  _deps/absl-build/absl/crc/libabsl_crc_cpu_detect.a  _deps/absl-build/absl/container/libabsl_hashtablez_sampler.a  _deps/absl-build/absl/profiling/libabsl_exponential_biased.a  _deps/absl-build/absl/flags/libabsl_flags_config.a  _deps/absl-build/absl/flags/libabsl_flags_program_name.a  _deps/absl-build/absl/flags/libabsl_flags_private_handle_accessor.a  _deps/absl-build/absl/flags/libabsl_flags_commandlineflag.a  _deps/absl-build/absl/flags/libabsl_flags_commandlineflag_internal.a  _deps/absl-build/absl/log/libabsl_log_globals.a  _deps/absl-build/absl/hash/libabsl_hash.a  _deps/absl-build/absl/hash/libabsl_city.a  _deps/absl-build/absl/log/libabsl_vlog_config_internal.a  _deps/absl-build/absl/log/libabsl_log_internal_fnmatch.a  _deps/absl-build/absl/random/libabsl_random_distributions.a  _deps/absl-build/absl/random/libabsl_random_seed_sequences.a  _deps/absl-build/absl/random/libabsl_random_internal_entropy_pool.a  _deps/absl-build/absl/random/libabsl_random_internal_randen.a  _deps/absl-build/absl/random/libabsl_random_internal_randen_hwaes.a  _deps/absl-build/absl/random/libabsl_random_internal_randen_hwaes_impl.a  _deps/absl-build/absl/random/libabsl_random_internal_randen_slow.a  _deps/absl-build/absl/random/libabsl_random_internal_platform.a  _deps/absl-build/absl/random/libabsl_random_internal_seed_material.a  _deps/absl-build/absl/random/libabsl_random_seed_gen_exception.a  _deps/absl-build/absl/synchronization/libabsl_synchronization.a  _deps/absl-build/absl/debugging/libabsl_stacktrace.a  _deps/absl-build/absl/debugging/libabsl_symbolize.a  _deps/absl-build/absl/debugging/libabsl_debugging_internal.a  _deps/absl-build/absl/debugging/libabsl_demangle_internal.a  _deps/absl-build/absl/debugging/libabsl_demangle_rust.a  _deps/absl-build/absl/debugging/libabsl_decode_rust_punycode.a  _deps/absl-build/absl/debugging/libabsl_utf8_for_code_point.a  _deps/absl-build/absl/synchronization/libabsl_graphcycles_internal.a  _deps/absl-build/absl/synchronization/libabsl_kernel_timeout_internal.a  _deps/absl-build/absl/base/libabsl_malloc_internal.a  _deps/absl-build/absl/base/libabsl_tracing_internal.a  _deps/protobuf-build/third_party/utf8_range/libutf8_validity.a  _deps/absl-build/absl/time/libabsl_time.a  _deps/absl-build/absl/time/libabsl_civil_time.a  _deps/absl-build/absl/time/libabsl_time_zone.a  _deps/absl-build/absl/strings/libabsl_strings.a  _deps/absl-build/absl/numeric/libabsl_int128.a  _deps/absl-build/absl/strings/libabsl_strings_internal.a  _deps/absl-build/absl/strings/libabsl_string_view.a  _deps/absl-build/absl/base/libabsl_base.a  _deps/absl-build/absl/base/libabsl_spinlock_wait.a  -lpthread  -lrt  _deps/absl-build/absl/base/libabsl_throw_delegate.a  _deps/absl-build/absl/base/libabsl_raw_logging_internal.a  _deps/absl-build/absl/base/libabsl_log_severity.a && :
/usr/bin/ld: cannot find -lbinexport_plugin_shared