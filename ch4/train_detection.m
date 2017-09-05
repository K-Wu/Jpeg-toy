function vect=train_detection(L,dev_index,equalize,isHistogram)
%输出训练好的向量，L为每种颜色的编码长度。dev_index为dev集的index不参与训练,equalize为是否亮度均衡，isHistogram计算的是直方图向量还是颜色向量


num_img=0;%训练图片的数量，在for循环中累加
if isHistogram==1
	vect=zeros(1,pow2(2*L));
else
	vect=zeros(1,pow2(3*L));
end
for img_ind =1:33
	if ismember(i,dev_index)
		continue
	end
	curr_img_name=strcat('../Faces/',num2str(img_ind));
	curr_img_name=strcat(curr_img_name,'.bmp');
	curr_img=imread(curr_img_name);
	if equalize==1
		curr_img=brightness_eq(curr_img);
	end
	if isHistogram==1
		curr_vect=calc_histogram_vect(curr_img,L);
	else
		curr_vect=calc_color_vect(curr_img,L);
	end
	vect=vect+curr_vect;
	num_img=num_img+1;
end
vect=vect/num_img;%除以图片数，求平均值