load('JpegCoeff.mat');
load('hall.mat');
[quantized_coef,coef,width,height]=quan_dct_coef(hall_gray,QTAB);