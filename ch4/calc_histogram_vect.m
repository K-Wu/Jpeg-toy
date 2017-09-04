function vect=calc_histogram_vect(img,L)
%输入rgb图像，输出统计直方图，累计(h,s)，最后reshape成一维向量,L为量化位数
img=rgb2hsv(img);
base=pow2(L)-1;%量化最大值
vect=zeros(base+1,base+1);
for i=1:size(img,1)
	for j=1:size(img,2)
		curr_h=floor(img(i,j,1)*base);
		curr_s=floor(img(i,j,2)*base);
		vect(curr_h+1,curr_s+1)=vect(curr_h+1,curr_s+1)+1;
	end
end
vect=reshape(vect,[1,(base+1)*(base+1)]);