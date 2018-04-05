for r = 1:30
  fileID = fopen('Multi_IRIS.csv','w'); 
    l=population(1:4,4)
    ch1=int2str(l(1,1))
    ch2=int2str(l(2,1))
    ch3=int2str(l(3,1))
    ch4=int2str(l(4,1))
    
    Can2='Cons_k_L_iris';
    Can3=strcat(Can2,ch1)
    Can=strcat(Can3,'.csv')
    chromosom1=csvread(Can);
    Can3=strcat(Can2,ch2)
    Can=strcat(Can3,'.csv')
    chromosom2=csvread(Can);
    Can3=strcat(Can2,ch3)
    Can=strcat(Can3,'.csv')
    chromosom3=csvread(Can);
    Can3=strcat(Can2,ch4)
    Can=strcat(Can3,'.csv')
    chromosom4=csvread(Can);
    
    A=0.5
    r1 = rand(1,1)
    r0=8
    if (r1<A)
        r0 = randi([1,7],1)
    end
    
    nchild1=[chromosom1(1:17,:);chromosom2(18:35,:)]
     if (r0==1)
        id1 = find(labels == 1); l1 = length(id1);
        repl= id1(randi(l1,5,1))
        nchild1(1:5,1)=repl
         
     end
        K0 = gaussKernel(X,100);
        K = bregmanProj(K0,nchild1,equality,10,1);
        idx_multi1 = perfkkmeans(K,3,200);
        
        dtype=1;
        [DB, CH, Dunn, KL, Ha] = ...
        valid_internal_deviation(X,idx_multi(:,1), dtype);

% computing R-Squared

           if dtype == 1
             [St,Sw,Sb] = valid_sumsqures(X,idx_multi(:,1),1+1);
           else
             [St,Sw,Sb] = valid_sumpearson(X,idx_multi(:,1),1+1);
           end
           sst = trace(St);
           ssb = trace(Sb);
           RS = ssb/sst;

            %silhouette Score
             R = 'euclidean';
            SS = mean(silhouette(X, idx_multi, R))
            [CA,RI,AR,HI,MI,Jac,FM] = compute_clustering_performance(idx_multi1,labels);
            rank=1
            
            population_init=[centers rank HI MI Jac FM SS DB CH Dunn KL Ha RS CA RI AR ];
nbytes = fprintf(fileID,'%5d %5d %5d %d %f %f %f %f %f %f %f %f %f %f %f %f %f %f\n',population_init);

            Cann1=int2str(rank);
            Cann2='Cons_K_L_iris';
            Cann3=strcat(Cann2,Cann1)
            Cann=strcat(Cann3,'.csv')

            csvwrite(Cann,nchild1)
            
             Cann1=int2str(rank);
            Cann2='labeld_iris';
            Cann3=strcat(Cann2,Cann1)
            Cann=strcat(Cann3,'.csv')

            csvwrite(Cann,idx_multi1)
            
           % fclose(fileID);
           
    
          
   nchild2=[chromosom2(1:17,:);chromosom1(18:35,:)]
   if (r0==2)
        id1 = find(labels == 1); l1 = length(id1);
        repl= id1(randi(l1,5,1))
        nchild2(1:5,1)=repl
         
     end
        K0 = gaussKernel(X,100);
        K = bregmanProj(K0,nchild2,equality,10,1);
        idx_multi1 = perfkkmeans(K,3,200);
        dtype=1;
        [DB, CH, Dunn, KL, Ha] = ...
        valid_internal_deviation(X,idx_multi(:,1), dtype);

% computing R-Squared

           if dtype == 1
             [St,Sw,Sb] = valid_sumsqures(X,idx_multi(:,1),1+1);
           else
             [St,Sw,Sb] = valid_sumpearson(X,idx_multi(:,1),1+1);
           end
           sst = trace(St);
           ssb = trace(Sb);
           RS = ssb/sst;

            %silhouette Score
             R = 'euclidean';
            SS = mean(silhouette(X, idx_multi, R))
            [CA,RI,AR,HI,MI,Jac,FM] = compute_clustering_performance(idx_multi1,labels);
            rank=2
            
           population_init=[centers rank HI MI Jac FM SS DB CH Dunn KL Ha RS CA RI AR ];
