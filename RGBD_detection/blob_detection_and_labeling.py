# -*- coding: utf-8 -*-
"""
Created on Tue Feb  4 10:35:47 2020

@author: harry
"""
from math import sqrt
import skimage
import cv2
import numpy as np
from matplotlib import pyplot as plt
from skimage.feature import blob_dog, blob_log, blob_doh
from skimage.color import rgb2gray



img=skimage.io.imread(u'D:\RGBD_detection\Image_format\RGB\img2019_11_7_9_50.png')
dep=skimage.io.imread(u'D:\RGBD_detection\Image_format\Dep\img2019_11_7_9_50.png')
#dep=dep.astype(float)

#dep_enhc = skimage.exposure.equalize_adapthist(dep,clip_limit=0.1)
#dep_enhc=np.amax(dep_enhc)-dep_enhc
#plt.imshow(dep_enhc,cmap='gray')
#rgbArray = np.zeros((450,800,3), 'uint8')
#rgbArray[..., 0] = r
#rgbArray[..., 1] = g
#rgbArray[..., 2] = b

#plt.imshow(dep)
#plt.show()
image_gray = rgb2gray(img)
image_gray_enhc = skimage.exposure.equalize_adapthist(image_gray)
#plt.imshow(image_gray)
#plt.imshow(image_gray_enhc)

blobs_log = blob_log(image_gray_enhc, min_sigma=7, max_sigma=12, num_sigma=10, threshold=.25)
# Compute radii in the 3rd column.
blobs_log[:, 2] = blobs_log[:, 2] 

blobs_list = blobs_log
colors = 'yellow'
titles = 'Laplacian of Gaussian'

fig, axes = plt.subplots()

axes.set_title(titles)
axes.imshow(image_gray_enhc,cmap='gray')
for blob in blobs_list:
    y, x, r = blob
    c = plt.Circle((x, y), r, color=colors, linewidth=2, fill=False)
    axes.add_patch(c)
axes.set_axis_off()

plt.tight_layout()
plt.show()