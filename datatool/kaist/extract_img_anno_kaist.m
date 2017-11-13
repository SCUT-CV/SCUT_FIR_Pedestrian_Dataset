% extract_img_anno_kaist()
% 
% Copyright (c) 2017, Zhewei Xu
% -------------------------------------------------------
function extract_img_anno_kaist(pth, tDir)
% pth = 'F:/DataSet/KAIST/data-kaist/';
% tDir = 'F:/DataSet/KAIST/data-kaist/extract/';

% for s=1:2
%   if(s==1), type='test'; skip=[]; else type='train'; skip=3; end
%   dbInfo(['kaist-all-' type]);
%   if(exist([tDir type '/annotations'],'dir')), continue; end
%   dbExtract3(pth,[tDir type],'lwir',1,skip);
% end
% 
type='test'; cond='day'; spec='lwir'; skip=20;
dbInfo(['kaist-' type '-' cond]);
type=[type '-' cond '-' spec '-' int2str2(skip,2)];
if(~exist([tDir type '/annotations'],'dir'))
    dbExtract3(pth,[tDir type],spec,1,skip); 
end

type='train'; cond='all'; spec='lwir'; skip=3;
dbInfo(['kaist-' type '-' cond]);
type=[type '-' cond '-' spec '-' int2str2(skip,2)];
if(~exist([tDir type '/annotations'],'dir'))
    dbExtract3(pth,[tDir type],spec,1,skip); 
end

end


