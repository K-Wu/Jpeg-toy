
L=5;%颜色量化位数
face_vect=train_detection(L,dev_index,0,0);%我们在这个步骤里训练颜色???
MIN_WINDOW=10;%小于于这么多像素点的连通域会被忽视

se=strel('square',3);%开?作kernel
opened=imopen(dist_hist_cluster,se);%开运算，去除噪点，以及将两个原本应该分开的连通域分开
filtered=bwareaopen(opened,MIN_WINDOW);%过滤小于MIN_WINDOW的噪点
figure;imshow(filtered);title('connected component filtered');
boxes=regionprops(filtered,'BoundingBox');%找到连通域的框长宽??标
%四维为左上角x，y；以及x,y方向的宽度；很不幸的是，x是宽度所在维度
true_boxes=zeros(0,4);%记录真的是人脸的boxes的四维
cc_color_dist=zeros(0,1);

%对各连通区域，计算距离图，下一步聚类判断是否是人脸
for i =1:length(boxes)
	t_x=boxes(i).BoundingBox(2);%上纵坐标
	b_x=boxes(i).BoundingBox(2)+boxes(i).BoundingBox(4);%下纵坐标
	l_y=boxes(i).BoundingBox(1);%左横坐标
	r_y=boxes(i).BoundingBox(1)+boxes(i).BoundingBox(3);%右横坐标
	color_vect=calc_color_vect(test_img(t_x:b_x,l_y:r_y,:),L);
	cc_color_dist(i,1)=calc_dist(face_vect,color_vect);
end

%聚类判断是否是人脸
[cc_color_dist_cluster,cc_color_center]=kmeans(cc_color_dist,2);
cc_color_dist_cluster=cc_color_dist_cluster-1;%将1，2分类改成0，1；
[cc_color_center(1),cc_color_center(2)]
if cc_color_center(1)<cc_color_center(2)
	cc_color_dist_cluster=~cc_color_dist_cluster;%1代表是人脸
	'flip'
end
for i =1:length(boxes)
	if cc_color_dist_cluster(i)
		true_boxes(size(true_boxes,1)+1,:)=boxes(i).BoundingBox;%如果是人脸，存入true_boxes
	end
end

%在原图上用框标记人脸
img_marked=test_img;
for i=1:length(true_boxes)
	img_marked=insertShape(img_marked,'rectangle',true_boxes(i,:),'Color','red','LineWidth',5);
end
figure;imshow(img_marked);title('img marked');