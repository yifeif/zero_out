from tensorflow.python.framework import load_library
from tensorflow.python.framework import ops
from tensorflow.python.platform import resource_loader

_zero_out_ops = load_library.load_op_library(
    resource_loader.get_path_to_datafile('../cc/zero_out.so'))
zero_out = _zero_out_ops.zero_out
