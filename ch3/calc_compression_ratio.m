function compression_ratio=calc_compression_ratio(length_1,length_2,size_1,size_2)
%输入accode和dccode长度，以及原图像的长和宽，输出压缩比
raw_bytes=size_1*size_2;
compressed_bits=length_1+length_2;
compression_ratio=compressed_bits/(raw_bytes*8);