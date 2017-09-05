function restored_image=jpeg_decode(accode,dccode,width,height,QTAB,ACTAB,DCTAB)
assert(1==0);
%OBSOLETE SHOULD NOT USE. REFACTORED
%重构前的代码备份，已被新的jpeg_decode.m替代
n_bw=width/8; %宽方向方块数
n_bh=height/8;%纵方向方块数
restored_image=zeros(height,width,'uint8'); %没有使用uint8,防止溢出以便观察解码输出和编码前是否一致
quantized_coef=zeros(64,n_bw*n_bh);%量化后系数
%(一)处理DC分量
%1.1 DC霍夫曼解码
dc_magnitude_array=dc_huffman_decode(dccode,DCTAB);
%1.2 DC反差分
for i=2:length(dc_magnitude_array)
	dc_magnitude_array(i)=dc_magnitude_array(i)+dc_magnitude_array(i-1);
end
%(二)处理AC分量
%2.1 AC霍夫曼解码
ac_magnitude_matrix=ac_huffman_decode(accode,ACTAB,n_bw*n_bh);

%DC、AC分量拼接成量化后系数
quantized_coef(1,:)=dc_magnitude_array;
quantized_coef(2:64,:)=ac_magnitude_matrix;

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