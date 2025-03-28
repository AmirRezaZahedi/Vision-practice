clc;clear;close all;
tic;
dx = [-1, 0, 1, 1, 1, 0, -1, -1];
dy = [1, 1, 1, 0, -1, -1, -1, 0];
imageDir = '.\noisedImage\';
imageFiles = dir(fullfile(imageDir, '*.png'));
folderPath = '.\output\';
for k = 1:length(imageFiles)
    disp(['Image:', num2str(k)]);
    red = 0;
    blue = 0;
    filename = fullfile(imageDir, imageFiles(k).name);
    img2 = imread(filename);
    for c=1:2:3

        Blues = img2(:,:,c);
        Blues(750:800, :) = [];
        Bluesplus = help_denoise(im2double(Blues));
        
        initialThreshold = graythresh(Bluesplus);
        binaryImage = imbinarize(Bluesplus, initialThreshold);
        Bluesplus = binaryImage;
        dataset_dir = '.\dataset';
        nearest_img = [];
        nearest_filename = [];

        dataset_files = dir(fullfile(dataset_dir, '*.png'));

        global g; 
        g = Bluesplus;
        g = 1 - g;
        global w;
        w = zeros(751, 752);

        g = padarray(g, [1 1], 0, 'both');
        set = 1;

        for i = 2:size(g,1)-1
            for j = 2:size(g,2)-1
                if g(i, j) && ~w(i, j)
                    dfs(i, j, set, dx, dy);
                    set = set + 1;
                end
            end
        end
        [rows, cols] = size(w);
        
        numComponents = max(w(:));
        startRow = zeros(numComponents, 1);
        endRow = zeros(numComponents, 1);
        startCol = zeros(numComponents, 1);
        endCol = zeros(numComponents, 1);

        for label = 1:numComponents
            
            [rowIndices, colIndices] = find(w == label);

            
            startRow(label) = min(rowIndices);
            endRow(label) = max(rowIndices);
            startCol(label) = min(colIndices);
            endCol(label) = max(colIndices);
        end
        num = 0;
        for label = 1:numComponents
            nearest_img = [];
            nearest_filename = [];

            img = imcrop(Bluesplus, [startCol(label),startRow(label),endCol(label)-startCol(label),endRow(label)-startRow(label)]);
            sumationelements=0;
            for i=1:size(img,1)
                for j=1:size(img,2)
                    sumationelements = sumationelements + img(i,j);
                end
            end
            if(sumationelements == 1 * size(img,1) * size(img,2) || (size(img,1) < 10) && size(img,2) < 10 || size(img,1)<6)
                %|| (size(img,1) < 10) && size(img,2)
                continue;
            end
            %fprintf('Component %d: StartRow = %d, EndRow = %d, StartCol = %d, EndCol = %d\n', ...
            %    label, startRow(label), endRow(label), startCol(label), endCol(label));
            for i = 1:length(dataset_files)
                dataset_img = imread(fullfile(dataset_dir, dataset_files(i).name));
                %psnr_value = psnr(im2double(img), im2double(imresize(dataset_img,[size(img,1),size(img,2)])));
                psnr_value = psnr(im2double(imresize(img,[size(dataset_img,1),size(dataset_img,2)])), im2double((dataset_img)));
                nearest_img = [nearest_img,psnr_value];
                nearest_filename = [nearest_filename,{dataset_files(i).name}];
            end
            % figure;
            % imshow(img)
            % pause(0.5);
            [~, max_index] = max(nearest_img(1,:));
            nearest_filename_max = nearest_filename(max_index);

            % if(size(img,2)<8)
            %       nearest_filename_max = {'1.png'};
            %       disp(nearest_filename_max);
            %   else
            %disp(nearest_filename_max);
            % end
            [~, name, ~] = fileparts(nearest_filename_max);
            num = str2num(name{1});

            if(c==1)%blue channel
                blue = blue + num;
            else% red channel
                red = red + num;
            end

        end
    end
    sum = (-1) * blue + red;

    fileName = imageFiles(k).name;
    filePath = fullfile(folderPath, [fileName, '.txt']);
    fileID = fopen(filePath, 'w');
    fprintf(fileID, '%d',sum);
    fclose(fileID);
    position = [364, 777];
    textToInsert = num2str(sum);
    textColor = 'green';
    img_with_text = insertText(img2, position, textToInsert, 'TextColor', textColor);
    result_filepath = fullfile('.\results', fileName);
    imwrite(img_with_text, result_filepath);
end
elapsed_time = toc;
disp(['Elapsed time: ', num2str(elapsed_time), ' seconds']);

%dfs function
function dfs(x, y, c, dx, dy)
global w;  
global g;
w(x, y) = c;

for i = 1:8
    nx = x + dx(i);
    ny = y + dy(i);
    if nx >= 1 && nx <= 751 && ny >= 1 && ny <= 752 && g(nx, ny) && ~w(nx, ny)
        dfs(nx, ny, c, dx, dy);
    end
end

end
