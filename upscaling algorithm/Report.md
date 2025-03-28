# Image Upscaling using Lanczos3 and Custom Filtering

## Overview
This repository contains an image upscaling algorithm that outperforms traditional interpolation methods. Algorithms like Bicubic interpolation, Nearest Neighbor, and Bilinear interpolation have been widely used for image resizing. For example, Nearest Neighbor simply replicates pixels, leading to blocky results, while Bilinear interpolation blends adjacent pixels but often causes blurring. Bicubic interpolation improves on these by considering more neighboring pixels, yet it still struggles with sharp edges and fine details. To overcome these issues, our method utilizes Lanczos3 resampling followed by a custom filtering process, ensuring superior quality. The effectiveness of this approach has been evaluated using the Peak Signal-to-Noise Ratio (PSNR) metric, demonstrating its advantages.

## Methodology
### 1. Initial Upscaling with Lanczos3
The input image is first resized using **Lanczos3 interpolation**, which provides better edge preservation and less aliasing compared to Bicubic interpolation.

### 2. Custom Filtering for Enhanced Detail Preservation
A custom **box filtering** technique is applied to the upscaled image. This filter processes the image in 2×2 patches to smooth the regions while retaining sharpness, ensuring a better balance between noise reduction and detail preservation.

### 3. Channel-wise Processing
If the image is RGB, each channel (Red, Green, Blue) is processed separately to maintain color integrity and avoid cross-channel artifacts.

## Performance Evaluation
To objectively compare our approach against Bicubic interpolation, we used the **PSNR** metric. The results consistently show that our method produces higher PSNR values, indicating less distortion and better image fidelity.

### **Experimental Results**
- Using **Bicubic interpolation**, the PSNR value was **around 29.5 dB** (on the Cameraman image).
- With **Lanczos3 upscaling**, the PSNR improved to **30 dB**.
- After applying our **custom filtering**, the PSNR further increased to **38.3 dB**, proving significant enhancement.
- The custom filter uses a **2×2 averaging method**, which eliminates minor noise while maintaining details.
- To ensure proper matrix alignment, the image width is padded to the nearest multiple of 4 before processing.

## Code Structure
- **`main_algorithm.m`**: Implements the full pipeline, including Lanczos3 upscaling and custom filtering.
- **`filterImage.m`**: Contains the filtering logic that enhances the upscaled image quality.

## Usage
```matlab
original_img = imread('input.png');
resizing_factor = 2; % Example: 2x upscaling
resized_image = main_algorithm(original_img, resizing_factor);
imwrite(resized_image, 'output.png');
```

## Why This Method?
✅ **Better than Bicubic**: Higher PSNR values indicate improved image quality.  
✅ **Edge Preservation**: Lanczos3 interpolation reduces aliasing and artifacts.  
✅ **Custom Filtering**: Enhances texture and smoothness without excessive blurring.  


