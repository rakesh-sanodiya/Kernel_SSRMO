function [ln_sigma,ln_theta,ln_alpha] = opt_p(traindata,trainlabel,uldata,label_index,unlabel_index,Laplacian,m_theta,Cov_theta,ln_sigma,ln_theta,ln_alpha)
    [parameter_dim,m]=size(ln_theta);
    ln_sigma = minimizor(ln_sigma,@obj,-1);
    function [f,g] = obj(x)
        theta=exp(ln_theta);
        alpha=exp(ln_alpha);
        sigma0=exp(x);
        f=0;
        g=0;
        for i=1:m
            index1=label_index{i};
            index2=unlabel_index{i};
            subdata=[traindata(index1,:);uldata(index2,:)];
            original_Km=CalculateKernelMatrix1(subdata,subdata,theta(:,i));
            coeffMatrix=pinv(eye(size(subdata,1))/alpha(i)+Laplacian{i}*original_Km);
            Km=CalculateKernelMatrix2(traindata(index1,:),traindata(index1,:),theta(:,i),original_Km(:,1:length(index1)),original_Km(:,1:length(index1)),coeffMatrix*Laplacian{i});
            L=chol(Km+sigma0^2*eye(length(index1)))';
            inv_Kms=L'\(L\eye(length(index1)));
           % f=f+trainlabel(index1)*inv_Kms*trainlabel(index1)'+2*sum(log(diag(L)));
            %g=g-trainlabel(index1)*inv_Kms*inv_Kms*trainlabel(index1)'+trace(inv_Kms);
            
            f=f+trainlabel(index1)'*inv_Kms*trainlabel(index1)+2*sum(log(diag(L)));
            g=g-trainlabel(index1)'*inv_Kms*inv_Kms*trainlabel(index1)+trace(inv_Kms);
            
            clear index1 index2 subdata original_Km coeffMatrix Km inv_Kms L;
        end
        f=f/2;
        g=g*sigma0^2;
        clear sigma0 theta alpha;
    end
    for t=1:m
        index1=label_index{t};
        index2=unlabel_index{t};
        [ln_alpha(t),ln_theta(:,t)]=opt_p_s(traindata(index1,:),trainlabel(index1),uldata(index2,:),Laplacian{t},m_theta,Cov_theta,ln_sigma,ln_theta(:,t),ln_alpha(t));
        clear index1 index2;
    end
    clear traindata trainlabel uldata label_index unlabel_index Laplacian m_theta Cov_theta;
end