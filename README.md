# TensorFlow Custom Ops
This is a template/example of building custom ops for TensorFlow.

## Try Building Example zero_out Op
If you would like to try out the process to build a pip package for custon op, you can use the source code from this repo following the instructions below.

### Use Docker
Pull the provided Docker container from Docker hub.

```bash
  docker pull yifeif/tensorflow:custom_op
  docker run -it yifeif/tensorflow:custom_op /bin/bash
```

Inside Docker container for image tensorflow/tensorflow:custom_op, clone this repository. 
```bash
git clone -b test https://github.com/yifeif/zero_out.git
cd zero_out
```

### Build PIP Package

With bazel:
```bash
  ./configure.sh
  bazel build build_pip_pkg
  bazel-bin/build_pip_pkg /tmp/zero_out_pip
```

With Makefile:
```bash
  make pip_pkg
```

### Install and Test PIP Package
First install the pip package we just built with
```bash
pip2 install /tmp/zero_out_pip/*.whl
```
Then test out the pip package
```bash
cd ..
python -c "import tensorflow as tf;import tensorflow_zero_out as zero_out_module;print(zero_out_module.zero_out([[1,2], [3,4]]).eval(session=tf.Session()))"
```

## Create and distribute custom ops
Now you are ready to write and distribute your own ops. The example in this repo has done the boilingplate work for setting up build systems and package files needed for creating pip package. We recommend using this repo as a template.


### Add Op Implementation

### Build and Test Op

#### Bazel

#### Makefile

### Build PIP Package


Rename tensorflow_zero_out direcotry with the name of your ops. Add your kernel implementation and op registration at <your op>/cc/kernels/*.cc and <your op>/cc/ops/*.cc.

For each op shared library you are creating, add them to <your op>/BUILD similar to target "python/ops/_zero_out_ops".
  
  TODO: finish once doc has been reviewed.


### Publish your pip package
Once your pip package has been tested, you can distribute your package by uploading your package to the Python Package Index. Please follow the [official instruction](https://packaging.python.org/tutorials/packaging-projects/#uploading-the-distribution-archives) from Pypi.


