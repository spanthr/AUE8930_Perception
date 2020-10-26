function [arr]= down_sample(gray1)
% imag=imgg;

arr=zeros(length(gray1/2),length(gray1/2))

for i=1:2:length(gray1);
    for j=1:2:length(gray1);
        if (rem(j,2)==0)
            arr(i-1,j-1)=imag(i,j)
        end
    end
end
end