nbytes = fprintf(fileID,'%5d %5d %5d %d %f %f %f %f %f %f %f %f %f %f %f %f %f %f\n',population_init);

            Cann1=int2str(rank);
            Cann2='Cons_K_L_iris';
            Cann3=strcat(Cann2,Cann1)
            Cann=strcat(Cann3,'.csv')

            csvwrite(Cann,nchild2)
             Cann1=int2str(rank);
            Cann2='labeld_iris';
            Cann3=strcat(Cann2,Cann1)
            Cann=strcat(Cann3,'.csv')

            csvwrite(Cann,idx_multi1)
   
            
            
            
   nchild3=[chromosom1(1:17,:);chromosom3(18:35,:)]
   
   if (r0==3)
        id1 = find(labels == 1); l1 = length(id1);
        repl= id1(randi(l1,5,1))
        nchild3(1:5,1)=repl
         
     end
        K0 = gaussKernel(X,100);
        K = bregmanProj(K0,nchild3,equality,10,1);
        idx_multi1 = perfkkmeans(K,3,200);
        dtype=1;
        [DB, CH, Dunn, KL, Ha] = ...
        valid_internal_deviation(X,idx_multi(:,1), dtype);

% computing R-Squared

           if dtype == 1
             [St,Sw,Sb] = valid_sumsqures(X,idx_multi(:,1),1+1);
           else
             [St,Sw,Sb] = valid_sumpearson(X,idx_multi(:,1),1+1);
           end
           sst = trace(St);
           ssb = trace(Sb);
           RS = ssb/sst;

            %silhouette Score
             R = 'euclidean';
            SS = mean(silhouette(X, idx_multi, R))
            [CA,RI,AR,HI,MI,Jac,FM] = compute_clustering_performance(idx_multi1,labels);
            rank=3
           
                  population_init=[centers rank HI MI Jac FM SS DB CH Dunn KL Ha RS CA RI AR ];
nbytes = fprintf(fileID,'%5d %5d %5d %d %f %f %f %f %f %f %f %f %f %f %f %f %f %f\n',population_init);

            Cann1=int2str(rank);
            Cann2='Cons_K_L_iris';
            Cann3=strcat(Cann2,Cann1)
            Cann=strcat(Cann3,'.csv')

            csvwrite(Cann,nchild3)
            Cann1=int2str(rank);
            Cann2='labeld_iris';
            Cann3=strcat(Cann2,Cann1)
            Cann=strcat(Cann3,'.csv')

            csvwrite(Cann,idx_multi1)
            
            
    nchild4=[chromosom3(1:17,:);chromosom1(18:35,:)]
    if (r0==4)
        id1 = find(labels == 2); l1 = length(id1);
        repl= id1(randi(l1,5,1))
        nchild4(1:5,1)=repl
         
     end
        K0 = gaussKernel(X,100);
        K = bregmanProj(K0,nchild4,equality,10,1);
        idx_multi1 = perfkkmeans(K,3,200);
        dtype=1;
        [DB, CH, Dunn, KL, Ha] = ...
        valid_internal_deviation(X,idx_multi(:,1), dtype);

% computing R-Squared

           if dtype == 1
             [St,Sw,Sb] = valid_sumsqures(X,idx_multi(:,1),1+1);
           else
             [St,Sw,Sb] = valid_sumpearson(X,idx_multi(:,1),1+1);
           end
           sst = trace(St);
           ssb = trace(Sb);
           RS = ssb/sst;

            %silhouette Score
             R = 'euclidean';
            SS = mean(silhouette(X, idx_multi, R))
            [CA,RI,AR,HI,MI,Jac,FM] = compute_clustering_performance(idx_multi1,labels);
            rank=4
            
                  population_init=[centers rank HI MI Jac FM SS DB CH Dunn KL Ha RS CA RI AR ];
