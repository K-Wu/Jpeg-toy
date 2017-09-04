function magnitude=decode_magnitude_non_negative(code)
if isempty(code)==1
	magnitude=0;
return
end
magnitude=decode_positive_magnitude(code);


function magnitude=decode_positive_magnitude(code)
magnitude=0;
base=1;
code_length=length(code);
for i=code_length:-1:1
	magnitude=magnitude+base*code(i);
	base=base*2;
end