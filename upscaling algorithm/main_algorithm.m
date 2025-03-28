function resized = main_algorithm(original_img, resizing_factor)
    resized_upscale = imresize(original_img, resizing_factor, 'lanczos3');
    [~,~,c] = size(original_img);
    if (c == 3)
        resized1 = filterImage(resized_upscale(:,:,1));
        resized2 = filterImage(resized_upscale(:,:,2));
        resized3 = filterImage(resized_upscale(:,:,3));
        resized = cat(3, resized1, resized2, resized3);
    else
        resized = filterImage(resized_upscale);
    end
end
