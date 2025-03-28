function output =  help_denoise(img)
% Read the image
originalImage = img;
kernelSize = 3;
filteredImage1 = denoise(originalImage, kernelSize);
filteredImage2 = denoise(filteredImage1, kernelSize);
filteredImage3 = denoise(filteredImage2, kernelSize);
filteredImage4 = denoise(filteredImage3, kernelSize);
matl = medfilt2((filteredImage4),[3 3]);
% imshow([matl (filteredImage)] );
% disp(my_psnr(filteredImage, im2double(originalImage)));
% disp(my_psnr(matl, im2double(originalImage)));
disp('finish denoising image');
output = matl;
end