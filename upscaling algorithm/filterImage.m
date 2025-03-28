function output =  filterImage(image)

    [~, cols, ~] = size(image);
    
    new_cols = ceil(cols/4) * 4;
    
    padding_needed = new_cols - cols;
    
    padded_image = padarray(image, [0 padding_needed 0], 0, 'post');

    image = padded_image;

    [m, n] = size(image);
    box_size = 2;
    num_boxes_m = m - box_size + 1;
    num_boxes_n = n - box_size + 1;
    output = zeros(m, n); 


    for i = 1:num_boxes_m
        for j = 1:num_boxes_n

            box = image(i:i+box_size-1, j:j+box_size-1);
            avg_value = sum(box(:)) / (numel(box));
            output(i:i+box_size-1, j:j+box_size-1) = avg_value;
        end
    end

%last row
last_row_start = m - box_size + 2;
last_row_end = m;
for j = 1:num_boxes_n
    box_last_row = image(last_row_start:last_row_end, j:j+box_size-1);

    %if the box is not completely filled, fill the remaining elements with 0
    if numel(box_last_row) < box_size^2
        [r, ~] = size(box_last_row);
        box_last_row(r+1:box_size, :) = 0;
    end
    
    avg_value_last_row = sum(box_last_row(:)) / (numel(box_last_row) - 2);
    output(last_row_start:last_row_end, j:j+box_size-1) = avg_value_last_row;
end
end
