function [quantized_coef,coef,width,height]=quan_dct_coef(hall_gray,QTAB)
[height,width]=size(hall_gray);
nb_w=width/8;%横方向方块数
nb_h=height/8;%纵方向方块数
coef=zeros(64,nb_w*nb_h);
quantized_coef=zeros(64,nb_w*nb_h);
zigzag_coord=get_zigzag_coord();
for i = 1:nb_h %行方块数
	for j = 1:nb_w %列方块数
		curr_coef=dct2(hall_gray((i-1)*8+1:i*8,(j-1)*8+1:j*8));%dct变换
		for zigzag_index = 1:64
			coef(zigzag_index,(i-1)*nb_w+j)=curr_coef(zigzag_coord(zigzag_index,1),zigzag_coord(zigzag_index,2));
			quantized_coef(zigzag_index,(i-1)*nb_w+j)=round(coef(zigzag_index,(i-1)*nb_w+j)/QTAB(zigzag_coord(zigzag_index,1),zigzag_coord(zigzag_index,2)));
		end
	end
end