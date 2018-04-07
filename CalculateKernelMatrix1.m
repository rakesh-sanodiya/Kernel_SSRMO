function result=CalculateKernelMatrix1(data1,data2,theta)
    m=size(data1,1);
    n=size(data2,1);
    result=zeros(m,n);
    for i=1:m
        for j=1:n
            result(i,j)=kernelfunction1(data1(i,:),data2(j,:),theta);
        end
    end
    clear data1 data2 theta;