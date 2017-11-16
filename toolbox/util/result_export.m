function result_export(name,type,imgDir)
% Convert bbsNm to the style use for dbEval.
% Two style differenc is:
% bbsNm the first col is the index of sample and all result in one file.
% The dbEval style, the first col is frame number of the video, and one 
% video for one file. There is a dir struct.
% 
% INPUT
%     name   - [] detector name and pth, eg. fullfile(pwd,name)
%     type   - [] test condition
%     imgDir - [] the dir contains all test img
% OUTPU
% 
% EXAMPLE
%
% See also acfDemoSCUT bbGt dbEval
% 
% --------------------------------------------------------
% Computer Vision 
% Copyright (c) 2017, Zhewei Xu
% Licensed under The MIT License [see LICENSE for details]
% --------------------------------------------------------

cache_dir = fullfile(pwd,[name '-' type]);
mkdir_if_missing(cache_dir);
bbsNm=[name type 'Dets.txt'];
imgNms = bbGt('getFiles',{imgDir});
res_boxes = load(bbsNm,'-ascii');
for i = 1:numel(imgNms)
    [~,imgName] = fileparts(imgNms{i});
    sstr = strsplit(imgName, '_');
    mkdir_if_missing(fullfile(cache_dir,sstr{1}));
    fid = fopen(fullfile(cache_dir, sstr{1}, [sstr{2} '.txt']), 'a');
    boxes = res_boxes(res_boxes(:,1)==i,2:end);
    for j = 1:size(boxes, 1)
        fprintf(fid, '%d,%f,%f,%f,%f,%f\n', ...
            str2double(sstr{3}(2:end))+1, boxes(j, :));
    end
    fclose(fid);
end
end