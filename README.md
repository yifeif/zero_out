# TensorFlow Custom Ops
This is a template/example of building custom ops for TensorFlow.

## Try building example zero_out op

### Use Docker

Inside Docker container for image tensorflow/tensorflow:custom_op, clone this repository. 

### Build pip package

With bazel:
```bash
  ./configure.sh
  bazel build new_pip_pkg
  bazel-bin/new_pip_pkg /tmp/zero_out_pip
```

With Makefile:
```bash
  make pip_pkg
```

### Test pip package
```bash
python -c "import tensorflow, tensorflow_zero_out"
```

## Create and distribute custom ops
Clone the repository

Rename tensorflow_zero_out direcotry with the name of your ops. Add your kernel implementation and op registration at <your op>/cc/kernels/*.cc and <your op>/cc/ops/*.cc.

For each op shared library you are creating, add them to <your op>/BUILD similar to target "python/ops/_zero_out_ops".
  
  TODO: finish once doc has been reviewed.





