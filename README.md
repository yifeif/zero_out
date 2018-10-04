There are two ways to create the pip package:

With command line:
  ./pip_pkg.sh

With bazel:
  ./configure.sh
  bazel build new_pip_pkg
  bazel-bin/new_pip_pkg /tmp/zero_out_pip
