function category = get_category(error)
error=abs(error);
category=0;
while error>0
	error=floor(error/2);
	category=category+1;
	
end