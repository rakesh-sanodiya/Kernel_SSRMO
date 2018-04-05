function [ln_sigma,ln_theta] = optimizeParameters_1(traindata,trainlabel,train_task_index,m_theta,Cov_theta,ln_sigma,ln_theta)
    [parameter_dim,m]=size(ln_theta);
    data_index=cell(1,m);
    for j=1:m
        data_index{j}=sort(find(train_task_index==j));
    end
    ln_sigma = minimizor(ln_sigma,@obj,-5);
    function [f,g] = obj(x)
        sigma0=exp(x);
        f=0;
        g=0;
        for i=1:m
            index=data_index{i};
            tmp=CalculateKernelMatrix1(traindata(index,:),traindata(index,:),exp(ln_theta(:,i)))+sigma0^2*eye(length(index));
            if any(isinf(tmp(:))+isnan(tmp(:)))
                f=inf;
                g=ones(size(x))*inf;
                return;
            end
            L=chol(tmp)';
            inv_Kms=L'\(L\eye(length(index)));
            f=f+trainlabel(index)*inv_Kms*trainlabel(index)'+2*sum(log(diag(L)));
            clear tmp L;
            g=g-trainlabel(index)*inv_Kms*inv_Kms*trainlabel(index)'+trace(inv_Kms);
            clear inv_Kms index;
        end
        f=f/2;
        g=g*sigma0^2;
    end
    for t=1:m
        ln_theta(:,t) = optimizeParameters_1_sub(traindata(data_index{t},:),trainlabel(data_index{t}),m_theta,Cov_theta,ln_sigma,ln_theta(:,t));
    end
    clear traindata trainlabel train_task_index m_theta Cov_theta data_index;
end