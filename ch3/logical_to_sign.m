function bit_array=logical_to_sign(bit_array)
%输入0，1矩阵，输出正负1，用于变换域第三种方法
bit_array=(bit_array-0.5)*2;