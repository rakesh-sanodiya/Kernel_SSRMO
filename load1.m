%loading dataset

%% load dataset
    
    load('iris_y')
    load('iris_X')
    X=iris_X
    y=iris_y
    l1=y(1:5,1)
 l2=y(6:10,1)
 l3=y(11:15,1)
 
 X1=X(1:5,1:4)
 X2=X(6:10,1:4)
 X3=X(11:15,1:4)
    
    
    traindata={X1;X2;X3;X2;X3}
    trainlabel={l1;l2;l3;l2;l3}
    
    uldata={X1;X2;X3;X2;X3}
    ullabel={l1;l2;l3;l2;l3}
    
    
    traindata={X1}
    trainlabel={l1}
    
    uldata={X1}
    ullabel={l1}
 
  load('usps_digit1.txt')

  X1=usps_digit1(1:150,2:256)
  L1=usps_digit1(1:150,1)
  UX2=usps_digit1(151:300,2:256)
  UL2=usps_digit1(151:300,1)
 
  X3=usps_digit1(1201:1350,2:256)
  L3=usps_digit1(1201:1350,1)
  UX4=usps_digit1(1351:1500,2:256)
  UL4=usps_digit1(1351:1500,1)
 
  X5=usps_digit1(2201:2350,2:256)
  L5=usps_digit1(2201:2350,1)
  UX6=usps_digit1(2351:2500,2:256)
  UL6=usps_digit1(2351:2500,1)
    
  X7=usps_digit1(3001:3150,2:256)
  L7=usps_digit1(3001:3150,1)
  UX8=usps_digit1(3151:3300,2:256)
  UL8=usps_digit1(3151:3300,1)
  
    X9=usps_digit1(3601:3750,2:256)
  L9=usps_digit1(3601:3750,1)
  UX10=usps_digit1(3751:3900,2:256)
  UL10=usps_digit1(3751:3900,1)
    
    
  X11=usps_digit1(4251:4400,2:256)
  L11=usps_digit1(4251:4400,1)
  UX12=usps_digit1(4401:4550,2:256)
  UL12=usps_digit1(4401:4550,1)
 
  
  
   X13=usps_digit1(4801:4950,2:256)
  L13=usps_digit1(4801:4950,1)
  UX14=usps_digit1(4951:5100,2:256)
  UL14=usps_digit1(4951:5100,1)
    
    
  X15=usps_digit1(5501:5650,2:256)
  L15=usps_digit1(5501:5650,1)
  UX16=usps_digit1(5651:5800,2:256)
  UL16=usps_digit1(5651:5800,1)
   
  
 
   rp = randperm(300);
   
   TX1=[X1;X3]
   TX1=TX1(rp, :)
    
   TX2=[X5;X7]
   TX2=TX2(rp, :)
   
   TX3=[X9;X11]
   TX3=TX3(rp, :)
   
   TX4=[X13;X15]
   TX4=TX4(rp, :)
   
   TL1=[L1;L3]
   TL1=TL1(rp, :)
    
   TL2=[L5;L7]
   TL2=TL2(rp, :)
   
   TL3=[L9;L11]
   TL3=TL3(rp, :)
    
   TL4=[L13;L15]
   TL4=TL4(rp, :)
   
   
   TUX1=[UX2;UX4]
   TUX1=TUX1(rp, :)
    
   TUX2=[UX6;UX8]
   TUX2=TUX2(rp, :)
   
   TUX3=[UX10;UX12]
   TUX3=TUX3(rp, :)
    
   TUX4=[UX14;UX16]
   TUX4=TUX4(rp, :)
   
   TUL1=[UL2;UL4]
   TUL1=TUL1(rp, :)
    
   TUL2=[UL6;UL8]
   TUL2=TUL2(rp, :)
   
   TUL3=[UL10;UL12]
   TUL3=TUL3(rp, :)
    
   TUL4=[UL14;UL16]
   TUL4=TUL4(rp, :)
   
   traindata={TX1;TX2;TX3;}
   trainlabel={TL1;TL2;TL2}
    
   uldata={TUX1;TUX2;TUX3}
   ullabel={TUL1;TUL2;TUL3}
   
   
   traindata={TX1;TX1}
   trainlabel={TL1;TL1}
    
   uldata={TUX1;TUX1}
   ullabel={TUL1;TUL1}
   
   
   
  load('usps_digit1.txt')

  X1=usps_digit1(1:20,2:256)
  L1=usps_digit1(1:20,1)
  UX2=usps_digit1(151:170,2:256)
  UL2=usps_digit1(151:170,1)
 
  X3=usps_digit1(1201:1220,2:256)
  L3=usps_digit1(1201:1220,1)
  UX4=usps_digit1(1351:1370,2:256)
  UL4=usps_digit1(1351:1370,1)
 
  X5=usps_digit1(2201:2220,2:256)
  L5=usps_digit1(2201:2220,1)
  UX6=usps_digit1(2351:2370,2:256)
  UL6=usps_digit1(2351:2370,1)
    
  X7=usps_digit1(3001:3020,2:256)
  L7=usps_digit1(3001:3020,1)
  UX8=usps_digit1(3151:3170,2:256)
  UL8=usps_digit1(3151:3170,1)
  
    X9=usps_digit1(3601:3750,2:256)
  L9=usps_digit1(3601:3750,1)
  UX10=usps_digit1(3751:3900,2:256)
  UL10=usps_digit1(3751:3900,1)
    
    
  X11=usps_digit1(4251:4400,2:256)
  L11=usps_digit1(4251:4400,1)
  UX12=usps_digit1(4401:4550,2:256)
  UL12=usps_digit1(4401:4550,1)
 
  
  
   X13=usps_digit1(4801:4950,2:256)
  L13=usps_digit1(4801:4950,1)
  UX14=usps_digit1(4951:5100,2:256)
  UL14=usps_digit1(4951:5100,1)
    
    
  X15=usps_digit1(5501:5650,2:256)
  L15=usps_digit1(5501:5650,1)
  UX16=usps_digit1(5651:5800,2:256)
  UL16=usps_digit1(5651:5800,1)
   
  
 
   rp = randperm(40);
   
   TX1=[X1;X3]
   TX1=TX1(rp, :)
    
   TX2=[X5;X7]
   TX2=TX2(rp, :)
   
   TX3=[X9;X11]
   TX3=TX3(rp, :)
   
   TX4=[X13;X15]
   TX4=TX4(rp, :)
   
   TL1=[L1;L3]
   TL1=TL1(rp, :)
    
   TL2=[L5;L7]
   TL2=TL2(rp, :)
   
   TL3=[L9;L11]
   TL3=TL3(rp, :)
    
   TL4=[L13;L15]
   TL4=TL4(rp, :)
   
   
   TUX1=[UX2;UX4]
   TUX1=TUX1(rp, :)
    
   TUX2=[UX6;UX8]
   TUX2=TUX2(rp, :)
   
   TUX3=[UX10;UX12]
   TUX3=TUX3(rp, :)
    
   TUX4=[UX14;UX16]
   TUX4=TUX4(rp, :)
   
   TUL1=[UL2;UL4]
   TUL1=TUL1(rp, :)
    
   TUL2=[UL6;UL8]
   TUL2=TUL2(rp, :)
   
   TUL3=[UL10;UL12]
   TUL3=TUL3(rp, :)
    
   TUL4=[UL14;UL16]
   TUL4=TUL4(rp, :)
   
   traindata={TX1;TX1}
   trainlabel={TL1;TL1}
    
   uldata={TUX1;TUX1}
   ullabel={TUL1;TUL1}
   
   
   traindata={TX1}
   trainlabel={TL1}
    
   uldata={TUX1}
   ullabel={TUL1}
   
   
   
   
   
