function zigzag_coord=get_zigzag_coord()
zigzag_coord=zeros(64,2);%按顺序记录坐标
current_index=1;
for sum =2:9  %sum为横纵坐标之和
	if mod(sum,2)==0 %和为偶数时，移动方向左下到右上
		for j = 1:(sum-1) %列数
			zigzag_coord(current_index,:)=[sum-j,j];
			current_index=current_index+1;
		end
	else%和为奇数时，移动方向右上到左下
		for j = (sum-1):-1:1%纵坐标
			zigzag_coord(current_index,:)=[sum-j,j];
			current_index=current_index+1;
		end
	end
end	
for sum = 10:16 %过主对角线的部分
	if mod(sum,2)==0 %和为偶数时，移动方向左下到右上
		for j = (sum-8):8 %列数
			zigzag_coord(current_index,:)=[sum-j,j];
			current_index=current_index+1;
		end
	else%和为奇数时，移动方向右上到左下
		for j = 8:-1:(sum-8)%纵坐标
			zigzag_coord(current_index,:)=[sum-j,j];
			current_index=current_index+1;
		end
	end
end
