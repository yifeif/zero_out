#!/usr/bin/env bash
# Copyright 2017 The TensorFlow Lattice Authors.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
# ==============================================================================
set -e

PLATFORM="$(uname -s | tr 'A-Z' 'a-z')"

function main() {

  TMPDIR=$(mktemp -d -t tmp.XXXXXXXXXX)

  echo $(date) : "=== Using tmpdir: ${TMPDIR}"

  echo "=== Copy files to ${TMPDIR}"

  cp setup.py "${TMPDIR}"
  cp MANIFEST.in "${TMPDIR}"
  cp -r tensorflow_zero_out ${TMPDIR}/tensorflow_zero_out

  pushd "${TMPDIR}"
  virtualenv .env
  source .env/bin/activate
  pip install --upgrade pip
  pip install tensorflow

  echo
  echo $(date) : "=== Building custom op shared library against installed tensorflow..."
  TF_CFLAGS=( $(python -c 'import tensorflow as tf; print(" ".join(tf.sysconfig.get_compile_flags()))') )
  TF_LFLAGS=( $(python -c 'import tensorflow as tf; print(" ".join(tf.sysconfig.get_link_flags()))') )
  g++ -std=c++11 -shared tensorflow_zero_out/cc/zero_out_op.cc tensorflow_zero_out/cc/zero_out_kernel.cc  -o tensorflow_zero_out/cc/zero_out.so -fPIC ${TF_CFLAGS[@]} ${TF_LFLAGS[@]} -O2

  echo
  echo $(date) : "=== Building wheel"
  python setup.py bdist_wheel > /dev/null

  echo
  echo "== pip package at ${TMPDIR}/dist"
  echo
  popd
}

main "$@"
