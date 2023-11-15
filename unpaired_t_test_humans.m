clear 
clc
close all

 path_src= %'your path'
 
 path1=[path_src,'\Human listeners\without feedback\'];
 path2=[path_src,'\Human listeners\with feedback\'];
 
 

cd(path1)
file1=dir('*.mat*');

cd(path2)
file2=dir('*.mat*');

h_adj=zeros(6,20);
for a1=3 %1:length(file1)
    clear data1 data2
    %%from 1st to 20th
    data1=load([path1,'\',file1(a1,1).name]);
    data2=load([path2,'\',file2(a1,1).name]);
    disp([path2,'\',file2(a1,1).name])

    data1=data1.data5;   %human listener
    data2=data2.data5;
    
    for a2=1:20
          %%from 1st to 20th
          
          da1=data1(:,a2+10);
          da2=data2(:,a2+10);
          
%         Homogeneity of variance
         vart=vartestn([da1,da2]); % vart < 0.05; violate the equal variance assumption
    
          if vart <0.05
         [h_tar(a1,a2),p_tar(a1,a2),ci4,stats4]=ttest2(da1,da2,'Vartype','unequal');
         
     else 
         [h_tar(a1,a2),p_tar(a1,a2),ci4,stats4]=ttest2(da1,da2);
        
          end
          
             
    end
    
    
       %FDR corrected
         [~,~,~,p_adj(a1,:)]=fdr_bh(p_tar(a1,:));
     
        [in1,in2]=find(p_adj(a1,:)<0.05);
        
        h_adj(a1,in2)=1;
    
   
 
end