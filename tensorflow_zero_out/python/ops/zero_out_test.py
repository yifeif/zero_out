import tensorflow as tf
from tensorflow_zero_out.python.ops.zero_out import zero_out
with tf.Session(''):
  result = zero_out([[1, 2], [3, 4]]).eval()
