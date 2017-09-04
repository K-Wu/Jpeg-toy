function pos_vect=get_non_zero_position(vect)
pos_vect=zeros(1,0);

for i=1:length(vect)
	if vect(i)>0
		pos_vect(size(pos_vect,2)+1)=i;
	end
end