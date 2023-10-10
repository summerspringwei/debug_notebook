#!/bin/bash
set -xe
# This script is used to compile the host program to x86_64 assembly
OUTDIR=output
# Compile with O0
clang ./addf.c -S -target armv7a -O0 -o ${OUTDIR}/addf_armv7a_O0.s

# Compile with O3
clang ./addf.c -S -target armv7a -O3 -o ${OUTDIR}/addf_armv7a_O3.s
