function F=optimizeParameters3(traindata,trainlabel,uldata,pair_info,ln_sigma,ln_theta,ln_alpha,ln_e,Laplacian)
    sigma=exp(ln_sigma);
    theta=exp(ln_theta);
    alpha=exp(ln_alpha);
    e=exp(ln_e);
    c=size(pair_info,1);
    data=[traindata;uldata];
    n=size(data,1);
    n1=size(traindata,1);
    inv_Km=pinv(CalculateKernelMatrix1(data,data,theta))+alpha*Laplacian;
    clear ln_sigma ln_theta ln_alpha ln_e;
    F = minimizor(zeros(n,1),@obj,-5);
    function [fun,grad] = obj(f0)
        fun=f0'*inv_Km*f0/2+sigma^(-2)*sum((f0(1:n1)'-trainlabel).^2)/2;
        for i=1:c
            fun=fun-log(erf((f0(pair_info(i,1))-f0(pair_info(i,2))-pair_info(i,3))/(2*e))/2);
        end
        grad=inv_Km*f0+sigma^(-2)*[f0(1:n1)-trainlabel';zeros(n-n1,1)];
        for i=1:c
            tmp=(f0(pair_info(i,1))-f0(pair_info(i,2))-pair_info(i,3))/e;
            grad(pair_info(i,1))=grad(pair_info(i,1))-normpdf(tmp/sqrt(2),0,1)/(sqrt(2)*e*erf(tmp/2)/2);
            grad(pair_info(i,2))=grad(pair_info(i,2))+normpdf(tmp/sqrt(2),0,1)/(sqrt(2)*e*erf(tmp/2)/2);
        end
    end
    clear sigma theta alpha e traindata trainlabel uldata pair_info Laplacian data inv_Km;
end