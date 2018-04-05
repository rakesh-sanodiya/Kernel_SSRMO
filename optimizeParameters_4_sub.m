function [ln_alpha,ln_theta]=optimizeParameters_4_sub(traindata,trainlabel,uldata,pair_info,Laplacian,m_theta,Cov_theta,f0,ln_sigma,ln_e,ln_theta,ln_alpha)
    n1=size(traindata,1);
    n2=size(uldata,1);
    data=[traindata;uldata];
    parameter_dim=length(ln_theta);
    sigma0=exp(ln_sigma);
    e0=exp(ln_e);
    optimum = minimizor([ln_theta;ln_alpha],@obj,-5);
    function [f,g] = obj(x)
        theta0=exp(x(1:parameter_dim));
        alpha0=exp(x(length(x)));
        original_inv_Km=pinv(CalculateKernelMatrix1(data,data,theta0));
        inv_Km=original_inv_Km+alpha0*Laplacian;
        Km=pinv(inv_Km);
        Sigma_MAP=CalculateHessian(f0,pair_info,e0);
        I=eye(n1+n2);
        I((n1+1):(n1+n2),(n1+1):(n1+n2))=0;
        CoeffMatrix=pinv(inv_Km+Sigma_MAP+sigma0^(-2)*I);
        L=chol(eye(n1+n2)+Km*(Sigma_MAP+sigma0^(-2)*I))';
        f=f0'*inv_Km*f0/2+sum(log(diag(L)));
        f=f+(theta0-m_theta)'*pinv(Cov_theta)*(theta0-m_theta)/2;
        g(parameter_dim+1)=alpha0*(-f0'*Laplacian*f0+trace((CoeffMatrix-Km)*Laplacian))/2;
        tmp=original_inv_Km*(Km-f0*f0'-CoeffMatrix)*original_inv_Km;
        g(1:parameter_dim)=diag(theta0)*(Tr(tmp,data,theta0)+2*pinv(Cov_theta)*(theta0-m_theta))/2;
        clear I Km tmp original_inv_Km inv_Km Sigma_MAP CoeffMatrix;
    end
    ln_theta=optimum(1:parameter_dim);
    ln_alpha=optimum(parameter_dim+1);
    clear data optimum parameter_dim traindata trainlabel uldata Laplacian m_theta Cov_theta ln_sigma sigma0 ln_e e0 pair_info f0;
end