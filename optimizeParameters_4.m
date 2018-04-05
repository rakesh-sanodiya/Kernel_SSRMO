function [ln_sigma,ln_theta,ln_alpha,ln_e]=optimizeParameters_4(traindata,trainlabel,uldata,label_index,unlabel_index,pair_info,Laplacian,m_theta,Cov_theta,F,ln_sigma,ln_theta,ln_alpha,ln_e)
    [parameter_dim,m]=size(ln_theta);
    theta0=exp(ln_theta);
    alpha0=exp(ln_alpha);
    optimum = minimizor([ln_sigma;ln_e],@obj,-5);
    function [f,g] = obj(x)
        sigma0=exp(x(1));
        e0=exp(x(2));
        f=0;
        g=zeros(size(x));
        for i=1:m
            index1=label_index{i};
            index2=unlabel_index{i};
            data=[traindata(index1,:);uldata(index2,:)];
            n1=length(index1);
            n2=length(index2);
            original_inv_Km=pinv(CalculateKernelMatrix1(data,data,theta0(:,i)));
            inv_Km=original_inv_Km+alpha0(i)*Laplacian{i};
            Sigma_MAP=CalculateHessian(F{i},pair_info{i},e0);
            I=eye(n1+n2);
            I((n1+1):(n1+n2),(n1+1):(n1+n2))=0;
            CoeffMatrix=pinv(inv_Km+Sigma_MAP+sigma0^(-2)*I);
            f0=F{i};
            L=chol(eye(n1+n2)+pinv(inv_Km)*(Sigma_MAP+sigma0^(-2)*I))';
            f=f+sigma0^(-2)*sum((f0(1:n1)'-trainlabel(index1)).^2)/2+n1*log(sigma0)+sum(log(diag(L)));
            clear L;
            pair_info0=pair_info{i};
            for j=1:size(pair_info0,1)
                tmp=(f0(pair_info0(j,1))-f0(pair_info0(j,2))-pair_info0(j,3))/(sqrt(2)*e0);
                f=f-log(erf(tmp/sqrt(2))/2);
                g(2)=g(2)+tmp*normpdf(tmp,0,1)/(erf(tmp/sqrt(2))*e0/2);
            end
            clear I pair_info0;
            g(1)=g(1)+n1-(trace(CoeffMatrix)+sum((f0(1:n1)'-trainlabel(index1)).^2))*sigma0^(-2);
            g(2)=g(2)+trace(CoeffMatrix*CalculateHessianDerivation(f0,pair_info{i},e0))/2;
            clear tmp index1 index2 data inv_Km Sigma_MAP CoeffMatrix f0 original_inv_Km;
        end
        g(2)=g(2)*e0;
    end
    ln_sigma=optimum(1);
    ln_e=optimum(2);
    for t=1:m
        index1=label_index{t};
        index2=unlabel_index{t};
        [ln_alpha(t),ln_theta(:,t)]=optimizeParameters_4_sub(traindata(index1,:),trainlabel(index1),uldata(index2,:),pair_info{t},Laplacian{t},m_theta,Cov_theta,F{t},ln_sigma,ln_e,ln_theta(:,t),ln_alpha(t));
    end
    clear traindata trainlabel uldata label_index unlabel_index pair_info Laplacian m m_theta Cov_theta F;
end