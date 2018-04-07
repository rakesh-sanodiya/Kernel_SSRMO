function [result,scale]=ConstructWeightedNNGraph2(data,K,l1,relative)
    n=size(data,1);
    NNlist=zeros(n,K);
    NNdist=zeros(n,K);
    scale=zeros(1,n);
    flag=zeros(n);
    
    
    
    
    
    
    
 %l=K
 l=l1
            X=data
no_classes = max(l);
%no_classes=l
no_reps = 5; % number of constraints for each class combinations

%% generate inequality and equality class indices
% generate some inter-class constraints

equality = [];



%% find initial kernel matrix
K0 = gaussKernel(X,5);




%% perform Bregman projections
P= bregmanProj(K0,relative,equality,10,1);
    
    
   % [distance,result]=sort(K,2);
    %[distance,result]=sort(K,descend);
   [distance,result]=sort(P,2,'descend');
 
    
    NNlist(1:n,:)=result(1:n,2:(K+1));
        NNdist(1:n,:)=distance(1:n,2:(K+1));
    
   % for i=1:n
       % [index,distance]=findKNN(data,data(i,:),K,1);
      %  NNlist(i,:)=index;
       % NNdist(i,:)=distance;
       % scale(i)=max(distance);
        %clear distance;
       % clear index;
    %end
    result=zeros(n);
    for i=1:n
        %if scale(i)==0
         %   continue;
        %end
        for j=1:K
            t=NNlist(i,j);
            if flag(i,t)>0
                continue;
            end
            if flag(t,i)>0
                result(i,t)=result(t,i);
                flag(i,t)=1;
            else
                %result(i,t)=exp(-NNdist(i,j)*NNdist(i,j)/(scale(i)*scale(t)));
                result(i,t)=NNdist(i,j)
                if isnan(result(i,t))
                    1;
                end
                result(t,i)=result(i,t);
                flag(i,t)=1;
                flag(t,i)=1;
            end
        end
    end
    clear flag;
    clear NNdist;
    clear NNlist;
    clear data;