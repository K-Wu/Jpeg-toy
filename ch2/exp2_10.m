load('JpegCoeff.mat');
load('hall.mat');
[accode,dccode,quantized_coef,width,height]=jpeg_encode(hall_gray,QTAB,ACTAB,DCTAB);
compression_ratio=calc_compression_ratio(length(accode),length(dccode),size(hall_gray,1),size(hall_gray,2))