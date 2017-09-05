function quantized_coef=huffman_decode(accode,dccode,width,height,QTAB,ACTAB,DCTAB)
n_bw=width/8; %宽方向方块数
n_bh=height/8;%纵方向方块数
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






