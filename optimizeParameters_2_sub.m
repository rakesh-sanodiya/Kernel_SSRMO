function [ln_alpha,ln_theta]=optimizeParameters_2_sub(traindata,trainlabel,uldata,Laplacian,m_theta,Cov_theta,ln_sigma,ln_theta,ln_alpha)
    n1=size(traindata,1);
%     n2=size(uldata,1);
    parameter_dim=length(ln_theta);
    sigma=exp(ln_sigma);
    subdata=[traindata;uldata];
    optimum = minimizor([ln_theta;ln_alpha],@obj,-1);
    function [f,g] = obj(x)
        theta0=exp(x(1:parameter_dim));
        alpha0=exp(x(length(x)));
        original_Km=CalculateKernelMatrix1(subdata,subdata,theta0);
        coeffMatrix=pinv(eye(size(subdata,1))/alpha0+Laplacian*original_Km);
        Km=CalculateKernelMatrix2(traindata,traindata,theta0,original_Km(:,1:n1),original_Km(:,1:n1),coeffMatrix*Laplacian);
        L=chol(Km+sigma^2*eye(n1))';
        inv_Kms=L'\(L\eye(n1));
      %  f=trainlabel*inv_Kms*trainlabel'+2*sum(log(diag(L)))+(theta0-m_theta)'*pinv(Cov_theta)*(theta0-m_theta);
       f=trainlabel'*inv_Kms*trainlabel+2*sum(log(diag(L)))+(theta0-m_theta)'*pinv(Cov_theta)*(theta0-m_theta);
       
      f=f/2;
      %tmp=inv_Kms*trainlabel'; 
      tmp=inv_Kms*trainlabel;
        A=inv_Kms-tmp*tmp';
        clear tmp;
        tmp=Tr2(A,traindata,uldata,theta0,alpha0,original_Km,coeffMatrix,Laplacian);
        g(1:parameter_dim)=diag(theta0)*(tmp(1:parameter_dim)+2*pinv(Cov_theta)*(theta0-m_theta))/2;
        g(parameter_dim+1)=alpha0*tmp(parameter_dim+1)/2;
        g=g';
        clear tmp alpha0 theta0 original_Km coeffMatrix Km inv_Kms;
    end
    ln_theta=optimum(1:parameter_dim);
    ln_alpha=optimum(parameter_dim+1);
    clear subdata optimum parameter_dim traindata trainlabel uldata Laplacian m_theta Cov_theta ln_sigma sigma;
end