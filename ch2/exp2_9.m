load('JpegCoeff.mat');
load('hall.mat');
[accode,dccode,quantized_coef,width,height]=jpeg_encode(hall_gray,QTAB,ACTAB,DCTAB);
save('jpegcodes.mat','accode','dccode','width','height');