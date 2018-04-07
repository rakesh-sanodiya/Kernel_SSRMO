function [data,label,task_index,ins_num]=Convert_data(data,label)
    m=length(data);
    newdata=[];
    newlabel=[];
    task_index=[];
    ins_num=zeros(1,m);
    for i=1:m
        newdata=[newdata;data{i}];
        newlabel=[newlabel,label{i}];
        task_index=[task_index,i*ones(1,size(data{i},1))];
        ins_num(i)=size(data{i},1);
    end
    clear data label;
    data=newdata;
    label=newlabel;
    clear newdata newlabel;
    
%  load('iris.txt')
%  labels=iris(1:150,5)
%  X=iris(1:150,1:4)