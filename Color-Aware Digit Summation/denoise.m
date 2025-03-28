function output = denoise(originalImage, kernelSize)
filteredImage = im2double(zeros(size(originalImage)));
paddedImage = im2double(padarray(originalImage, [floor(kernelSize/2),floor(kernelSize/2)], 'symmetric'));
for i = 1:size(paddedImage,1)-(kernelSize - 1)
    for j = 1:size(paddedImage,2)-(kernelSize - 1)
        neighborhood = paddedImage(i:i+kernelSize-1, j:j+kernelSize-1);
        if paddedImage(i+floor(kernelSize/2), j+floor(kernelSize/2)) == 0
            %|| paddedImage(i+floor(kernelSize/2),j+floor(kernelSize/2))==1
            med = median(neighborhood(:));
            filteredImage(i, j) = med;
        else
            filteredImage(i, j) = paddedImage(i+floor(kernelSize/2),j+floor(kernelSize/2));
        end
    end
end
output = filteredImage;
end