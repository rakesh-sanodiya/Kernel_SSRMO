function result=CalculateHessianDerivation(F,pair_info,e)
    c=size(pair_info,1);
    result=zeros(size(F,1));
    for i=1:c
        index1=pair_info(i,1);
        index2=pair_info(i,2);
        w=(F(index1)-F(index2)-pair_info(i,3))/(sqrt(2)*e);
        NValue=normpdf(w,0,1);
        PhiValue=erf(w/sqrt(2))/2;
        partial_w=-w/e;
        partial_N=NValue*w^2/e;
        partial_Phi=-NValue*w/e;
        partial_N_Phi=(partial_N*PhiValue-NValue*partial_Phi)/(PhiValue^2);
        partial_value=2*NValue/PhiValue*partial_N_Phi+w*partial_N_Phi+partial_w*NValue/PhiValue;        
        result(index1,index1)=result(index1,index1)+partial_value;
        result(index2,index2)=result(index2,index2)+partial_value;
        result(index1,index2)=result(index1,index2)-partial_value;
        result(index2,index1)=result(index2,index1)-partial_value;
        clear index1 index2 w NValue PhiValue partial_w partial_N partial_Phi partial_N_Phi partial_value;
    end
    clear F pair_info e;