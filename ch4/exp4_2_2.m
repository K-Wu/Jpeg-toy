%dev_index=[15,12,16,4,13];%dev集
dev_index=[];

L_hist=4;%直方图量化位数
max_hist_dist=0.65;%直方图距离自定义阈值

%训练向量
%第二个参数为dev集，我们用上全部数据训练，所以是空集
%第三个logical参数是否进行亮度均衡，作用为负所以关掉了
%我们最后这一步只用了直方图，所以不训练人脸颜色向量
%face_vect=train_detection(L,dev_index,0,0);%训练颜色向量，如指导书所说；
face_hist_vect=train_detection(L_hist,dev_index,0,1);%训练直方图向量，与训练颜色向量一样

test_img_name='../detection/2.jpg';
test_img=imread(test_img_name);

%test_img=uint8(brightness_eq(test_img));%亮度均衡，关掉了
%test_rgb_validity(test_img);%assert 亮度<=255
%test_img=imresize(test_img,0.125);%缩小8倍，在很大很大图的图中用，来简化计算
%test_rgb_validity(test_img);%同上

%由于计算较为漫长。。，我们使用步进来跳过一些像素点的计算，改成了1，说明没用到；
%window来控制每次计算选取的区域大小，来更好反应局部信息，改成了0，说明也没用
stepping=1;
sample_window=0;


%我们计算每一个像素点的颜色和直方图距离，由于一个点不好反应局部的情况
%我们最初设想的是sample_window取大一些，来计算一个window里面的平均值
%最后没有这样做，发现也很不错
%并且我们没有计算颜色向量的距离
%dist_color=zeros(ceil(size(test_img,1)/stepping),ceil(size(test_img,2)/stepping));
dist_hist=zeros(ceil(size(test_img,1)/stepping),ceil(size(test_img,2)/stepping));
for t_i=1:stepping:size(test_img,1)
	for t_j=1:stepping:size(test_img,2)
		[t_i,t_j];%调试时去掉分号打印当前坐标
		
		%求颜色向量和直方图向量
		%color_vect=calc_color_vect(test_img(t_i:min(t_i+sample_window,size(test_img,1)),t_j:min(t_j+sample_window,size(test_img,2)),:),L);
		hist_vect=calc_histogram_vect(test_img(t_i:min(t_i+sample_window,size(test_img,1)),t_j:min(t_j+sample_window,size(test_img,2)),:),L_hist);
		
		%在颜色、直方图距离图上记录与训练得到的人脸向量距离
		%经过反复运行，我们最终决定这一部只用直方图
		%dist_color(ceil(t_i/stepping),ceil(t_j/stepping))=calc_dist(color_vect,face_vect);
		dist_hist(ceil(t_i/stepping),ceil(t_j/stepping))=calc_dist(hist_vect,face_hist_vect);
	end
end
%figure;imshow(dist_color);title('color dist raw');
figure;imshow(dist_hist);title('hist dist raw');


%这一步根据距离图，得到二值图像，1的点意味着疑似肤色
autoCluster=1;
if autoCluster==1%使用kmeans聚类生成二值图像
	dist_hist_cluster=reshape(dist_hist,[ceil(size(test_img,1)/stepping)*ceil(size(test_img,2)/stepping),1]);
	[dist_hist_cluster,center]=kmeans(dist_hist_cluster,2);
	dist_hist_cluster=reshape(dist_hist_cluster,[ceil(size(test_img,1)/stepping),ceil(size(test_img,2)/stepping)]);
	dist_hist_cluster=dist_hist_cluster-1;%将1，2分类变成0，1；这样就变成了二值图像
	[center(1),center(2)]
	if center(1)<center(2)
		dist_hist_cluster=~dist_hist_cluster;%1要代表疑似肤色
		'flip'
	end
else%使用手动阈值
			dist_hist_cluster=dist_hist<=max_hist_dist;
			
end
figure;imshow(dist_hist_cluster);title('possible facial area binary');
