package(default_visibility = ["//visibility:public"])

licenses(["notice"])  # Apache 2.0

cc_binary(
    name = 'zero_out.so',
    srcs = [
        "zero_out_kernel.cc",
        "zero_out_op.cc",
    ],
    linkshared = 1,
    # conplains when using @local_config_tf/lib:libtensorflow_framework.so
    data = [
        "@local_config_tf//:libtensorflow_framework",
        "@local_config_tf//:tf_header_lib",
    ],
    deps = [
        "@local_config_tf//:tf_header_lib",
    ],
    copts = ["-Iexternal/local_config_tf/include", "-O2"]
)