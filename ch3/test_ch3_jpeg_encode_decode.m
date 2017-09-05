%test_ch3_jpeg_encode_decode.m
load('JpegCoeff.mat');
load('hall.mat');
[accode,dccode,quantized_coef,width,height]=jpeg_encode(hall_gray,QTAB,ACTAB,DCTAB);
compression_ratio=calc_compression_ratio(length(accode),length(dccode),size(hall_gray,1),size(hall_gray,2))
restored_image=jpeg_decode(accode,dccode,width,height,QTAB,ACTAB,DCTAB);
figure;imshow(restored_image);
[PSNR,MSE]=calc_psnr(hall_gray,restored_image)