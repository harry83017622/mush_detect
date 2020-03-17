close all;
clear


files = dir('D:\pointcloud_Oct30');
dirFlags = [files.isdir];
subFolders = files(dirFlags);
for k = 3 : 3:length(subFolders)-2
    k/(length(subFolders)-2)*100
    close all;
    Date=subFolders(k).name;
    
    dir='D:\pointcloud_Oct30\';
%     Date='2019_10_11_';
%     time='15_52';
    
    for index=1:7
        
        file_name=strcat(dir,Date);
        load(strcat(file_name,'\ptcloud',num2str(index),'.mat'));
        
        
        %pcshow(ptcloud2)
        if index~=4
            load(strcat(dir,'tform',num2str(index),'4.mat'));
            load(strcat(dir,'tform',num2str(index),'_icp.mat'));
        end
        if index==1
            ptcloud_tform = pctransform(ptcloud1,tform14);
            ptcloud_tform1 = pctransform(ptcloud_tform,tform1_icp);
        elseif index==2
            ptcloud_tform = pctransform(ptcloud2,tform24);
            ptcloud_tform2 = pctransform(ptcloud_tform,tform2_icp);
        elseif index==3
            ptcloud_tform = pctransform(ptcloud3,tform34);
            ptcloud_tform3 = pctransform(ptcloud_tform,tform3_icp);
        elseif index==5
            ptcloud_tform = pctransform(ptcloud5,tform54);
            ptcloud_tform5 = pctransform(ptcloud_tform,tform5_icp);
        elseif index==6
            ptcloud_tform = pctransform(ptcloud6,tform64);
            ptcloud_tform6 = pctransform(ptcloud_tform,tform6_icp);
        elseif index==7
            ptcloud_tform = pctransform(ptcloud7,tform74);
            ptcloud_tform7 = pctransform(ptcloud_tform,tform7_icp);
            
            %pcshow(ptcloud_tform1)
            % ptcloud_tform=ptcloud4;
        end
    end
    ptc1=ptcloud_tform1.Location;
    ptc_color1=ptcloud_tform1.Color;
    ptc2=ptcloud_tform2.Location;
    ptc_color2=ptcloud_tform2.Color;
    ptc3=ptcloud_tform3.Location;
    ptc_color3=ptcloud_tform3.Color;
    ptc4=ptcloud4.Location;
    ptc_color4=ptcloud4.Color;
    ptc5=ptcloud_tform5.Location;
    ptc_color5=ptcloud_tform5.Color;
    ptc6=ptcloud_tform6.Location;
    ptc_color6=ptcloud_tform6.Color;
    ptc7=ptcloud_tform7.Location;
    ptc_color7=ptcloud_tform7.Color;
    
    ptc=[ptc1;ptc2;ptc3;ptc4;ptc5;ptc6;ptc7];
    ptc_color=[ptc_color1;ptc_color2;ptc_color3;ptc_color4;ptc_color5;ptc_color6;ptc_color7];
    
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
    % ptc(:,3)=max(ptc(:,3))-ptc(:,3);
    ptcloud_all=pointCloud(ptc,'color',ptc_color);
    [ptcloud_all,indices] = removeInvalidPoints(ptcloud_all);
    ptcloud_all_temp=ptcloud_all;
    ptc_temp=ptcloud_all_temp.Location;
    ptc_color_temp=ptcloud_all_temp.Color;
    ptc_temp(:,3)=max(ptc_temp(:,3))-ptc_temp(:,3);
    figure;pcshow(pointCloud(ptc_temp,'color',ptc_color_temp))
    xlabel('x (meters)','fontsize',20)
    ylabel('y (meters)','fontsize',20)
    zlabel('z (meters)','fontsize',20)
    box on
    %view(128,20)
    % pause(20)
    % for i=0:1:360
    %
    %     view(i+120,20)
    %     pause(0.1)
    % end
    
    ptc=ptcloud_all.Location;
    ptc_color=ptcloud_all.Color;
    
    
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
    
    
    proj_ptc=uint16(zeros(resolution_y,resolution_x,3));
    proj_ptc_dep=uint16(zeros(resolution_y,resolution_x,1));
    for i =1:size(proj_ptc,1)
        for j=1:size(proj_ptc,2)
            proj_ptc(i,j,:)=mean(ptc_color(proj_ptc1_cell{i,j},:))*(2^8);
            proj_ptc_dep(i,j)=mean(ptc(proj_ptc1_cell{i,j},3))*(2^16);
        end
    end
    
    rgbd=proj_ptc;
    rgbd(:,:,4)=proj_ptc_dep;
    
    
    figure;imshow(proj_ptc)
    figure;imshow(imadjust(proj_ptc_dep,[.76 .9],[]))
    imwrite(proj_ptc,strcat('D:\CNN\Version_3\Full_image\Color\',Date,'.png'))
    imwrite(proj_ptc_dep,strcat('D:\CNN\Version_3\Full_image\Dep\',Date,'.png'))
    rgbd=[reshape(proj_ptc,resolution_y,resolution_x*3),proj_ptc_dep];
    imwrite(rgbd,strcat('D:\CNN\Version_3\Full_image\RGBD\',Date,'.png'))
end
% proj_ptc_dep=double(proj_ptc_dep);
% save(strcat('D:\RGBD_detection\Text_format\',Date,time,'.txt'), 'proj_ptc_dep');

%%

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
%% detect mushroom in big box
% load('FasterRCNN_mush_detect_v1.mat')
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

%%
% img=double(imcrop(dep,box{90}))./(2^16);
% img(find(img==0))=max(max(img));
% img=max(max(img))-img;
% figure;surf(img)
% img = imgaussfilt(img,0.7);
% figure;surf(img)