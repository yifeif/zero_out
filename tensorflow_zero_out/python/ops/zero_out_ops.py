from tensorflow.contrib.util import loader
from tensorflow.python.platform import resource_loader

_zero_out_ops = loader.load_op_library(
    resource_loader.get_path_to_datafile('_zero_out_ops.so'))
zero_out = _zero_out_ops.zero_out
