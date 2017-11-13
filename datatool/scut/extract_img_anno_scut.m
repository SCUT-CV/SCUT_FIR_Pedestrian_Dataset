function extract_img_anno_scut(pth, tDir)
% extract_img_anno_scut()
% 
% Copyright (c) 2017, Zhewei Xu
% -------------------------------------------------------
% pth = 'F:\DataSet\SCUT_FIR_101\datasets';
% tDir = 'F:\DataSet\SCUT_FIR_101\datasets\extract\';

type='test'; skip=25;
dbInfo(['scut' type]);
type=['test' int2str2(skip,2)];
if(~exist([tDir type '/annotations'],'dir'))
    dbExtract_scut([tDir type],1,skip,pth); 
end

type='train'; skip=2;
dbInfo(['scut' type]);
type=['train' int2str2(skip,2)];
if(~exist([tDir type '/annotations'],'dir'))
    dbExtract_scut([tDir type],1,skip,pth); 
end

end


