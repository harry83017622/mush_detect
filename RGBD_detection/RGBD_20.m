close all;
clear
dir='D:\pointcloud_Jan07\';
Date='2020_1_9_';
time='17_22';
while(1)
%     tic;
%     index=11;
%     file_name=strcat(dir,Date,time);
%     load(strcat(file_name,'\ptcloud',num2str(index),'.mat'));
%     load(strcat(file_name,'\color',num2str(index),'.mat'));
    for index=1:21
        
        file_name=strcat(dir,Date,time);
        load(strcat(file_name,'\ptcloud',num2str(index),'.mat'));
        load(strcat(file_name,'\color',num2str(index),'.mat'));
        
        %pcshow(ptcloud2)
        if index~=11
            load(strcat(dir,'tform',num2str(index),'_11.mat'));
            load(strcat(dir,'tform',num2str(index),'_icp.mat'));
        end
        if index==1
            ptcloud_tform = pctransform(ptcloud1,tform1_11);
%             [icp1,x,rmse1] = pcregistericp(ptcloud_tform,ptcloud11);
            ptcloud_tform1 = pctransform(ptcloud_tform,tform1_icp);
        elseif index==2
            ptcloud_tform = pctransform(ptcloud2,tform2_11);
           % [icp2,x,rmse2] = pcregistericp(ptcloud_tform,ptcloud11);
            ptcloud_tform2 = pctransform(ptcloud_tform,tform2_icp);
        elseif index==3
            ptcloud_tform = pctransform(ptcloud3,tform3_11);
           % [icp3,x,rmse3] = pcregistericp(ptcloud_tform,ptcloud11);
            ptcloud_tform3 = pctransform(ptcloud_tform,tform3_icp);
        elseif index==4
            ptcloud_tform = pctransform(ptcloud4,tform4_11);
           % [icp4,x,rmse4] = pcregistericp(ptcloud_tform,ptcloud11);
            ptcloud_tform4 = pctransform(ptcloud_tform,tform4_icp);
        elseif index==5
            ptcloud_tform = pctransform(ptcloud5,tform5_11);
           % [icp5,x,rmse5] = pcregistericp(ptcloud_tform,ptcloud11);
            ptcloud_tform5 = pctransform(ptcloud_tform,tform5_icp);
        elseif index==6
            ptcloud_tform = pctransform(ptcloud6,tform6_11);
           % [icp6,x,rmse6] = pcregistericp(ptcloud_tform,ptcloud11);
            ptcloud_tform6 = pctransform(ptcloud_tform,tform6_icp);
        elseif index==7
            ptcloud_tform = pctransform(ptcloud7,tform7_11);
          %  [icp7,x,rmse7] = pcregistericp(ptcloud_tform,ptcloud11);
            ptcloud_tform7 = pctransform(ptcloud_tform,tform7_icp);
        elseif index==8
            ptcloud_tform = pctransform(ptcloud8,tform8_11);
         %   [icp8,x,rmse8] = pcregistericp(ptcloud_tform,ptcloud11);
            ptcloud_tform8 = pctransform(ptcloud_tform,tform8_icp);
        elseif index==9
            ptcloud_tform = pctransform(ptcloud9,tform9_11);
          %  [icp9,x,rmse9] = pcregistericp(ptcloud_tform,ptcloud11);
            ptcloud_tform9 = pctransform(ptcloud_tform,tform9_icp);
        elseif index==10
            ptcloud_tform = pctransform(ptcloud10,tform10_11);
          %  [icp10,x,rmse10] = pcregistericp(ptcloud_tform,ptcloud11);
            ptcloud_tform10 = pctransform(ptcloud_tform,tform10_icp);
        elseif index==12
            ptcloud_tform = pctransform(ptcloud12,tform12_11);
          %  [icp12,x,rmse12] = pcregistericp(ptcloud_tform,ptcloud11);
            ptcloud_tform12 = pctransform(ptcloud_tform,tform12_icp);
        elseif index==13
            ptcloud_tform = pctransform(ptcloud13,tform13_11);
          %  [icp13,x,rmse13] = pcregistericp(ptcloud_tform,ptcloud11);
            ptcloud_tform13 = pctransform(ptcloud_tform,tform13_icp);            
        elseif index==14
            ptcloud_tform = pctransform(ptcloud14,tform14_11);
          %  [icp14,x,rmse14] = pcregistericp(ptcloud_tform,ptcloud11);
            ptcloud_tform14 = pctransform(ptcloud_tform,tform14_icp);            
        elseif index==15
            ptcloud_tform = pctransform(ptcloud15,tform15_11);
           % [icp15,x,rmse15] = pcregistericp(ptcloud_tform,ptcloud11);
            ptcloud_tform15 = pctransform(ptcloud_tform,tform15_icp);            
        elseif index==16
            ptcloud_tform = pctransform(ptcloud16,tform16_11);
          %  [icp16,x,rmse16] = pcregistericp(ptcloud_tform,ptcloud11);
            ptcloud_tform16 = pctransform(ptcloud_tform,tform16_icp);
        elseif index==17
            ptcloud_tform = pctransform(ptcloud17,tform17_11);
           % [icp17,x,rmse17] = pcregistericp(ptcloud_tform,ptcloud11);
            ptcloud_tform17 = pctransform(ptcloud_tform,tform17_icp);
        elseif index==18
            ptcloud_tform = pctransform(ptcloud18,tform18_11);
           % [icp18,x,rmse18] = pcregistericp(ptcloud_tform,ptcloud11);
            ptcloud_tform18 = pctransform(ptcloud_tform,tform18_icp);            
        elseif index==19
            ptcloud_tform = pctransform(ptcloud19,tform19_11);
          %  [icp19,x,rmse19] = pcregistericp(ptcloud_tform,ptcloud11);
            ptcloud_tform19 = pctransform(ptcloud_tform,tform19_icp);            
        elseif index==20
            ptcloud_tform = pctransform(ptcloud20,tform20_11);
