function [char_array,restored_image]=dct_decode(accode,dccode,width,height,QTAB,ACTAB,DCTAB,L)
%L为信息char长度
quantized_coef=huffman_decode(accode,dccode,width,height,QTAB,ACTAB,DCTAB);
bit_array=zeros(1,8*L);
curr_bit_index=1;
restored_image=dequan_dct_coef(quantized_coef,width,height,QTAB);
for i=1:size(quantized_coef,2)
	if curr_bit_index>8*L
		break;
	end
	non_zero_j=get_last_non_zero_index(quantized_coef(:,i));
	if non_zero_j==64
		bit_array(curr_bit_index)=safebitand(quantized_coef(non_zero_j,i),1);
	else
		bit_array(curr_bit_index)=(quantized_coef(non_zero_j,i)+1)/2;
	end
	curr_bit_index=curr_bit_index+1;
end
assert(curr_bit_index>8*L);
char_array=bit2char(bit_array);	
restored_image=jpeg_decode(accode,dccode,width,height,QTAB,ACTAB,DCTAB);
