#!/bin/bash
set -xe
# This script is used to compile the host program to x86_64 assembly

# Compile with O0
clang ./addf.c -S -mllvm --x86-asm-syntax=intel -O0 -o ${OUTDIR}/addf_x86_64_O0.s

# Compile with O3
clang ./addf.c -S -mllvm --x86-asm-syntax=intel -O3 -o ${OUTDIR}/addf_x86_64_O3.s
