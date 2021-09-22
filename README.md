# A Computer Vision Pipeline that Uses Thermal and RGB Images for the Recognition of Holstein Cattle

This repsositiry contains code for our paper:

[A. Bhole, O. Falzon, M. Biehl, G. Azzopardi, “A Computer Vision Pipeline that Uses Thermal and RGB Images for the Recognition of Holstein Cattle”, Computer Analysis of Images and Patterns (CAIP), pp. 108-119, 2019](https://link.springer.com/chapter/10.1007/978-3-030-29891-3_10)

## Dataset

The dataset can be found here: 

http://www.cs.rug.nl/~george/cattle-recognition/

https://dataverse.nl/dataset.xhtml;jsessionid=c3c07bd6aa8338c21c76567ff65f?persistentId=doi%3A10.34894%2FO1ZBSA&version=&q=&fileTypeGroupFacet=&fileAccess=&fileSortField=name&fileSortOrder=desc

## Abstract

The monitoring of farm animals is important as it allows farmers keeping track of the performance indicators and any signs of health issues, which is useful to improve the production of milk, meat, eggs and others. In Europe, bovine identification is mostly dependent upon the electronic ID/RFID ear tags, as opposed to branding and tattooing. The RFID based ear-tagging approach has been called into question because of implementation and management costs, physical damage and animal welfare concerns. In this paper, we conduct a case study for individual identification of Holstein cattle, characterized by black, brown and white patterns, in collaboration with the Dairy campus in Leeuwarden. We use a FLIR E6 thermal camera to collect an infrared and RGB image of the side view of each cow just after leaving the milking station. We apply a fully automatic pipeline, which consists of image processing, computer vision and machine learning techniques on a data set containing 1237 images and 136 classes (i.e. individual animals). In particular, we use the thermal images to segment the cattle from the background and remove horizontal and vertical pipes that occlude the cattle in the station, followed by filling the blank areas with an inpainting algorithm. We use the segmented image and apply transfer learning to a pre-trained AlexNet convolutional neural network. We apply five-fold cross-validation and achieve an average accuracy rate of 0.9754 ± 0.0097. The results obtained suggest that the proposed non-invasive approach is highly effective in the automatic recognition of Holstein cattle from the side view. In principle, this approach is applicable to any farm animals that are characterized by distinctive coat patterns.

## Citation

If you find this paper or code useful, we encourage you to cite the paper. BibTeX:

      @InProceedings{Bhole2019,
      author=”Bhole, Amey and Falzon, Owen and Biehl, Michael and Azzopardi, George”,
      editor=”Vento, Mario and Percannella, Gennaro”,
      title=”A Computer Vision Pipeline that Uses Thermal and RGB Images for the Recognition of Holstein Cattle”,
      booktitle=”Computer Analysis of Images and Patterns”,
      year=”2019″,
      publisher=”Springer International Publishing”,
      address=”Cham”,
      pages=”108–119″,
      isbn=”978-3-030-29891-3″
      }

