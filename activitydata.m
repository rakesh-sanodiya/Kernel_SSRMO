load('activity.csv')
rp = randperm(100);
%%task-1
  X1=activity(1:50,1:561)
  L1=activity(1:50,562)
  UX2=activity(51:100,1:561)
  UL2=activity(51:100,562)
 
  X3=activity(501:550,1:561)
  L3=activity(501:550,562)
  UX4=activity(551:600,1:561)
  UL4=activity(551:600,562)
 
  
   
   Task_data_1=[X1;X3]
   Task_data_1=Task_data_1(rp, :)
  
   Task_label_1=[L1;L3]
   Task_label_1=Task_label_1(rp, :)
   
   
   Task_u_data_1=[UX2;UX4]
   Task_u_data_1=Task_u_data_1(rp, :)
  
   Task_u_label_1=[UL2;UL4]
   Task_u_label_1=Task_label_1(rp, :)
   
   
   traindata={Task_data_1;Task_data_1;Task_data_1}
   trainlabel={Task_label_1;Task_label_1;Task_label_1}
    
   uldata={Task_u_data_1;Task_u_data_1;Task_u_data_1}
   ullabel={Task_u_label_1;Task_u_label_1;Task_u_label_1}
   
   
   
   %task 2
   
   
   
   
  X1=activity(1:50,1:561)
  L1=activity(1:50,562)
  UX2=activity(51:100,1:561)
  UL2=activity(51:100,562)
 
  X3=activity(501:550,1:561)
  L3=activity(501:550,562)
  UX4=activity(551:600,1:561)
  UL4=activity(551:600,562)
 
   
   
   Task_data_1=[X1;X3]
   Task_data_1=Task_data_1(rp, :)
  
   Task_label_1=[L1;L3]
   Task_label_1=Task_label_1(rp, :)
   
   
   Task_u_data_1=[UX2;UX4]
   Task_u_data_1=Task_u_data_1(rp, :)
  
   Task_u_label_1=[UL1;UL3]
   Task_u_label_1=Task_label_1(rp, :)
   
   
   
   
   
  
  X5=activity(2201:2350,1:561)
  L5=activity(2201:2350,562)
  UX6=activity(2351:2500,1:561)
  UL6=activity(2351:2500,562)
    
  X7=activity(3001:3150,1:561)
  L7=activity(3001:3150,562)
  UX8=activity(3151:3300,1:561)
  UL8=activity(3151:3300,562)
  
    X9=activity(3601:3750,1:561)
  L9=activity(3601:3750,562)
  UX10=activity(3751:3900,1:561)
  UL10=activity(3751:3900,562)
    
    
  X11=activity(4251:4400,1:561)
  L11=activity(4251:4400,562)
  UX12=activity(4401:4550,1:561)
  UL12=activity(4401:4550,562)
 
  
  
   X13=activity(4801:4950,1:561)
  L13=activity(4801:4950,562)
  UX14=activity(4951:5100,1:561)
  UL14=activity(4951:5100,562)
    
    
  X15=activity(5501:5650,1:561)
  L15=activity(5501:5650,562)
  UX16=activity(5651:5800,1:561)
  UL16=activity(5651:5800,562)
   
  
 
  
    
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