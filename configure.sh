#!/bin/bash

function write_to_bazelrc() {
  echo "$1" >> .bazelrc
}

function write_action_env_to_bazelrc() {
  write_to_bazelrc "build --action_env $1=\"$2\""
}

rm .bazelrc
if python -c "import tensorflow" &> /dev/null; then
    echo 'using installed tensorflow'
else
    pip2 install tensorflow
fi

TF_CFLAGS=( $(python -c 'import tensorflow as tf; print(" ".join(tf.sysconfig.get_compile_flags()))') )
TF_LFLAGS=( $(python -c 'import tensorflow as tf; print(" ".join(tf.sysconfig.get_link_flags()))') )

write_action_env_to_bazelrc "TF_HEADER_DIR" ${TF_CFLAGS:2}
write_action_env_to_bazelrc "TF_SHARED_LIBRARY_DIR" ${TF_LFLAGS:2}