nbytes = fprintf(fileID,'%5d %5d %5d %d %f %f %f %f %f %f %f %f %f %f %f %f %f %f\n',population_init);
 
            Cann1=int2str(rank);
            Cann2='Cons_K_L_iris';
            Cann3=strcat(Cann2,Cann1)
            Cann=strcat(Cann3,'.csv')

            csvwrite(Cann,nchild4)
            Cann1=int2str(rank);
            Cann2='labeld_iris';
            Cann3=strcat(Cann2,Cann1)
            Cann=strcat(Cann3,'.csv')

            csvwrite(Cann,idx_multi1)
            
            
   
    nchild5=[chromosom1(1:17,:);chromosom4(18:35,:)]
    if (r0==5)
        id1 = find(labels == 3); l1 = length(id1);
        repl= id1(randi(l1,5,1))
        nchild5(1:5,1)=repl
         
     end
        K0 = gaussKernel(X,100);
        K = bregmanProj(K0,nchild5,equality,10,1);
        idx_multi1 = perfkkmeans(K,3,200);
        dtype=1;
        [DB, CH, Dunn, KL, Ha] = ...
        valid_internal_deviation(X,idx_multi(:,1), dtype);

% computing R-Squared

           if dtype == 1
             [St,Sw,Sb] = valid_sumsqures(X,idx_multi(:,1),1+1);
           else
             [St,Sw,Sb] = valid_sumpearson(X,idx_multi(:,1),1+1);
           end
           sst = trace(St);
           ssb = trace(Sb);
           RS = ssb/sst;

            %silhouette Score
             R = 'euclidean';
            SS = mean(silhouette(X, idx_multi, R))
            [CA,RI,AR,HI,MI,Jac,FM] = compute_clustering_performance(idx_multi1,labels);
            rank=5
                   population_init=[centers rank HI MI Jac FM SS DB CH Dunn KL Ha RS CA RI AR ];
nbytes = fprintf(fileID,'%5d %5d %5d %d %f %f %f %f %f %f %f %f %f %f %f %f %f %f\n',population_init);

            Cann1=int2str(rank);
            Cann2='Cons_K_L_iris';
            Cann3=strcat(Cann2,Cann1)
            Cann=strcat(Cann3,'.csv')

            csvwrite(Cann,nchild5)
            Cann1=int2str(rank);
            Cann2='labeld_iris';
            Cann3=strcat(Cann2,Cann1)
            Cann=strcat(Cann3,'.csv')

            csvwrite(Cann,idx_multi1)
            
            
        
    nchild6=[chromosom4(1:17,:);chromosom1(18:35,:)]
    if (r0==6)
        id1 = find(labels == 3); l1 = length(id1);
        repl= id1(randi(l1,5,1))
        nchild6(1:5,1)=repl
         
     end
        K0 = gaussKernel(X,100);
        K = bregmanProj(K0,nchild6,equality,10,1);
        idx_multi1 = perfkkmeans(K,3,200);
        dtype=1;
        [DB, CH, Dunn, KL, Ha] = ...
        valid_internal_deviation(X,idx_multi(:,1), dtype);

% computing R-Squared

           if dtype == 1
             [St,Sw,Sb] = valid_sumsqures(X,idx_multi(:,1),1+1);
           else
             [St,Sw,Sb] = valid_sumpearson(X,idx_multi(:,1),1+1);
           end
           sst = trace(St);
           ssb = trace(Sb);
           RS = ssb/sst;

            %silhouette Score
             R = 'euclidean';
            SS = mean(silhouette(X, idx_multi, R))
            [CA,RI,AR,HI,MI,Jac,FM] = compute_clustering_performance(idx_multi1,labels);
            rank=6
                    population_init=[centers rank HI MI Jac FM SS DB CH Dunn KL Ha RS CA RI AR ];
nbytes = fprintf(fileID,'%5d %5d %5d %d %f %f %f %f %f %f %f %f %f %f %f %f %f %f\n',population_init);

            Cann1=int2str(rank);
            Cann2='Cons_K_L_iris';
            Cann3=strcat(Cann2,Cann1)
            Cann=strcat(Cann3,'.csv')

            csvwrite(Cann,nchild6)
             Cann1=int2str(rank);
            Cann2='labeld_iris';
            Cann3=strcat(Cann2,Cann1)
            Cann=strcat(Cann3,'.csv')

            csvwrite(Cann,idx_multi1)
   
            
            fclose(fileID);
File = csvread('K_M_S_IRIS.csv');

[population front]=NDS_CD_cons(File);

csvwrite('Multi_M_S_IRIS.csv',population)
   
end