function padded_array=get_padding(array,len)
current_length=length(array);
array(current_length+1:len)=0;
padded_array=array;