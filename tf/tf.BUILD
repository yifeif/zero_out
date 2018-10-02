package(default_visibility = ["//visibility:public"])

cc_library(
    name = "tf_header_lib",
    srcs = glob(["include/*",]),
    includes = ["include"],
    visibility = ["//visibility:public"],
)

cc_library(
    name = "libtensorflow_framework",
    srcs = ["lib/libtensorflow_framework.so"],
    data = ["lib/libtensorflow_framework.so"],
    visibility = ["//visibility:public"],
)