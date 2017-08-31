function magnitude_matrix=ac_huffman_decode(accodes,ACTAB,num_blocks)
%输出63*num_block的矩阵
%第一步，做字典
%ZRL
ACTAB(161,1:2)=0;
ACTAB(161,3)=11;
ACTAB(161,4:19)=get_padding([1,1,1,1,1,1,1,1,0,0,1],16);
%EOB
ACTAB(162,1:2)=0;
ACTAB(162,3)=4;
ACTAB(162,4:19)=get_padding([1,0,1,0],16);
huffman_dict=ACTAB(:,4:size(ACTAB,2));
MAX_HUFFMAN_LENGTH=16;%霍夫曼编码最大长度为16
code_length=length(accodes);
last_index=0;
current_index=1;
magnitude_matrix=zeros(63,num_blocks);
current_block=0;
while current_index<=code_length
	%每遍循环处理一个block
	array_index=1;
	current_block=current_block+1;
	while 1
		%先霍夫曼解码，再解码magnitude
	
		%[current_index,last_index]
		[member_flag,huffman_index]=ismember(get_padding(accodes(last_index+1:current_index),MAX_HUFFMAN_LENGTH),huffman_dict,'rows');
		if (member_flag==0) || ((current_index-last_index)~=ACTAB(huffman_index,3))%要判断编码长度是否与字典一致
			current_index=current_index+1;
			continue;
		end
		if (huffman_index==162) %EOB
			last_index=current_index;
			current_index=current_index+1;
			break;
		end
		if huffman_index==161 %ZRL
			magnitude_matrix(array_index:array_index+15,current_block)=0;
			array_index=array_index+16;
			last_index=current_index;
			current_index=current_index+1;
			continue;
		end
		%第二阶段，解码magnitude
		run=floor(huffman_index/10);
		magnitude_matrix(array_index:array_index+run-1,current_block)=0;
		array_index=array_index+run;
		category=mod(huffman_index,10);
		if category==0
			category=10;
		end
		last_index=current_index;
		current_index=current_index+category;%category代表magnitude编码长度
		magnitude=decode_magnitude(accodes(last_index+1:current_index));
		magnitude_matrix(array_index,current_block)=magnitude;
		array_index=array_index+1;
		last_index=current_index;%霍夫曼解码阶段，last_index指向霍夫曼头部前的一个元素的位置，在此设置
		current_index=current_index+1;
	end
	array_index
end