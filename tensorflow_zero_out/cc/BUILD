package(default_visibility = ["//visibility:public"])

licenses(["notice"])  # Apache 2.0

cc_binary(
    name = 'zero_out.so',
    srcs = [
        "zero_out_kernel.cc",
        "zero_out_op.cc",
    ],
    linkshared = 1,
    deps = [
        "@local_config_tf//:libtensorflow_framework",
        "@local_config_tf//:tf_header_lib",
    ],
    copts = ["-pthread", "-std=c++11", "-D_GLIBCXX_USE_CXX11_ABI=0"]
)
