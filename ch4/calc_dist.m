function dist=calc_dist(vect1,vect2)
vect1=vect1/sum(vect1);%使和为1
vect2=vect2/sum(vect2);
vect1=sqrt(vect1);
vect2=sqrt(vect2);%开根号（上述做法是按照4.13，虽然不常见）
dist=1-sum(vect1.*vect2);