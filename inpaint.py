import numpy as np
import cv2

img = cv2.imread('SegRGB1-1.jpg')
img1 = cv2.imread('SegRGB1-2.jpg')
mask = cv2.imread('SegMask1-1.png', 0)
mask1 = cv2.imread('SegMask1-2.png', 0)
dst = cv2.inpaint(img ,mask, 3 ,cv2.INPAINT_TELEA)
cv2.imshow('dst',dst)
cv2.imwrite('image1.jpg',dst)
dst1 = cv2.inpaint(img1 ,mask1, 3 ,cv2.INPAINT_TELEA)
cv2.imshow('dst1',dst1)
cv2.imwrite('image2.jpg',dst1)
cv2.waitKey(0)
cv2.destroyAllWindows()


