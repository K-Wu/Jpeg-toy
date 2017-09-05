load('hall.mat');
load('JpegCoeff.mat');
test_message='Four score and seven years ago our fathers brought forth on this continent, a new nation, conceived in Liberty, and dedicated to the proposition that all men are created equal. \n Now we are engaged in a great civil war, testing whether that nation, or any nation so conceived and so dedicated, can long endure. We are met on a great battle-field of that war. We have come to dedicate a portion of that field, as a final resting place for those who here gave their lives that that nation might live. It is altogether fitting and proper that we should do this. \n But, in a larger sense, we can not dedicate, we can not consecrate, we can not hallow, this ground. The brave men, living and dead, who struggled here, have consecrated it, far above our poor power to add or detract. The world will little note, nor long remember what we say here, but it can never forget what they did here. It is for us the living, rather, to be dedicated here to the unfinished work which they who fought here have thus far so nobly advanced. It is rather for us to be here dedicated to the great task remaining before us, that from these honored dead we take increased devotion to that cause for which they gave the last full measure of devotion, that we here highly resolve that these dead shall not have died in vain, that this nation, under God, shall have a new birth of freedom, and that government of the people, by the people, for the people, shall not perish from the earth.';
MESSAGE_LENGTH=39;
test_message=test_message(1:MESSAGE_LENGTH);
%测试第一种方法
[accode_1,dccode_1,~,width,height]=dct_naive_embed(test_message,hall_gray,1:64,QTAB,ACTAB,DCTAB);
[char_array_1,restored_image_1]=dct_naive_decode(accode_1,dccode_1,width,height,QTAB,ACTAB,DCTAB,1:64,MESSAGE_LENGTH);
%测试第二种方法
[accode_2,dccode_2,~,width,height]=dct_naive_embed(test_message,hall_gray,[7,10,12,13,14],QTAB,ACTAB,DCTAB);
[char_array_2,restored_image_2]=dct_naive_decode(accode_2,dccode_2,width,height,QTAB,ACTAB,DCTAB,[7,10,12,13,14],MESSAGE_LENGTH);

%测试第三种方法
[accode_3,dccode_3,~,width,height]=dct_embed(test_message,hall_gray,QTAB,ACTAB,DCTAB);
[char_array_3,restored_image_3]=dct_decode(accode_3,dccode_3,width,height,QTAB,ACTAB,DCTAB,MESSAGE_LENGTH);

%不embed，测试原始jpeg编解码结果作为对照
[accode,dccode,~,width,height]=jpeg_encode(hall_gray,QTAB,ACTAB,DCTAB);
restored_image=jpeg_decode(accode,dccode,width,height,QTAB,ACTAB,DCTAB);

compression_ratio=calc_compression_ratio(length(accode),length(dccode),size(hall_gray,1),size(hall_gray,2))
[PSNR,MSE]=calc_psnr(hall_gray,restored_image)

compression_ratio_1=calc_compression_ratio(length(accode_1),length(dccode_1),size(hall_gray,1),size(hall_gray,2))
[PSNR_1,MSE_1]=calc_psnr(hall_gray,restored_image_1)

compression_ratio_2=calc_compression_ratio(length(accode_2),length(dccode_2),size(hall_gray,1),size(hall_gray,2))
[PSNR_2,MSE_2]=calc_psnr(hall_gray,restored_image_2)

compression_ratio_3=calc_compression_ratio(length(accode_3),length(dccode_3),size(hall_gray,1),size(hall_gray,2))
[PSNR_3,MSE_3]=calc_psnr(hall_gray,restored_image_3)

figure;imshow(restored_image);title('restored image origin');imwrite(restored_image,'restored_image.bmp');
figure;imshow(restored_image_1);title('restored image method 1');imwrite(restored_image_1,'restored_image_1.bmp');
figure;imshow(restored_image_2);title('restored image method 2');imwrite(restored_image_2,'restored_image_2.bmp');
figure;imshow(restored_image_3);title('restored image method 3');imwrite(restored_image_3,'restored_image_3.bmp');