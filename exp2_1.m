load('hall.mat')
tile_origin=hall_color(1:80,1:80,:);
tile_origin=int16(rgb2gray(tile_origin));%转换成灰度图像，并且转换成int支持正负数，16位防止溢出
tile_dct=dct2(tile_origin);%离散余弦变换
diff=zeros(80,80);
diff(1,1)=128*80;%变换域的亮度减小方法
tile_dct=tile_dct-diff;
tile_dct=idct2(tile_dct);
tile_directly = tile_origin-128;%直接原图像减小亮度

imshow(tile_directly,[-128,127]);%显示两种方法得到修改后的图片
figure;imshow(tile_dct,[-128,127]);