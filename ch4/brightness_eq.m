function new_img=brightness_eq(img)
new_img=rgb2hsv(img);
new_img(:,:,2)=histeq(new_img(:,:,2));
new_img=hsv2rgb(new_img);
new_img=new_img*255;