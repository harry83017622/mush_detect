clear;clc;
close all
img=imread('D:\CNN\Version_2\Traindata_v3\2020_1_14_5_23_ptcloudout.png');
load('D:\CNN\Version_2\mushroom_v3.mat')
% RGB = insertShape(img,'Rectangle',mushroom_v3{22},'LineWidth',4);
% imshow(RGB);
position_all={};
pic_name={};
box=mushroom_v3{22};

for i =1:size(box,1)
    for num=1:10
        x_var=randi([10 25]);
        y_var=randi([10 25]);
        wid_var=randi([10 25]);
        hgt_var=randi([10 25]);
        xmin=box(i,1)-x_var;
        ymin=box(i,2)-y_var;
        width=box(i,3)+x_var+wid_var;
        height=box(i,4)+y_var+hgt_var;
        
        
        img_crop=imcrop(img,[xmin ymin width height]);
        coef_x=40/size(img_crop,2);
        coef_y=40/size(img_crop,1);
        img_crop_resize=imresize(img_crop,[40 40]);
        position=round([x_var*coef_x y_var*coef_y box(i,3)*coef_x box(i,4)*coef_y]);
%         RGB = insertShape(img_crop_resize,'Rectangle',position,'LineWidth',2);
%         figure;imshow(RGB)
        imwrite(img_crop_resize,strcat('D:\RGBD_detection\train\img',num2str(i,'%03.f'),'_',num2str(num,'%02.f'),'.png'))
        pic_num((i-1)*10+num,1)={strcat('train\img',num2str(i,'%03.f'),'_',num2str(num,'%02.f'),'.png')};
        position_all((i-1)*10+num,1)={num2cell(position,2)};
    end
end
T=[cell2table(pic_num) cell2table(position_all)];
save('LabelData.mat', 'T')

