#!/bin/bash
# vim:set ts=8 sw=4 sts=4 et:

# Copyright (c) 2011 Serban Giuroiu
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
# THE SOFTWARE.

# ------------------------------------------------------------------------------

set -e

python generator.py rand.in 32768 16

input='rand.in'

mkdir -p profiles

make seq cuda

echo "--------------------------------------------------------------------------------"
uptime
echo "--------------------------------------------------------------------------------"

for k in 2 4 8 16 32 64 128 256 512 1024; do
    seqTime=$(./seq_main -o -n $k -i ${input} | grep 'Computation' | awk '{print $4}')

    cudaTime=$(./cuda_main -o -n $k -i ${input} | grep 'Computation' | awk '{print $4}')

    speedup=$(echo "scale=1; ${seqTime} / ${cudaTime}" | bc)
    echo "k = $(printf "%4d" $k)  seqTime = ${seqTime}s cudaTime = ${cudaTime}s  speedup = ${speedup}x"
done
