licenses(["notice"])  # Apache 2.0

package(default_visibility = ["//visibility:public"])


py_library(
    name = "zero_out_py",
    srcs = ([
        "python/zero_out.py",
        "__init__.py",
        "python/__init__.py",
    ]),
    data = ["//tensorflow_zero_out/cc:zero_out.so"],
    srcs_version = "PY2AND3",
)

py_test(
    name = "zero_out_test",
    srcs = ([
        "python/zero_out_test.py",
    ]),
    data = ["//tensorflow_zero_out/cc:zero_out.so"],
    srcs_version = "PY2AND3",
    deps = [':zero_out_py']
)
