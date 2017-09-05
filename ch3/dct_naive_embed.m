function [accode_tot,dc_code,quantized_coef,width,height]=dct_naive_embed(message,img,pos_vect,QTAB,ACTAB,DCTAB)
%系数矩阵embed前两种方法,pos_vect表示在8*8的系数矩阵块中进行embed的index
img_dct=dct2(img);
message=double(char(message));
bit_array=char2bit(message);
curr_index=1;
[quantized_coef,coef,width,height]=quan_dct_coef(img,QTAB);
for i=1:size(quantized_coef,2)
	if curr_index>length(bit_array)
			break;
	end
	for j=1:size(quantized_coef,1)
		if curr_index>length(bit_array)
			break;
		end
		if ismember(j,pos_vect)%如果当前系数是选中embed的位置
			[j,i];
			quantized_coef(j,i)=lsreplace(quantized_coef(j,i),bit_array(curr_index));
			curr_index=curr_index+1;
		end
	end
end
assert(curr_index>length(bit_array));

[accode_tot,dc_code,quantized_coef,width,height]=huffman_encode(quantized_coef,width,height,QTAB,ACTAB,DCTAB);
