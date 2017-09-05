function [accode_tot,dc_code,quantized_coef,width,height]=dct_embed(message,img,QTAB,ACTAB,DCTAB)
%系数矩阵embed第三种方法
img_dct=dct2(img);
message=double(char(message));
bit_array=char2bit(message);
curr_index=1;
[quantized_coef,coef,width,height]=quan_dct_coef(img,QTAB);
for i=1:size(quantized_coef,2)
	if curr_index>length(bit_array)
			break;
	end
	non_zero_j=get_last_non_zero_index(quantized_coef(:,i));

	if non_zero_j==64%替换
		quantized_coef(64,i)=lsreplace(quantized_coef(64,i),bit_array(curr_index));
	else
		quantized_coef(non_zero_j+1,i)=2*(bit_array(curr_index)-0.5);
	end
	curr_index=curr_index+1;

	
end
assert(curr_index>length(bit_array));

[accode_tot,dc_code,quantized_coef,width,height]=huffman_encode(quantized_coef,width,height,QTAB,ACTAB,DCTAB);
