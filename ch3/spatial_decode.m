function char_array=spatial_decode(img,L)
%从img中读取隐藏的信息，信息的char长度为L
assert(size(img,1)*size(img,2)*size(img,3)>=8*L);%L不能大于图像能够隐藏的最大长度
bit_array=zeros(1,8*L);
for i=1:8*L
	[curr_height,curr_width,curr_channel]=get_curr_index(i,size(img,1),size(img,2),size(img,3));%对第i个像素进行操作，先找到img中对应的index
	bit_array(i)=bitand(img(curr_height,curr_width,curr_channel),1);%获取最后一位
	
end
char_array=bit2char(bit_array);	