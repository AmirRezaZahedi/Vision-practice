
---

## Puzzle Solver in MATLAB

### Overview
This MATLAB program is designed to solve an image puzzle by reassembling shuffled image patches back into their original positions. The image is divided into square patches, and the algorithm tries to rearrange these patches based on the matching edges. The final output is a reassembled image with the **PSNR (Peak Signal-to-Noise Ratio)** value displayed, which measures the quality of the reassembled image by comparing it to the original.

### Algorithm Explanation

1. **Loading the Large Image and Determining Patch Size**:
   - The program begins by loading the large image (`Output.tif`).
   - It determines the dimensions of the smaller patches (width `w_piece` and height `h_piece`) by identifying columns and rows with all zero values. These zero-value rows and columns indicate the gaps between the puzzle pieces.

2. **Copying the Image Patches**:
   - The program identifies all image patches by looking for files named using the pattern `Patch_*.tif`.
   - These patches are then copied into a new directory named `Patches`.
   - Note: **Corner images are not considered** during the matching process, as they represent the edges of the image and are not used for reassembly.

3. **Reassembling the Puzzle**:
   
   The algorithm reconstructs the image by aligning the patches using their borders. It iteratively places each patch in the correct position by comparing the borders of neighboring patches, using PSNR (Peak Signal-to-Noise Ratio) as the metric for determining the best match. The program ensures optimal alignment by evaluating the similarity between neighboring patches and selecting the patch with the highest PSNR for placement. This process continues across all rows and columns of the image until the entire puzzle is reconstructed.

4. **Final Image and PSNR**:
   - Once all the patches are placed, the program calculates the **PSNR** between the reassembled image and the original image (`Original.tif`) to evaluate the quality of the reconstruction.
   - The PSNR value is displayed on the output image at the top-left corner.

5. **Using MATLAB Structs**:
   - To manage the evaluation of patches and their corresponding **PSNR** values, the program makes use of MATLAB `structs`, which store the results for each patch and help in selecting the best matching patch.

### Execution Instructions

1. **Required Files**:
   - Puzzle image patches should be named starting with `Patch_` (e.g., `Patch_1.tif`, `Patch_2.tif`, etc.).
   - The images `Output.tif` (the shuffled puzzle) and `Original.tif` (the original image) must be placed in the same directory as the MATLAB code for comparison.
   - All images must be in **.tif** format.

2. **File Structure**:
   Ensure the following files are available:
   - `Patch_*.tif` — individual image patches of the puzzle.
   - `Output.tif` — the shuffled image that needs to be solved.
   - `Original.tif` — the original, unshuffled image to compare the result against.

3. **Running the Program**:
   After placing the required images, run the MATLAB script by typing:
   ```matlab
   clc; clear; close all;
   ```
   The program will start by analyzing the puzzle and begin solving it by reassembling the patches based on the edge matching algorithm.

4. **Output**:
   - The final reassembled image will be displayed with the **PSNR** value overlaid on it.
   - The output image will be saved as `Output.tif`.

### Key Steps in the Algorithm:

1. **Loading the Image**: 
   - The program loads the large image (`Output.tif`) and determines the size of the small patches by detecting the zero-value rows and columns.
   
2. **Patch Extraction and Copying**: 
   - All puzzle pieces are identified using the naming convention `Patch_*.tif` and copied into a folder called `Patches`.

3. **Reconstructing the First Row**: 
   - The first row of the puzzle is solved by comparing the right edge of the current patch with the left edge of the next patch using **PSNR**.

4. **Reconstructing the Remaining Rows**:
   - The program uses a similar approach to solve the next rows, where the comparison is done between the right and bottom edges of adjacent patches. 
   - The **PSNR** values are calculated for all possible matches, and the patch with the maximum **PSNR** is selected.
