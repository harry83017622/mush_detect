close all;
clear
dir='D:\pointcloud_Oct30\';
Date='2019_11_7_';
time='9_50';
while(1)
    for index=1:7
        
        file_name=strcat(dir,Date,time);
        load(strcat(file_name,'\ptcloud',num2str(index),'.mat'));
        load(strcat(file_name,'\color',num2str(index),'.mat'));
        
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
    
    ptcloud_all=pointCloud(ptc,'color',ptc_color);
    [ptcloud_all,indices] = removeInvalidPoints(ptcloud_all);
    pcshow(ptcloud_all)
    xlabel('x')
    ylabel('y')
    zlabel('z')
    
    ptc=ptcloud_all.Location;
    ptc_color=ptcloud_all.Color;
    
    
    %%
    % need to store the range_xy and min_xy information
    range_x=range(ptc(:,1))+0.0001;
    min_x=min(ptc(:,1))-0.0001;
    range_y=range(ptc(:,2))+0.0001;
    min_y=min(ptc(:,2))-0.0001;
    resolution_x=16*50;
    resolution_y=9*50;
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
    rgbd=[reshape(proj_ptc,resolution_y,resolution_x*3),proj_ptc_dep];
    break;
end
figure;imshow(proj_ptc)
figure;imshow(imadjust(proj_ptc_dep,[.76 .9],[]))
imwrite(proj_ptc,strcat('D:\RGBD_detection\Image_format\RGB\',Date,time,'.png'))
imwrite(proj_ptc_dep,strcat('D:\RGBD_detection\Image_format\Dep\',Date,time,'.png'))
imwrite(rgbd,strcat('D:\RGBD_detection\Image_format\RGB-D\',Date,time,'.png'))
% proj_ptc_dep=double(proj_ptc_dep);
% save(strcat('D:\RGBD_detection\Text_format\',Date,time,'.txt'), 'proj_ptc_dep');



