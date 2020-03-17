clear;
clc;

files = dir('D:\CNN\Version_3\Full_image\RGBD');
Dt_bx=cell(length(files)-2,1);
for k = 3:length(files)
    k
    close all;
    Date=files(k).name;
    
    rgbd=imread(strcat('D:\CNN\Version_3\Full_image\RGBD\',Date));
    rgb=uint8(zeros(720,1280,3));
    rgb(:,:,1)=uint8(rgbd(:,1:1280)./256);
    rgb(:,:,2)=uint8(rgbd(:,1281:2560)./256);
    rgb(:,:,3)=uint8(rgbd(:,2561:3840)./256);
    proj_ptc=rgb;
    % rgb=uint8(rgbd(:,:,1:3)./256);
    dep=rgbd(:,3841:5120);
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
    Dep=dep;
    J=imadjust(Dep);
    
    [m,n]=size(J);
    
    close all
    idx=find(J==0);
    %[0.96 0.99]
    %tub=imadjust(J,[0.9 0.995],[]);
    nonzero_idx=find(J~=0);
    temp_gray=J(nonzero_idx);
    factor=((2^16)-100)/(66000-61000);
    temp_gray_eq=temp_gray-(max(temp_gray)-temp_gray)*factor;
    tub=J;
    tub(nonzero_idx)=temp_gray_eq;
    
    % tub = adapthisteq(J);
    figure;imshow(J)
    figure;imshow(tub)
    
    tub=max(max(tub))-tub;
    tub(idx)=0;
    figure;imshow(tub)
    temp=tub;
    BW=logical(tub);
    figure(1)
    
    [m,n]=size(tub);
    [p,q]=size(Dep);
    box_all=[];
    s_all={};
    for i=min(min(tub)):500:max(max(tub))
        %double(i)/double(max(max(tub))+1)*100
        tub(find(tub<i))=0;
        imshow(tub)
        
        CC = bwconncomp(tub,8);
        ii=1;
        num=CC.NumObjects;
        %         stats = regionprops(CC,'area','Centroid');
        
        while( ii<=num)
            % set spot to 0
            if(size(CC.PixelIdxList{ii},1)<=30)
                tub(CC.PixelIdxList{ii})=0;
                % when detect mushrooms, label and remove it from tub
            elseif(size(CC.PixelIdxList{ii},1)<500&&size(CC.PixelIdxList{ii},1)>30)
                
                [K,L]=ind2sub([m,n],CC.PixelIdxList{ii});
                
                box=[min(L) min(K) range(L) range(K)];
                single_mush=imcrop(BW,box);
                single_mush = imfill(single_mush,8,'holes');
                CC_sub = bwconncomp(single_mush,8);
                s = regionprops(CC_sub,'ConvexArea','Circularity','Eccentricity','Extent','Perimeter','Area','Solidity');
                %             extension_idx=(s.Area*s.Area*9E-06)-0.0042*s.Area+0.7586;
                [M,max_idx]=max([s.Area]);
                asp_ratio=range(L)/range(K);
                if(s(max_idx).Solidity>0.4&&asp_ratio>0.66&&asp_ratio<1.5)
                    tub(CC.PixelIdxList{ii})=0;
                    box_all=[box_all;box];
                    s_all=[s_all;s];
                end
            end
            ii=ii+1;
            
        end
        
    end
    I=insertShape(proj_ptc,'rectangle',box_all,'LineWidth',2);
    Dt_bx{k-2,1}=box_all;
    % for i=1:size(s_all,1)
    %     [M,max_idx]=max([s_all{i}.Area]);
    %     if(s_all{i}(max_idx).Extent<0.6)
    %         I=insertText(I,box_all(i,1:2),s_all{i}(max_idx).Extent,'FontSize',8);
    %     end
    % end
    imshow(I)
end
save('D:\CNN\Version_3\Full_image\Dt_bx','Dt_bx');
data={files.name}';
data(:,2)={files.folder};
data(3:end,3)=Dt_bx;
data=cell2table(data,'VariableNames',{'name','folder','position'});
save('D:\CNN\Version_3\Full_image\data','data');
% I_text=insertText(I,box_all(:,1:2),)
