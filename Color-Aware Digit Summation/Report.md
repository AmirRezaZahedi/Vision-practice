

---

# Image Digit Summation using DFS

## Overview
This repository contains an image processing algorithm that extracts digits from images, sums them based on their color, and writes the computed result onto the image. The algorithm leverages **Depth-First Search (DFS)** for connected component analysis and **PSNR-based template matching** for digit recognition.

## Problem Statement
Given a set of images containing numbers in red and blue colors:
- **Red digits** are considered **positive**.
- **Blue digits** are considered **negative**.
The algorithm should **extract** all digits, **compute their sum**, and **write the result in green at the bottom of the image**.
- The correctness of the approach is measured by **accuracy percentage**, which is calculated as:

$$
\text{Accuracy} = \frac{\text{Correct Summations}}{\text{Total Images}} \times 100
$$


## Methodology
### 1. Preprocessing
- **Noise Reduction**: The image undergoes a denoising process using a custom filtering technique to improve digit segmentation.
- **Binarization**: Each channel (red & blue) is processed separately using thresholding.

### 2. Connected Component Analysis using DFS
- The algorithm employs **DFS** to segment individual digit components.
- The segmented components are **cropped and stored** for recognition.

### 3. Digit Recognition using PSNR-based Matching
- A dataset of reference digit images is used for **template matching**.
- Each extracted digit is resized and compared against dataset images using **PSNR** (Peak Signal-to-Noise Ratio).
- The closest match determines the digit label.

### 4. Summation & Output Generation
- Identified digits are summed according to their respective colors (red = positive, blue = negative).
- The computed result is written in **green** at the bottom of the image.
- The processed image is saved to the `results/` folder.

### 5. Denoising and DFS Segmentation
The preprocessing includes:
- **Median Filtering (Denoising)**: A custom noise reduction technique using the median filter (`medfilt2`) is applied iteratively four times for salt-and-pepper noise. This is crucial for digit segmentation.
- **DFS**: **Depth-First Search (DFS)** is employed for **connected component analysis**, effectively extracting digits even in noisy images. Each connected component is labeled, and its coordinates are stored.
- **Digit Extraction and Matching**: Each extracted component is compared to reference digit templates, and **PSNR** (Peak Signal-to-Noise Ratio) is used to determine the best match. The maximum PSNR value is chosen for the digit.

The digits from the **red channel** (positive) and **blue channel** (negative) are processed separately. The summation of the red and blue digits is computed separately, and the final result is written in **green** on the image.

## Code Structure
- **`main.m`** - Main script handling image processing, DFS, and summation.
- **`dfs`** - Implements Depth-First Search for digit segmentation.(a function in main.m)
- **`help_denoise.m`** - Denoising function to enhance image quality.
- **`denoise.m`** - Kernel-based noise removal function.

## Usage
### Required Folders
Before running the program, ensure the following folders are created in the same directory as the main code:
1. **`results/`** - Stores the processed images with computed sums written in green.
2. **`output/`** - Contains intermediate outputs (explained in the report).
3. **`noisedImage/`** - Place the noisy images to be processed in this folder.

### Running the Program
To run the program, execute:
```matlab
clc; clear; close all;
main;
```
Ensure that the dataset folder contains reference digits for matching.

## Results
The algorithm was tested on a dataset of images with known sums:
- **Accuracy achieved: 92%**
- **Processing time all images: ~15 minutes**