%            [icp20,x,rmse20] = pcregistericp(ptcloud_tform,ptcloud11);
            ptcloud_tform20 = pctransform(ptcloud_tform,tform20_icp);
        elseif index==21
            ptcloud_tform = pctransform(ptcloud21,tform21_11);
          %  [icp21,x,rmse21] = pcregistericp(ptcloud_tform,ptcloud11);
            ptcloud_tform21 = pctransform(ptcloud_tform,tform21_icp);            
            %pcshow(ptcloud_tform1)
            % ptcloud_tform=ptcloud4;
        end
    end
%     toc;
    %%
    ptc1=ptcloud_tform1.Location;
    ptc_color1=ptcloud_tform1.Color;
    ptc2=ptcloud_tform2.Location;
    ptc_color2=ptcloud_tform2.Color;
    ptc3=ptcloud_tform3.Location;
    ptc_color3=ptcloud_tform3.Color;
    ptc4=ptcloud_tform4.Location;
    ptc_color4=ptcloud_tform4.Color;
    ptc5=ptcloud_tform5.Location;
    ptc_color5=ptcloud_tform5.Color;
    ptc6=ptcloud_tform6.Location;
    ptc_color6=ptcloud_tform6.Color;
    ptc7=ptcloud_tform7.Location;
    ptc_color7=ptcloud_tform7.Color;
    ptc8=ptcloud_tform8.Location;
    ptc_color8=ptcloud_tform8.Color;
    ptc9=ptcloud_tform9.Location;
    ptc_color9=ptcloud_tform9.Color;
    ptc10=ptcloud_tform10.Location;
    ptc_color10=ptcloud_tform10.Color;
    ptc11=ptcloud11.Location;
    ptc_color11=ptcloud11.Color;
    ptc12=ptcloud_tform12.Location;
    ptc_color12=ptcloud_tform12.Color;
    ptc13=ptcloud_tform13.Location;
    ptc_color13=ptcloud_tform13.Color;
    ptc14=ptcloud_tform14.Location;
    ptc_color14=ptcloud_tform14.Color;
    ptc15=ptcloud_tform15.Location;
    ptc_color15=ptcloud_tform15.Color;
    ptc16=ptcloud_tform16.Location;
    ptc_color16=ptcloud_tform16.Color;
    ptc17=ptcloud_tform17.Location;
    ptc_color17=ptcloud_tform17.Color;
    ptc18=ptcloud_tform18.Location;
    ptc_color18=ptcloud_tform18.Color;
    ptc19=ptcloud_tform19.Location;
    ptc_color19=ptcloud_tform19.Color;
    ptc20=ptcloud_tform20.Location;
    ptc_color20=ptcloud_tform20.Color;
    ptc21=ptcloud_tform21.Location;
    ptc_color21=ptcloud_tform21.Color;
    
    ptc=[ptc1;ptc2;ptc3;ptc4;ptc5;ptc6;ptc7;ptc8;ptc9;ptc10;ptc11;...
      ptc12;ptc13;ptc14;ptc15;ptc16;ptc17;ptc18;ptc19;ptc20;ptc21];
    ptc_color=[ptc_color1;ptc_color2;ptc_color3;ptc_color4;ptc_color5;ptc_color6;ptc_color7;
        ptc_color8;ptc_color9;ptc_color10;ptc_color11;
        ptc_color12;ptc_color13;ptc_color14;ptc_color15;ptc_color16;ptc_color17;ptc_color18;ptc_color19;ptc_color20;ptc_color21];
    
    [row,col]=find(ptc(:,1)>.8);
    ptc(row,:)=[];
    ptc_color(row,:)=[];
    [row,col]=find(ptc(:,1)<-.8);
    ptc(row,:)=[];
    ptc_color(row,:)=[];
    [row,col]=find(ptc(:,2)>.5);
    ptc(row,:)=[];
    ptc_color(row,:)=[];
    [row,col]=find(ptc(:,2)<-.5);
    ptc(row,:)=[];
    ptc_color(row,:)=[];
    
    %     [row,col]=find(ptc_color(:,1)<240);
    %     ptc(row,:)=[];
    %     ptc_color(row,:)=[];
    %     [row,col]=find(ptc_color(:,2)<240);
    %     ptc(row,:)=[];
    %     ptc_color(row,:)=[];
    %     [row,col]=find(ptc_color(:,3)<240);
    %     ptc(row,:)=[];
    %     ptc_color(row,:)=[];
    
    ptcloud_all=pointCloud(ptc,'color',ptc_color);
    %ptcloud_all=pointCloud(ptc);
    [ptcloud_all,indices] = removeInvalidPoints(ptcloud_all);
    figure;pcshow(ptcloud_all)
    xlabel('x')
    ylabel('y')
    zlabel('z')
    
    ptc=ptcloud_all.Location;
    ptc_color=ptcloud_all.Color;
    dpi=sqrt(size(ptc,1)/0.9)*0.0254
    
    %%
    % need to store the range_xy and min_xy information
    range_x=range(ptc(:,1))+0.0001;
    min_x=min(ptc(:,1))-0.0001;
    range_y=range(ptc(:,2))+0.0001;
    min_y=min(ptc(:,2))-0.0001;
    resolution_x=16*80;
    resolution_y=9*80;
    proj_ptc1_cell=cell(resolution_y,resolution_x);
    for i =1:length(ptc)
        y=ceil((ptc(i,2)-min_y)*resolution_y/range_y);
        x=ceil((ptc(i,1)-min_x)*resolution_x/range_x);
        if y>resolution_y
            y=resolution_y;
        end
        if x>resolution_x
            x=resolution_x;
        end
        proj_ptc1_cell{y,x}=...
            [proj_ptc1_cell{y,x},i];
    end
    
    pixels_num=zeros(resolution_x*resolution_y,1);
    for i = 1:resolution_x
        for j=1:resolution_y
            pixels_num((j-1)*resolution_y+i)=length(proj_ptc1_cell{j,i});
        end
    end
    mean(pixels_num)
    std(pixels_num)
    
    proj_ptc=uint16(zeros(resolution_y,resolution_x,3));
    proj_ptc_dep=uint16(zeros(resolution_y,resolution_x,1));
    for i =1:size(proj_ptc,1)
        for j=1:size(proj_ptc,2)
            proj_ptc(i,j,:)=mean(ptc_color(proj_ptc1_cell{i,j},:))*(2^8);
            proj_ptc_dep(i,j)=mean(ptc(proj_ptc1_cell{i,j},3))*(2^16);
        end
    end
