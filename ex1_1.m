load('hall.mat');
%width=length(hall_color);
%height=length(hall_color(:,1,:));
[height,width]=size(hall_gray);
hall_color_board=hall_color;%copy one for board
%hall_color_circle=hall_color;%copy one for drawing circle
for ind_1 =1:8
	for ind_2 = 1:8
		if rem(ind_1+ind_2,2)==0%染成黑色
			hall_color_board((ind_1-1)*height/8+1:ind_1*height/8,(ind_2-1)*width/8+1:ind_2*width/8,:)=0;
        end
    end
end
mid_height=height/2;
mid_width=width/2;
radius=height/2;%height is shorter
%for ind_1 =1:height
%	diff = sqrt(radius^2-(mid_height-ind_1)^2);
%    point1=int32(round(mid_width+diff));
%    point2=int32(round(mid_width-diff));
%    hall_color_circle(ind_1,point1,:)=[255,0,0];
%    hall_color_circle(ind_1,point2,:)=[255,0,0];
%end
hall_color_circle = insertShape(hall_color,'circle',[mid_width,mid_height,radius],'Color','red');


imwrite(hall_color,'hall.png');
imwrite(hall_color_board,'hall_board.png');
imwrite(hall_color_circle,'hall_color_circle.png');