function [PSNR,MSE]=calc_psnr(origin,restored_image)
%输入原图像和jpeg编码复原图像，输出PSNR
MSE=sum(sum((double(origin)-double(restored_image)).^2))/(size(origin,1)*size(origin,2));
PSNR=10*log(255^2/MSE);