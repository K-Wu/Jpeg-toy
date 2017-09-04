function code=encode_magnitude(magnitude)
if magnitude>=0
	code=encode_positive_magnitude(magnitude);
else
	code=~encode_positive_magnitude(abs(magnitude));
end

function code = encode_positive_magnitude(magnitude)
code=zeros(1,0);
icode=zeros(1,0);%code逆序,但是不包括code最高位的0
current_index=1;
%code(1)=0;符号位不存在的
while magnitude~=0
	icode(current_index)=mod(magnitude,2);
	magnitude=floor(magnitude/2);
	current_index=current_index+1;
end
icode_length=length(icode);
for i=1:icode_length
	code(icode_length+1-i)=icode(i);
end