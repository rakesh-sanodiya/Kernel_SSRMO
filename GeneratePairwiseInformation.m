function pair_info=GeneratePairwiseInformation(trainlabel,ullabel,pisize)
    m=length(trainlabel);
    pair_info=cell(1,m);
    for i=1:m
        pair_info{i}=GeneratePIforSingleTask(trainlabel{i},ullabel{i},pisize);
    end
    
function result=GeneratePIforSingleTask(trainlabel,ullabel,pisize)
    n1=length(trainlabel);
    n2=length(ullabel);
    result=zeros(pisize,3);
    threshold=0.2;
    AllInfo=zeros(n1+n2,n1+n2);
    gap=5;
    count=0;
    while count<pisize
        num=rand;
        if num>=threshold
            index=RandomIntwithoutReplacement(1,n2,1,2);
            index1=n1+index(1);
            index2=n1+index(2);
            clear index;
            if AllInfo(index1,index2)>0||AllInfo(index2,index1)>0
                continue;
            else
                count=count+1;
                result(count,1)=index1;
                result(count,2)=index2;
                diff=ullabel(index1-n1)-ullabel(index2-n1);
                num2=rand;
                result(count,3)=gap*num2+diff-gap;
                AllInfo(index1,index2)=1;
                AllInfo(index2,index1)=1;
            end
            clear index;
        else
            index1=RandomIntwithoutReplacement(1,n1,1,1);
            index2=RandomIntwithoutReplacement(1,n2,1,1)+n1;
            if AllInfo(index1,index2)>0||AllInfo(index2,index1)>0
                continue;
            else
                count=count+1;
                result(count,1)=index1;
                result(count,2)=index2;
                diff=trainlabel(index1)-ullabel(index2-n1);
                num2=rand;
                result(count,3)=gap*num2+diff-gap;
                AllInfo(index1,index2)=1;
                AllInfo(index2,index1)=1;
            end
        end
    end
    clear trainlabel ullabel AllInfo;