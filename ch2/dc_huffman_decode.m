function magnitude_array=dc_huffman_decode(dccode,DCTAB)
%第一步，做字典
huffman_dict=DCTAB(:,2:size(DCTAB,2));
MAX_HUFFMAN_LENGTH=9;%霍夫曼编码最大长度为9
code_length=length(dccode);
last_index=0;
current_index=1;
magnitude_array=zeros(1,0);
array_index=1;
while current_index<=code_length
	%先霍夫曼解码，再解码magnitude
	%[current_index,last_index]
	[member_flag,huffman_index]=ismember(get_padding(dccode(last_index+1:current_index),MAX_HUFFMAN_LENGTH),huffman_dict,'rows');
	if (member_flag==0) || ((current_index-last_index)~=DCTAB(huffman_index,1))%要判断编码长度是否与字典一致
		current_index=current_index+1;
		continue;
	end
	%第二阶段，解码magnitude
	last_index=current_index;
	current_index=current_index+huffman_index-1;%category值为index-1，category代表magnitude编码长度
	magnitude=decode_magnitude(dccode(last_index+1:current_index));
	magnitude_array(array_index)=magnitude;
	array_index=array_index+1;
	last_index=current_index;%霍夫曼解码阶段，last_index指向霍夫曼头部前的一个元素的位置，在此设置
	current_index=current_index+1;
end




