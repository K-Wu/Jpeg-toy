function newnum=lsreplace(num,newbit)
%将num的最后一bit替换为newbit
if num<0
	newnum=-lsreplace(-num,newbit);
else
oldbit=bitand(num,1);
newnum=num-oldbit+newbit;%调换次序，防止负数归0
end