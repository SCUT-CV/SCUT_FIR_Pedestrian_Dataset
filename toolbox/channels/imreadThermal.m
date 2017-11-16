function It = imreadThermal(file)
    I = imread(file);
    It = rgb2gray(I);
end