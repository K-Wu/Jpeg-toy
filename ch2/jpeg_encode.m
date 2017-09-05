function [accode_tot,dc_code,quantized_coef,width,height]=jpeg_encode(hall_gray,QTAB,ACTAB,DCTAB)
[quantized_coef,coef,width,height]=quan_dct_coef(hall_gray,QTAB);
[accode_tot,dc_code,quantized_coef,width,height]=huffman_encode(quantized_coef,width,height,QTAB,ACTAB,DCTAB);
