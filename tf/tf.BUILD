filegroup(
    name = "tf_headers",
    srcs = glob(
        [
            "include/**/*.h",
        ],
    ),
    visibility = ["//visibility:public"],
)

cc_library(
    name = "libtensorflow_framework",
    srcs = [
        "lib/libtensorflow_framework.so",
    ],
    visibility = ["//visibility:public"],
)

cc_library(
    name = "tf_header_lib",
    hdrs = glob([
        "include/**/*.h",
    ]),
    copts = [
        "-Iexternal/local_config_tf/include"
    ],
    linkopts = ["-pthread"],
    visibility = ["//visibility:public"],
)