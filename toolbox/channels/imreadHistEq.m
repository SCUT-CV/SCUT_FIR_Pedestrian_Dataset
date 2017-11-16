function I = imreadHistEq( file )
I = imread( file );
% I(:,:,4) = histeq(I(:,:,4));
I(:,:,4) = I(:,:,4) .* (255.0 / 141);
end
