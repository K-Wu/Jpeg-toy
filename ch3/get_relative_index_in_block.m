function index=get_relative_index_in_block(i,j)
%输入像素坐标，输出在所在块的index
i=mod(i,8);
j=mod(j,8);
index=i*8+j+1;