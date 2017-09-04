function bit_array=char2bit(char_array)
%输入字符矩阵，输出bit矩阵，每个字符用8位ascii码 encode
bit_array=zeros(1,8*length(char_array));
char_array=double(char_array);%字符转ascii码
for i=1:length(char_array)
	curr_bits=encode_magnitude(char_array(i));%当前字符的bit表示，前面需要补零
	bit_array((i*8-length(curr_bits)+1):i*8)=curr_bits;
end