%     rgbd=[reshape(proj_ptc,resolution_y,resolution_x*3),proj_ptc_dep];
      rgbd=proj_ptc;
      rgbd(:,:,4)=proj_ptc_dep;
      
    break;
end
figure;imshow(proj_ptc)
figure;imshow(imadjust(proj_ptc_dep,[.76 .9],[]))
%imwrite(proj_ptc,strcat('D:\RGBD_detection\Preprocess\',Date,time,'.png'))
% imwrite(proj_ptc_dep,strcat('D:\RGBD_detection\Image_format\Dep\',Date,time,'.png'))
% imwrite(rgbd,strcat('D:\RGBD_detection\Image_format\RGB-D\',Date,time,'.png'))

% proj_ptc_dep=double(proj_ptc_dep);
% save(strcat('D:\RGBD_detection\Text_format\',Date,time,'.txt'), 'proj_ptc_dep');

%%
rgb=uint8(rgbd(:,:,1:3)./256);
dep=rgbd(:,:,4);
[row,col]=find(rgb(:,:,1)<200);
for i=1:size(row,1)
    rgb(row(i),col(i),:)=0;
    dep(row(i),col(i))=0;
end
[row,col]=find(rgb(:,:,2)<200);
for i=1:size(row,1)
    rgb(row(i),col(i),:)=0;
    dep(row(i),col(i))=0;
end
[row,col]=find(rgb(:,:,3)<200);
for i=1:size(row,1)
    rgb(row(i),col(i),:)=0;
    dep(row(i),col(i))=0;
end
figure;imshow(rgb)
figure;imshow(dep)
%%
% BW = imbinarize(rgb);
% BW=BW(:,:,1);
% cc = bwconncomp(BW); 
% stats = regionprops(cc);
% NoiseIdx=cc.PixelIdxList(find([stats.Area]<30));
% for i =1:size(NoiseIdx,2)
%     BW(NoiseIdx{i})=0;
% end
% %imshow(BW)
% %% version 2
% se = strel('disk',1);
% BW_open = imopen(BW,se);
% cc = bwconncomp(BW_open); 
% stats = regionprops(cc);
% NoiseIdx=cc.PixelIdxList(find([stats.Area]<30));
% for i =1:size(NoiseIdx,2)
%     BW_open(NoiseIdx{i})=0;
% end
% cc = bwconncomp(BW_open); 
% stats = regionprops(cc);
% RGB_rect=proj_ptc;
% box={stats.BoundingBox}';
% for i =1:size(stats,1)
%     RGB_rect = insertShape(RGB_rect,'Rectangle',box{i},'LineWidth',2);
% end
% figure;imshow(RGB_rect)
% 
% proj_ptc=proj_ptc./256;
% proj_ptc=uint8(proj_ptc);
% %% detect mushroom in big box
% load('FasterRCNN_epcho_5_multi_v2.mat')
% 
% box_thresh=30;
% big_box_idx=[];
% small_box_idx={};
% xx=0;
% for i =1:size(box,1)
%     if(box{i}(3)>box_thresh||box{i}(4)>box_thresh)
%         big_box_idx=[big_box_idx;i];
%         img=imcrop(proj_ptc,box{i});        
%         xscale=40/box{i}(3);
%         yscale=40/box{i}(4);
%         img=imresize(img,[40 40]);
%         [box_temp,scores] = detect(detector,img);
%         xx=xx+1;
%         if ~isempty(box_temp)
%             box_temp_rev=[box_temp(1)/xscale+box{i}(1), box_temp(2)/yscale+box{i}(2), box_temp(3)/xscale, box_temp(4)/yscale];
%             small_box_idx(xx,1)={box_temp_rev};
%         end
%     end
% end
% 
% 
% box(big_box_idx)=[];
% for i=1:size(small_box_idx,1)
%     if ~isempty(small_box_idx{i})
%         box=[box;small_box_idx(i)];
%     end
% end
% 
% rcnn_img=proj_ptc;
% for i =1:size(box,1)
%     rcnn_img = insertShape(rcnn_img,'Rectangle',box{i},'LineWidth',2);
% end
% figure;imshow(rcnn_img)
% 
%%
% img=double(imcrop(dep,box{90}))./(2^16);
% img(find(img==0))=max(max(img));
% img=max(max(img))-img;
% figure;surf(img)
% img = imgaussfilt(img,0.7);
% figure;surf(img)