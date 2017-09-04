function color_vect=calc_color_vect(curr_img,L)
%输出一张图片的颜色向量，其中L为每种颜色的编码长度
ORI_CODE_LEN=8;%原来每种颜色的编码长度，减去L即为移位的位数
color_vect=zeros(1,pow2(3*L));%当前图片的向量
curr_img=double(curr_img);
for i =1:size(curr_img,1)
	for j =1:size(curr_img,2)
		[i,j];
		red_code=floor(curr_img(i,j,1)/pow2(ORI_CODE_LEN-L));
		green_code=floor(curr_img(i,j,2)/pow2(ORI_CODE_LEN-L));
		blue_code=floor(curr_img(i,j,3)/pow2(ORI_CODE_LEN-L));
		color_vect(1+red_code*pow2(2*L)+green_code*pow2(L)+blue_code)=color_vect(1+red_code*pow2(2*L)+green_code*pow2(L)+blue_code)+1;
	end
end
color_vect=color_vect/(size(curr_img,1)*size(curr_img,2));%除以像素数量，求平均值