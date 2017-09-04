function char_array=bit2char(bit_array)
%输入bit矩阵，输出字符矩阵，256位一个字符
char_array=zeros(1,length(bit_array)/8);
for curr_index=1:length(bit_array)/8
	
	curr_char=decode_magnitude_non_negative(bit_array((curr_index-1)*8+1:curr_index*8));%本8位代表的ascii码
	char_array(curr_index)=curr_char;
end
char_array=char(char_array);%ascii码转字符