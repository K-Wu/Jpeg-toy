load('JpegCoeff.mat');
load('hall.mat');
QTAB=floor(QTAB/2);
[accode,dccode,quantized_coef,width,height]=jpeg_encode(hall_gray,QTAB,ACTAB,DCTAB);
restored_image=jpeg_decode(accode,dccode,width,height,QTAB,ACTAB,DCTAB);
figure;imshow(restored_image);
compression_ratio=calc_compression_ratio(length(accode),length(dccode),size(hall_gray,1),size(hall_gray,2))
[PSNR,MSE]=calc_psnr(hall_gray,restored_image)
imwrite(restored_image,'restored_image_half_quan.jpg');