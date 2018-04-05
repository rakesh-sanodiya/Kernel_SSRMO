function ln_theta=optimizeParameters_1_sub(traindata,trainlabel,m_theta,Cov_theta,ln_sigma,ln_theta)
    n=size(traindata,1);
    sigma0=exp(ln_sigma);
    ln_theta = minimizor(ln_theta,@obj,-5);
    function [f,g] = obj(x)
        theta0=exp(x);
        tmp=CalculateKernelMatrix1(traindata,traindata,theta0)+sigma0^2*eye(n);
        if any(isinf(tmp(:))+isnan(tmp(:)))
            f=inf;
            g=ones(size(x))*inf;
            return;
        end
        L=chol(tmp)';
        clear tmp;
        inv_Kms=L'\(L\eye(size(L)));
        f=trainlabel*inv_Kms*trainlabel'+2*sum(log(diag(L)))+(theta0-m_theta)'*pinv(Cov_theta)*(theta0-m_theta);
        clear L;
        f=f/2;
        tmp=inv_Kms*trainlabel';
        A=inv_Kms-tmp*tmp';
        g=diag(theta0)*(Tr(A,traindata,theta0)+2*pinv(Cov_theta)*(theta0-m_theta))/2;
        clear tmp A inv_Kms;
    end
    clear traindata trainlabel m_theta Cov_theta ln_sigma sigma0;
end