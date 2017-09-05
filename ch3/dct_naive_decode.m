function [char_array,restored_image]=dct_naive_decode(accode,dccode,width,height,QTAB,ACTAB,DCTAB,pos_vect,L)
%L为信息char长度
quantized_coef=huffman_decode(accode,dccode,width,height,QTAB,ACTAB,DCTAB);
bit_array=zeros(1,8*L);
curr_bit_index=1;
restored_image=dequan_dct_coef(quantized_coef,width,height,QTAB);
for i=1:size(quantized_coef,2)
	if curr_bit_index>8*L
		break;
	end
	for j=1:size(quantized_coef,1)
		if curr_bit_index>8*L
			break;
		end
		if ismember(j,pos_vect)
			[j,i];
			bit_array(curr_bit_index)=safebitand(quantized_coef(j,i),1);
			curr_bit_index=curr_bit_index+1;
		end
	end
end
assert(curr_bit_index>8*L);
char_array=bit2char(bit_array);	
restored_image=jpeg_decode(accode,dccode,width,height,QTAB,ACTAB,DCTAB);
