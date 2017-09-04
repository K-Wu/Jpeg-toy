load('JpegCoeff.mat');
load('hall.mat');
load('jpegcodes.mat');
imwrite(hall_gray,'raw_image.bmp');
restored_image=jpeg_decode(accode,dccode,width,height,QTAB,ACTAB,DCTAB);
figure;imshow(restored_image);
imwrite(restored_image,'restored_image.jpg');
[PSNR,MSE]=calc_psnr(hall_gray,restored_image)