function magnitude=decode_magnitude(code)
if isempty(code)==1
	magnitude=0;
return
end
if code(1)==1
	magnitude=decode_positive_magnitude(code);
else
	magnitude=-decode_positive_magnitude(~code);
end

function magnitude=decode_positive_magnitude(code)
magnitude=0;
base=1;
code_length=length(code);
for i=code_length:-1:1
	magnitude=magnitude+base*code(i);
	base=base*2;
end