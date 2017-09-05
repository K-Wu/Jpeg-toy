function result=safebitand(num,num_2)
%num可能是非负数
if num<0
	result=bitand(-num,num_2);
else
	result=bitand(num,num_2);
end