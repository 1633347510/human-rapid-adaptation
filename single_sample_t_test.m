%single sample t-test
clc
clear 
%%collect data

%%figure 3/model (supervised and self-supervised) vs human (with supervision)
%%statistic analysis

clc
close all
clear

path_src= %your path
 
 path1=[path_src,'\Human listeners\without feedback\'];
 path2=[path_src,'\Human listeners\with feedback\'];
 path3=[path_src,'\Model\self-supervised\'];
 path4=[path_src,'\Model\supervised\'];
 
  
 cd(path1)
 file1=dir('*.mat');
 
 cd(path2)
 file2=dir('*.mat');
 
 cd(path3)
 file3=dir('*.mat');
 
  cd(path4)
 file4=dir('*.mat');
 
  for a1=1:6 %:length(file1)
 
     
     data1=load([path1,file1(a1,1).name]);
     data1=data1.data5;
    
     data2=load([path2,file2(a1,1).name]);
     data2=data2.data5;
     
     data3=load([path3,file3(a1,1).name]);
     data3=data3.data4;
     data3=mean(data3);
    
     data4=load([path4,file4(a1,1).name]);
     data4=data4.data4;
     data4=mean(data4);
     
     for a2=11: 30 % from 1st to 20th(for degraded speeches)
         
         %%single-sample t-test
         
          [h_tar(a1,a2),p_tar(a1,a2),ci4,stats4]=ttest(data1(:,a2),data3(a2));
         
     
     end
          
     %FDR corrected
     [~,~,~,p_adj(a1,:)]=fdr_bh(p_tar(a1,11:end));
        
     
 
  end
  
  for a3=1:6
     for a4=1:20
         if p_adj(a3,a4)<0.05
             
             h_adj(a3,a4)=1;
         end
         
     end
      
  end
  
 