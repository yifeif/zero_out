_TF_HEADER_DIR = "TF_HEADER_DIR"
_TF_SHARED_LIBRARY_DIR = "TF_SHARED_LIBRARY_DIR"


def _tf_pip_impl(repository_ctx):
    """Implementation of the cuda_autoconf repository rule."""
    tf_header_dir = repository_ctx.os.environ[_TF_HEADER_DIR]
    repository_ctx.symlink(tf_header_dir, "include")
    
    tf_shared_library_dir = repository_ctx.os.environ[_TF_SHARED_LIBRARY_DIR]
    tf_shared_library_path = "%s/libtensorflow_framework.so" % tf_shared_library_dir
    repository_ctx.symlink(tf_shared_library_path, "lib/libtensorflow_framework.so")

    # Also setup BUILD file.
    repository_ctx.symlink(repository_ctx.attr.build_file, "BUILD") 

tf_configure = repository_rule(
    implementation = _tf_pip_impl,
    environ = [
        _TF_HEADER_DIR,
        _TF_SHARED_LIBRARY_DIR,
    ],
    attrs = {
        "build_file": attr.label(),
    },    
)