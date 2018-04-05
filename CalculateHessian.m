function Sigma_MAP=CalculateHessian(F,pair_info,e)
    c=size(pair_info,1);
    Sigma_MAP=zeros(size(F,1));
    for i=1:c
        index1=pair_info(i,1);
        index2=pair_info(i,2);
        tmp=(F(index1)-F(index2)-pair_info(i,3))/(sqrt(2)*e);
        tmp1=normpdf(tmp,0,1)/(erf(tmp/sqrt(2))/2);
        tmp1=tmp1^2+tmp1*tmp;
        tmp1=tmp1/(2*e^2);
        Sigma_MAP(index1,index1)=Sigma_MAP(index1,index1)+tmp1;
        Sigma_MAP(index2,index2)=Sigma_MAP(index2,index2)+tmp1;
        Sigma_MAP(index1,index2)=Sigma_MAP(index1,index2)-tmp1;
        Sigma_MAP(index2,index1)=Sigma_MAP(index2,index1)-tmp1;
        clear index1 index2 tmp tmp1;
    end
    clear F pair_info e;