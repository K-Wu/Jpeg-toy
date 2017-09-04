function result_img=detect_face(img,vect,MIN_WINDOW,L,THRESHOLD)
result_img=img;
for t_i=1:size(img,1)%上纵坐标
	for b_i=t_i+MIN_WINDOW-1:size(img,1)%下纵坐标
		for l_j=1:size(img,2)%左横坐标
			for r_j=l_j+MIN_WINDOW-1:size(img,2)
				curr_vect=calc_color_vect(img,L);
