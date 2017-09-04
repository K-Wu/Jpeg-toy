function dct_naive_embed(message,img,pos_vect,QTAB,ACTAB,DCTAB)
%系数矩阵embed方法,pos_vect表示在8*8的系数矩阵块中进行embed的index
img_dct=dct2(img);
message=double(char(message));
bit_array=char2bit(message);
bit_index=1;
for i=1:size(img_dct,1)
	for j=1:size(img_dct,2)
		if bit_index>length(bit_array)
			break
		end
		index=get_relative_index_in_block(i,j);
		if ismember(index,pos_vect)%如果当前像素点是选中embed的位置
			img_dct(i,j)=lsreplace(img_dct(i,j),bit_array(curr_index));
		end
	end
end


[accode,dccode,quantized_coef,width,height]=jpeg_encode(idct2(img_dct),QTAB,ACTAB,DCTAB);
encoded_image=jpeg_decode(accode,dccode,width,height,QTAB,ACTAB,DCTAB);