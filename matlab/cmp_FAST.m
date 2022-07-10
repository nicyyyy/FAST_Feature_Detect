% fipx=fopen('D:\1_my_verilog\FAST\sim\x.bin','r');
% [mx,numx]=fscanf(fipx,'%03x',[1 inf]);
% 
% fipy=fopen('D:\1_my_verilog\FAST\sim\y.bin','r');
% [my,numy]=fscanf(fipy,'%03x',[1 inf]);

fips=fopen('E:\my_verilog\AXI\FAST\FAST\score.bin','r');
[ms,numy]=fscanf(fips,'%02x',[720 inf]);
[mx,my,v] = find(ms ~= 0);



%%
%matlab计算
fip=fopen('E:\my_verilog\prev.bin','rb');
[prev,num]=fread(fip,[720 1280],'uint8');%inf表示读取文件中的所有数据，[M,N]表
[m n]=size(prev);
score=zeros(m,n);

t=60;   %阈值
flag = zeros(1,16);
for j=4:n-3
    for i=4:m-3
        p=prev(i,j);    
        %步骤1，得到以p为中心的16个邻域点
        pn=[prev(i-3,j) prev(i-3,j+1) prev(i-2,j+2) prev(i-1,j+3) prev(i,j+3) prev(i+1,j+3) prev(i+2,j+2) prev(i+3,j+1) ...
            prev(i+3,j) prev(i+3,j-1) prev(i+2,j-2) prev(i+1,j-3) prev(i,j-3) prev(i-1,j-3) prev(i-2,j-2) prev(i-3,j-1)];
   
        %步骤2
        if abs(pn(1)-p) >=t || abs(pn(9)-p) >= t
            %步骤3     
        p1_5_9_13=[abs(pn(1)-p)>=t abs(pn(5)-p)>=t abs(pn(9)-p)>=t abs(pn(13)-p)>=t];
        if sum(p1_5_9_13)>=3
            ind=find(abs(pn-p)>=t);
            %步骤4         
            if length(ind)>=9
                score(i,j) = sum(abs(pn-p));      
            end
        end
        end
        
       end
end

%步骤5，非极大抑制，并且画出特征点
x=[];
y=[];
for i=4:m-3
    for j=4:n-3
        if score(i,j)~=0
            if max(max(score(i-1:i+1,j-1:j+1)))==score(i,j)               
                x = [x,i];
                y = [y,j];
            end
        end
    end
end
%%
corners1=detectFASTFeatures(uint8(prev),'MinContrast',60/255);
y = corners1.Location(:,1);
x = corners1.Location(:,2);
%%
figure(1);
imshow(uint8(prev));
hold on;
scatter(y,x,10,'rd','filled','MarkerFaceAlpha',1)
hold on
scatter(my,mx,40,'b','filled','MarkerFaceAlpha',0.25)

%%
%对比score
fips2=fopen('E:\my_verilog\FAST\score.bin','r');
[ms2,numy]=fscanf(fips2,'%03x',[720 inf]);
% [my,mx,v] = find(ms2 ~= 0);
% dfs = abs(ms - score);
% dfs = dfs(4:end - 3,4:end - 3);
% max(max(dfs))
