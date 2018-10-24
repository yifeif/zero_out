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


### Template Overview
First let's go through a quick overview of the folder structure of the template repo.
```
zero_out
|   # files for creating pip package
│   setup.py
|   MANIFEST.in
|   # script to build pip package for Bazel and Makefile
│   build_pip_pkg.sh\
|   # script to install TensorFlow and setup action_env for Bazel
|   configure.sh
│   # top level Bazel BUILD file that contains pip package build target
|   BUILD
|   # Used by Bazel to specify tensorflow pip package as an external dependency
|   WORKSPACE
|   # Makefile for building shared library and pip package
|   Makefile
|
└───tensorflow_zero_out
│   │   # BUILD file for all op targets
│   │   BUILD
│   │   # top level __init__ file that import the custom op
|   |
│   └───cc
|   |   └───kernels
│   |   |   │   # op kernel implementation
│   |   |   │   zero_out_kernels.cc
|   |   └───ops
│   |       │   # op interface defination
│   |       │   zero_out_ops.cc
│   └───python
|       └───ops
│           │   # Load and extend the ops in python
│           │   zero_out_ops.py
│           │   # tests for ops
│           │   zero_out_ops_test.py
|
└───tf
    |   # .bzl files for setting up genrule targets for tensorflow pip package
    |   tf_configure.bzl
    |   # BUILD file template for TensorFlow pip package as external dependency
    |   BUILD.tpl
    |   # dummy BUILD file
    │   BUILD
```

After clone the repo, replace the `tensorflow_zero_out` directory with the name of your op.


### Add Op Implementation
Following the instructions at [Adding a New Op](https://www.tensorflow.org/extend/adding_an_op), add defination of your ops' interface under `cc/ops/` and kernel implementation under `cc/kernels/`.


### Build and Test Op

#### Bazel
To build the custom op shared library with Bazel, update the cc_binary example in `BUILD` file with your op. The example `cc_binary` target depends on TensorFlow header files and 'libtensorflow_framework.so' from the pip package installed earlier:
```python
    deps = [
        "@local_config_tf//:libtensorflow_framework",
        "@local_config_tf//:tf_header_lib",
    ],
```

You will need to keep both dependencies.

#### Makefile

### Build PIP Package


Rename tensorflow_zero_out direcotry with the name of your ops. Add your kernel implementation and op registration at <your op>/cc/kernels/*.cc and <your op>/cc/ops/*.cc.

For each op shared library you are creating, add them to <your op>/BUILD similar to target "python/ops/_zero_out_ops".
  
  TODO: finish once doc has been reviewed.


### Publish your pip package
Once your pip package has been tested, you can distribute your package by uploading your package to the Python Package Index. Please follow the [official instruction](https://packaging.python.org/tutorials/packaging-projects/#uploading-the-distribution-archives) from Pypi.


