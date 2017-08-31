function jpeg_decode(accode,dccode,width,height,QTAB,ACTAB,DCTAB)
n_bw=width/8; %宽方向方块数
n_bh=height/8;%纵方向方块数
restore_image=zeros(height,width)%,'uint8') %没有使用uint8,防止溢出以便观察解码输出和编码前是否一致
%处理DC分量
dc_magnitude_array=dc_huffman_decode(dccode,DCTAB);
%DC分量反差分
for i=2:length(dc_magnitude_array)
	dc_magnitude_array(i)=dc_magnitude_array(i)+dc_magnitude_array(i-1);
%DC分量反量化
	dc_magnitude_array=QTAB(1,1)*dc_magnitude_array;%量化步长为16

%DC分量填入图片
for i=1:n_bh
	for j=i:n_bw





function