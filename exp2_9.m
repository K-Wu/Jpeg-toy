load('JpegCoeff.mat');
load('hall.mat');
[accode_tot,dc_code,quantized_coef,width,height]=jpeg_encode(hall_gray,QTAB,ACTAB,DCTAB);
