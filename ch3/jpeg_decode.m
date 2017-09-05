function restored_image=jpeg_decode(accode,dccode,width,height,QTAB,ACTAB,DCTAB)
quantized_coef=huffman_decode(accode,dccode,width,height,QTAB,ACTAB,DCTAB);
restored_image=dequan_dct_coef(quantized_coef,width,height,QTAB);