function encoded_image=spatial_embed(message,img)
%空域隐藏
%输入原图像和待嵌入文本(string)，输出嵌入后的图像
message=double(char(message));
bit_array=char2bit(message);
max_bit_length=size(img,1)*size(img,2)*size(img,3);
assert(max_bit_length>=8*length(message));%隐藏的信息应该不大于图像能隐藏的最大长度
encoded_image=img;
for curr_index=1:8*length(message)%代表当前embed bit_array中第几个字符
	[curr_height,curr_width,curr_channel]=get_curr_index(curr_index,size(img,1),size(img,2),size(img,3));
	encoded_image(curr_height,curr_width,curr_channel)=lsreplace(encoded_image(curr_height,curr_width,curr_channel),bit_array(curr_index));
end
