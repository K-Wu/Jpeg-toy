function [accode_tot,dc_code,quantized_coef,width,height]=jpeg_encode(hall_gray,QTAB,ACTAB,DCTAB)
[quantized_coef,coef,width,height]=quan_dct_coef(hall_gray,QTAB);
accode_tot=zeros(1,0);
current_index=1;
[dc_code,dc_length] = encode_dc(quantized_coef(1,:),DCTAB);
for i=1:size(quantized_coef,2) %ac编码
	[ac_code,ac_length]=encode_ac(quantized_coef(2:64,i),ACTAB);
	next_index=current_index+ac_length;
	accode_tot(current_index:next_index-1)=ac_code;
	current_index=next_index;
end

function [dc_code,code_length]=encode_dc(dc_array,DCTAB)
%输入整张图的(1,1)元素向量，输出DC编码
dc_array_length=length(dc_array);
dc_diff=zeros(1,dc_array_length);%预测误差
category=zeros(1,dc_array_length);%category向量
dc_code=zeros(1,0);
current_index=1;
if dc_array_length>=1
	
	dc_diff(1)=dc_array(1);
	for i =2:dc_array_length
		dc_diff(i)=dc_array(i)-dc_array(i-1);
	end
	
	for i=1:dc_array_length
		category(i)=get_category(dc_diff(i));
		next_index=current_index+DCTAB(category(i)+1,1);
		dc_code(current_index:next_index-1)=DCTAB(category(i)+1,2:2+DCTAB(category(i)+1,1)-1);
		current_index=next_index;
		if category(i)>0
			magnitude_code=encode_magnitude(dc_diff(i));
			next_index=current_index+length(magnitude_code);
			dc_code(current_index:next_index-1)=magnitude_code;
			current_index=next_index;
		end
	end
end
code_length=current_index-1;


function [ac_code,code_length]=encode_ac(ac_array,ACTAB)
%输入一个块的非(1,1)的DCT分量向量，输出AC编码
ac_array_length=length(ac_array);
category=zeros(1,ac_array_length);%category向量
ac_code=zeros(1,0);
current_index=1;
if ac_array_length>=1
	
	for i=1:ac_array_length
		category(i)=get_category(ac_array(i));
	end
	zero_length=0;
	
	for i = 1:ac_array_length
		if ac_array(i)==0
			zero_length=zero_length+1;
		else
			while zero_length>=16%超过16个0，用ZRL填充
				next_index=current_index+11;
				ac_code(current_index:next_index-1)=[1,1,1,1,1,1,1,1,0,0,1];
				zero_length=zero_length-16;
				current_index=next_index;
			end
			next_index=current_index+ACTAB(zero_length*10+category(i),3);
			ac_code(current_index:next_index-1)=ACTAB(zero_length*10+category(i),4:4+ACTAB(zero_length*10+category(i),3)-1);
			current_index=next_index;
			magnitude_code=encode_magnitude(ac_array(i));
			next_index=current_index+length(magnitude_code);
			ac_code(current_index:next_index-1)=magnitude_code;
			zero_length=0;
			current_index=next_index;
		end
	end
end
ac_code(current_index:current_index+3)=[1,0,1,0];%EOB
code_length=current_index+3;

