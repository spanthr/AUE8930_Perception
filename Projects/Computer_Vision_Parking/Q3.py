import cv2
import numpy as np
from matplotlib import pyplot as plt
# Load an color image in grayscale
img = cv2.imread('ParkingLot.jpg',0)

cv2.imshow('image',img)
cv2.waitKey(0)
cv2.destroyAllWindows()

"""Question 3.1"""

hist,bins = np.histogram(img.flatten(),256,[0,256])

cdf = hist.cumsum()
cdf_normalized = cdf * hist.max()/ cdf.max()

plt.plot(cdf_normalized, color = 'b')
plt.hist(img.flatten(),256,[0,256], color = 'r')
plt.xlim([0,256])
plt.legend(('cdf','histogram'), loc = 'upper left')
plt.show()
cv2.waitKey(0)
cv2.destroyAllWindows()

# Histpgram equalization of the gray grayscale image
img = cv2.imread('ParkingLot.jpg',0)
img_equ= cv2.equalizeHist(img)
# res = np.hstack((img,equ)) #stacking images side-by-side
# cv2.imwrite('equ.png',res)
cv2.imshow('Histogram Equaluzation',img_equ)
cv2.waitKey(0)
cv2.destroyAllWindows()


 # Selecting the perfect threshold

# # define a threshold, 128 is the middle of black and white in grey scale
thresh = 0.985*255
# assign blue channel to zeros
img_binary = cv2.threshold(img_equ, thresh, 255, cv2.THRESH_BINARY)[1]

# Displaying the Binary image
cv2.imshow('Binary',img_binary)
cv2.waitKey(0)
cv2.destroyAllWindows()

"""Question 3.2"""
""" Applying Hough Transformation"""
max_slider=50

# Detect points that form a line
lines = cv2.HoughLinesP(img_binary, 1, np.pi/180, max_slider, minLineLength=10, maxLineGap=250)
# Draw lines on the image
c=0
for line in lines:
    x1, y1, x2, y2 = line[0]
    cv2.line(img, (x1, y1), (x2, y2), (0,0,255), 5)
# Show result
    cv2.imshow("Result Image", img)
    cv2.waitKey(0)
    cv2.destroyAllWindows()
    cv2.circle(img,(int(x1),int(y1)),10,(0,0,10),-11)
    cv2.circle(img,(int(x2),int(y2)),10,(0,255,10),-11)
    if c==0:
        z=line[0]
        a1,b1,a2,b2=line[0]






"""Question 3.4"""






# def identify_blocks(image, lines, make_copy=True):
#     if make_copy:
#         new_image = np.copy(image)
#
#      #Step 1: Create a clean list of lines
#     cleaned = []
#     for line in lines:
#         for x1,y1,x2,y2 in line:
#             if abs(y2-y1) <=1 and abs(x2-x1) >=25 and abs(x2-x1) <= 55:
#                 cleaned.append((x1,y1,x2,y2))
#
#     #Step 2: Sort cleaned by x1 position
#     import operator
#     list1 = sorted(cleaned, key=operator.itemgetter(0, 1))
#
#     #Step 3: Find clusters of x1 close together - clust_dist apart
#     clusters = {}
#     dIndex = 0
#     clus_dist = 10
#
#     for i in range(len(list1) - 1):
#         distance = abs(list1[i+1][0] - list1[i][0])
#     #         print(distance)
#         if distance <= clus_dist:
#             if not dIndex in clusters.keys(): clusters[dIndex] = []
#             clusters[dIndex].append(list1[i])
#             clusters[dIndex].append(list1[i + 1])
#
#         else:
#             dIndex += 1
#
#
#
#     #Step 4: Identify coordinates of rectangle around this cluster
#     rects = {}
#     i = 0
#     for key in clusters:
#         all_list = clusters[key]
#         cleaned = list(set(all_list))
#         if len(cleaned) > 5:
#             cleaned = sorted(cleaned, key=lambda tup: tup[1])
#             avg_y1 = cleaned[0][1]
#             avg_y2 = cleaned[-1][1]
#     #         print(avg_y1, avg_y2)
#             avg_x1 = 0
#             avg_x2 = 0
#             for tup in cleaned:
#                 avg_x1 += tup[0]
#                 avg_x2 += tup[2]
#             avg_x1 = avg_x1/len(cleaned)
#             avg_x2 = avg_x2/len(cleaned)
#             rects[i] = (avg_x1, avg_y1, avg_x2, avg_y2)
#             i += 1
#
#     print("Num Parking Lanes: ", len(rects))
#     #Step 5: Draw the rectangles on the image
#     buff = 7
#     for key in rects:
#         tup_topLeft = (int(rects[key][0] - buff), int(rects[key][1]))
#         tup_botRight = (int(rects[key][2] + buff), int(rects[key][3]))
# #         print(tup_topLeft, tup_botRight)
#         cv2.rectangle(new_image, tup_topLeft,tup_botRight,(0,255,0),3)
#     return new_image, rects
#
# # images showing the region of interest only
# rect_images = []
# rect_coords = []
# for image, lines in zip(img_binary,lines):
#     new_image, rects = identify_blocks(image, lines)
#     rect_images.append(new_image)
#     rect_coords.append(rects)
#
# show_images(rect_images)