data=subdata,n=length(index1),theta=theta(:,i),train_Km=original_Km(:,1:length(index1)),testdata=uldata(index2,:),testlabel=ullabel(index2)
 
 traindata=traindata(index,:), theta=theta(:,i),testdata=uldata{i},testlabel=ullabel{i}
 
 %data_index=cell(1,139);
 
    data_index=cell(1,4);
      for i=2:5
          last=tr_indexes(i)
          last=last-1
          first=tr_indexes(i-1)
      
          data_index{i-1}=x(tr(first:last),1:28)
          
%         index=find(train_task_index==i);
%         ln_theta(parameter_dim,i)=log(mean(pdist(traindata(index,:))));
%         clear index;
    end
     label_index=cell(1,4);
      for i=2:5
          last=tr_indexes(i)
          last=last-1
          first=tr_indexes(i-1)
       
          label_index{i-1}=y(tr(first:last),1)
          
%         index=find(train_task_index==i);
%         ln_theta(parameter_dim,i)=log(mean(pdist(traindata(index,:))));
%         clear index;
      end
    
    
    
      
        data_test_index=cell(1,4);
      for i=2:5
          last=tst_indexes(i)
          last=last-1
          first=tst_indexes(i-1)
      
          data_test_index{i-1}=x(tst(first:last),1:28)
          
%         index=find(train_task_index==i);
%         ln_theta(parameter_dim,i)=log(mean(pdist(traindata(index,:))));
%         clear index;
    end
     label_test_index=cell(1,4);
      for i=2:5
          last=tst_indexes(i)
          last=last-1
          first=tst_indexes(i-1)
       
          label_test_index{i-1}=y(tst(first:last),1)
          
%         index=find(train_task_index==i);
%         ln_theta(parameter_dim,i)=log(mean(pdist(traindata(index,:))));
%         clear index;
    end
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
load('iris.txt')
 labels=iris(1:150,5)
 l1=[iris(1:20,5);iris(51:70,5);iris(101:120,5)]
 l2=[iris(21:40,5);iris(71:90,5);iris(121:140,5)]
 l3=[iris(41:50,5);iris(91:100,5);iris(141:150,5)]
 
%  l12=iris(1:10,5)
%  l22=iris(51:60,5)
%  l32=iris(101:110,5)
%  lx=[l12;l22;l32]
 
 l=labels
            X=iris(1:150,1:4)
            X1=[iris(1:20,1:4);iris(51:70,1:4);iris(101:120,1:4)]
 X2=[iris(21:40,1:4);iris(71:90,1:4);iris(121:140,1:4)]
 X3=[iris(41:50,1:4);iris(91:100,1:4);iris(141:150,1:4)]
   
 traindata={X1;X2}
 trainlabel={l1;l2}