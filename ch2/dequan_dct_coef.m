function restored_image=dequan_dct_coef(quantized_coef,width,height,QTAB)
n_bw=width/8; %宽方向方块数
n_bh=height/8;%纵方向方块数
restored_image=zeros(height,width,'uint8'); %没有使用uint8,防止溢出以便观察解码输出和编码前是否一致

%(三)按块反量化及填入图片
for i=1:n_bh
	for j=1:n_bw
		dequantized_coef=dequantize(quantized_coef(:,(i-1)*n_bw+j),QTAB);%反量化
		restored_image((i-1)*8+1:i*8,(j-1)*8+1:j*8)=idct2(dequantized_coef);%iDCT
	end
end

function dequantized_coef=dequantize(block_quantized_array,QTAB)
%输入块量化系数向量，输出系数矩阵
coord=get_zigzag_coord();%获得zigzag index
dequantized_coef=zeros(8,8);
for ind =1:64%zigzag_index
	dequantized_coef(coord(ind,1),coord(ind,2))=QTAB(coord(ind,1),coord(ind,2))*block_quantized_array(ind);
end