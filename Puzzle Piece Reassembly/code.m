clc; clear; close all;

I = imread('Output.tif');
[w, h, ~] = size(I);

w_piece = 0;
h_piece = 0;

for i = 1:h
    if sum(I(:, i)) == 0
        h_piece = i - 1;
        break;
    end
end

for j = 1:w
    if sum(I(j, :)) == 0
        w_piece = j - 1;
        break;
    end
end


pattern = 'Patch_*.tif'; imageFiles = dir(pattern);
if ~exist('Patches', 'dir')
    mkdir('Patches');
end
for k = 1:length(imageFiles)
    sourceFile = fullfile(imageFiles(k).folder, imageFiles(k).name);
    destFile = fullfile('Patches', imageFiles(k).name);
    copyfile(sourceFile, destFile);
end

count_w = w / w_piece;
imageDir = '.\Patches';
imageFiles = dir(fullfile(imageDir, '*.tif'));
for i = 0:h / h_piece - 1
    max_temp_suppose_width = (i + 1) * h_piece;
    min_temp_suppose_width = i * h_piece + 1;
    goal = I(1:w_piece, min_temp_suppose_width:max_temp_suppose_width, :);

    if sum(sum(goal)) ~= 0
        continue;
    end
    suppose = I(1:w_piece, min_temp_suppose_width-h_piece:min_temp_suppose_width-1, :);
    results = struct('psnr1',  {}, 'total', {},  'imagePath', {});
    for k = 1:length(imageFiles)
        imagePath = fullfile(imageDir, imageFiles(k).name);
        img = imread(imagePath);
        test = img(:, 1, :);
        evaluate = suppose(:, end, :);
        psnr1 = psnr(test, evaluate);
        resultStruct = struct('psnr1', psnr1, 'total', psnr1, 'imagePath', imagePath);
        results(end + 1) = resultStruct;
    end
    total_values = [results.total];
    [~, maxIndex] = max(total_values);
    bestImagePath = results(maxIndex).imagePath;
    imageFiles(maxIndex) = [];
    I(1:w_piece, min_temp_suppose_width:max_temp_suppose_width, :) = imread(bestImagePath);
    imshow(I);
end

for k = 1:count_w - 2
    for i=0:(h / h_piece) - 1
        max_temp_suppose_height = (i + 1) * h_piece;
        min_temp_suppose_height = (i + 1) * h_piece - h_piece + 1;
        goal = I(k * w_piece + 1:(k+1)*w_piece,min_temp_suppose_height:max_temp_suppose_height);

        if (sum(sum(goal))~=0)
            continue;
        end

        if (i==0)
            suppose = I((k-1) * w_piece + 1:(k)*w_piece,1:h_piece,:);
        else
            suppose = I(k * w_piece + 1:(k+1)*w_piece,min_temp_suppose_height-h_piece:max_temp_suppose_height-h_piece,:);
        end

        results = struct('total', {},'imagePath', {});
        for x = 1:length(imageFiles)
            if (i==0)

                imagePath = fullfile(imageDir, imageFiles(x).name);
                img = imread(imagePath);
                bottom_border1 = suppose(end,:,:);
                top_border2 = img(1,:,:);
                psnr1 = psnr(bottom_border1, top_border2);
                resultStruct = struct('total', 0.5*psnr1,'imagePath', imagePath);
                results(end + 1) = resultStruct;
            else

                imagePath = fullfile(imageDir, imageFiles(x).name);
                img = imread(imagePath);
                right_border1 = suppose(:,end,:);
                left_border_2 = img(:,1,:);
                psnr1 = psnr(right_border1, left_border_2);
                top_suppose = I((k-1) * w_piece + 1:(k)*w_piece,min_temp_suppose_height:max_temp_suppose_height,:);
                top_bottom_border1 = top_suppose(end,:,:);
                bottom_top_border_2 = img(1,:,:);
                psnr2=psnr(top_bottom_border1,bottom_top_border_2);
                resultStruct = struct('total', 0.5*psnr1+0.5*psnr2, 'imagePath', imagePath);
                results(end + 1) = resultStruct;

            end
        end

        [~, maxIndex] = max([results.total]);
        minImagePath = results(maxIndex).imagePath;
        imageFiles(maxIndex)=[];
        I(k * w_piece + 1:(k+1)*w_piece,min_temp_suppose_height:max_temp_suppose_height,:)=(imread(minImagePath));
        imshow(I);
    end
end


for i = 0:h / h_piece - 1
    max_temp_suppose_width = (i + 1) * h_piece;
    min_temp_suppose_width = i * h_piece + 1;
    goal = I(1200-w_piece+1:1200, min_temp_suppose_width:max_temp_suppose_width, :);

    if sum(goal) ~= 0
        continue;
    end

    suppose = I(w-w_piece-w_piece+1:1200-w_piece, min_temp_suppose_width:max_temp_suppose_width, :);
    results = struct('total', {},  'imagePath', {});
    for k = 1:length(imageFiles)
        imagePath = fullfile(imageDir, imageFiles(k).name);
        img = imread(imagePath);
        evaluate = I(1200-w_piece+1:1200, min_temp_suppose_width-h_piece:max_temp_suppose_width-h_piece, :);
        evaluate = evaluate(:, end-10:end, :);

        test = img(1, :, :);
        evaluate = suppose(end, :, :);
        psnr1 = psnr(test, evaluate);
            
        test = img(:, 1, :);
        evaluate = I(1200-w_piece+1:1200, min_temp_suppose_width-h_piece:max_temp_suppose_width-h_piece, :);
        evaluate = evaluate(:, end, :);
        psnr2 = psnr(test,evaluate);
        resultStruct = struct('total', 0.5*psnr1+0.5*psnr2, 'imagePath', imagePath);
        results(end + 1) = resultStruct;

    end

    total_values = [results.total];
    [~, maxIndex] = max(total_values);
    bestImagePath = results(maxIndex).imagePath;
    imageFiles(maxIndex) = [];
    I(w-w_piece+1:w, min_temp_suppose_width:max_temp_suppose_width, :) = imread(bestImagePath);
    imshow(I);
end
psnrValue = psnr(I, imread('Original.tif'));
imshow(I);
textPosition = [10 10]; 
textString = sprintf('PSNR: %.2f dB', psnrValue);
textColor = 'white';


text(textPosition(1), textPosition(2), textString, 'Color', textColor, 'FontSize', 12, 'FontWeight', 'bold');

