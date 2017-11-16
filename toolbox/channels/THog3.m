function H = THog3( I )

if(nargin<1 || isempty(I)), H=single([]);   return; end

binSize = 4;
H = vl_hog( single(I), binSize );

end