%训练训练集，得到人脸向量，在dev集上得到最大距离
dev_index=[15,12,16,4,13];%dev集
for L=3:5
	face_vect=train_detection(L,dev_index,0,0);%计算人脸向量
	num_dev=0;
	dists=zeros(1,0);
	for img_ind =1:33
		if ismember(img_ind,dev_index)
			curr_img_name=strcat('../Faces/',num2str(img_ind));
			curr_img_name=strcat(curr_img_name,'.bmp');
			curr_img=imread(curr_img_name);
			curr_vect=calc_color_vect(curr_img,L);
			num_dev=num_dev+1;
			dists(num_dev)=calc_dist(face_vect,curr_vect);%测试集图片距离
		end
	end
	L%打印L
	dists%打印距离矩阵以及最大距离
	max_dist=max(dists)+0.2;%这个值作为阈值，在L=4和5时表现不好
	%max_dist=0.45%钦定阈值为0.45
	recall=0;
	TEST_NUM=10;
	CASE_PER_TEST=5;
	nums_correct=zeros(1,0);
	for curr_test=1:TEST_NUM
		test_case=randperm(33,CASE_PER_TEST);
		face_vect=train_detection(L,test_case,0,0);
		num_correct=0;%正确的数量
		for img_ind =1:33
			if ismember(img_ind,test_case)
				curr_img_name=strcat('../Faces/',num2str(img_ind));
				curr_img_name=strcat(curr_img_name,'.bmp');
				curr_img=imread(curr_img_name);
				img_ind;
				curr_vect=calc_color_vect(curr_img(1:min([size(curr_img,1),40]),1:min([size(curr_img,2),40]),:),L);
				num_dev=num_dev+1;
				if calc_dist(face_vect,curr_vect)<max_dist
					num_correct=num_correct+1;
				end
			end
		end
		nums_correct(curr_test)=num_correct;
		recall=recall+num_correct;
	end
	nums_correct
	recall=recall/TEST_NUM/CASE_PER_TEST%几次测试平均准确率
end