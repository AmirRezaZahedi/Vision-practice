clc;clear;close all;
orginal_House = (im2double(imread("Cameraman.png")));
before_House = (im2double(imread("LR_Cameraman.png")));

my_resized_House = main_algorithm(before_House, 2);
disp(psnr(my_resized_House, orginal_House));


