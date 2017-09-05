function non_zero_j=get_last_non_zero_index(vect)
%返回向量最后一位不为0的index，0说明全是0
non_zero_j=length(vect);
while non_zero_j>0;
	if vect(non_zero_j)~=0
		break;
	end
	non_zero_j=non_zero_j-1;
end