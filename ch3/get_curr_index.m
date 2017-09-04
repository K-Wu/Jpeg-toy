function [curr_height,curr_width,curr_channel]=get_curr_index(index,img_size_height,img_size_width,img_size_channel)
%输入img的三维大小，以及index，输出index对应的像素，for loop从外到内是channel, height, width
curr_channel=ceil(index/(img_size_height*img_size_width));
residue=index-img_size_height*img_size_width*(curr_channel-1);
curr_height=ceil(residue/img_size_width);
curr_width=residue-(curr_height-1)*img_size_width;
