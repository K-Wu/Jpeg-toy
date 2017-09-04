function test_rgb_validity(img)
%输入rgb图片，测试是否有地方超过256
for i=1:size(img,1)
	for j=1:size(img,2)
		for ch=1:size(img,3)
			assert(img(i,j,ch)<=255)
		end
	end
end