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
├── tensorflow_zero_out
│   ├── cc
│   │   ├── kernels  # op kernel implementation
│   │   │   └── zero_out_kernels.cc
│   │   └── ops  # op interface defination
│   │       └── zero_out_ops.cc
│   ├── python
│   │   ├── ops
│   │   │   ├── __init__.py
│   │   │   ├── zero_out_ops.py   # Load and extend the ops in python
│   │   │   └── zero_out_ops_test.py  # tests for ops
│   │   └── __init__.py
|   |
│   ├── BUILD  # BUILD file for all op targets
│   └── __init__.py  # top level __init__ file that import the custom op
│
├── tf  # Set up TensorFlow pip package as external dependency for bazel
│   ├── BUILD
│   ├── BUILD.tpl
│   └── tf_configure.bzl
|
├── BUILD  # top level Bazel BUILD file that contains pip package build target
├── build_pip_pkg.sh  # script to build pip package for Bazel and Makefile
├── configure.sh  # script to install TensorFlow and setup action_env for Bazel
├── LICENSE
├── Makefile  # Makefile for building shared library and pip package
├── MANIFEST.in
├── README.md
├── setup.py  # files for creating pip package
└── WORKSPACE  # Used by Bazel to specify tensorflow pip package as an external dependency

```

After clone the repo, replace the `tensorflow_zero_out` directory with the name of your op.


### Add Op Implementation
Following the instructions at [Adding a New Op](https://www.tensorflow.org/extend/adding_an_op), add defination of your ops' interface under `cc/ops/` and kernel implementation under `cc/kernels/`.


### Build and Test Op

#### Bazel
To build the custom op shared library with Bazel, follow the cc_binary example in `tensorflow_zero_out/BUILD`. Note the example `cc_binary` target depends on TensorFlow header files and 'libtensorflow_framework.so' from the pip package installed earlier:
```python
    deps = [
        "@local_config_tf//:libtensorflow_framework",
        "@local_config_tf//:tf_header_lib",
    ],
```

You will need to keep both dependencies. To build the shared library in bazel, run
```bash
bazel build tensorflow_zero_out:python/ops/_zero_out_ops.so
```

#### Makefile
To build the custom op shared library with make, follow the example in `Makefile` for `_zero_out_ops.so`.

#### Extend and Test the Op in Python
Once you have built the custom op shared library, you can follow the example in `tensorflow_zero_out/python/ops`, and instructions here(https://www.tensorflow.org/extend/adding_an_op#use_the_op_in_python) to create a module in Python for your op. Both guides use TensorFlow API `tf.load_op_library`, which loads the shared library and registers the ops with the TensorFlow framework.

You can also add Python tests like what we have done in `tensorflow_zero_out/python/ops/zero_out_ops_test.py` to check that your op is working as intended.


##### Run tests in Bazel
To add the python library and tests targets to Bazel, please follow the examples for `py_library` taget `tensorflow_zero_out:zero_out_ops_py` and `py_test` target `tensorflow_zero_out:zero_out_ops_py_test` in `tensorflow_zero_out/BUILD` file. To run the test with bazel, do the following

```bash
bazel test tensorflow_zero_out:zero_out_ops_py_test
```

##### Run tests in Bazel
To add the test target to make, please follow the example in `Makefile`. To run your python test, simply run
```bash
make test
```

### Build PIP Package


Rename tensorflow_zero_out direcotry with the name of your ops. Add your kernel implementation and op registration at <your op>/cc/kernels/*.cc and <your op>/cc/ops/*.cc.

For each op shared library you are creating, add them to <your op>/BUILD similar to target "python/ops/_zero_out_ops".
  
  TODO: finish once doc has been reviewed.


### Publish your pip package
Once your pip package has been tested, you can distribute your package by uploading your package to the Python Package Index. Please follow the [official instruction](https://packaging.python.org/tutorials/packaging-projects/#uploading-the-distribution-archives) from Pypi.


