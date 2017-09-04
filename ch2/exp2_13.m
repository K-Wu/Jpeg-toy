load('JpegCoeff.mat');
load('snow.mat');
[accode,dccode,quantized_coef,width,height]=jpeg_encode(snow,QTAB,ACTAB,DCTAB);
restored_image=jpeg_decode(accode,dccode,width,height,QTAB,ACTAB,DCTAB);
figure;imshow(restored_image);
compression_ratio=calc_compression_ratio(length(accode),length(dccode),size(snow,1),size(snow,2))
[PSNR,MSE]=calc_psnr(snow,restored_image)
imwrite(restored_image,'restored_snow.jpg');