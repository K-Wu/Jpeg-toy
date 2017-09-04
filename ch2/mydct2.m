function b=mydct2(a)
N=length(a);
D=zeros(N,N);%DCT算子
D(1,:)=sqrt(1/N);
for i=2:N
	for j=1:N
		D(i,j)=sqrt(2/N)*cos(pi*(2*j-1)*(i-1)/(2*N));
	end
end
a=double(a);
b=D*a*transpose(D);