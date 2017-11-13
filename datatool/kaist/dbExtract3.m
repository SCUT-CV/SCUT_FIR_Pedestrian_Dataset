function dbExtract3( pth, tDir, type, flatten, skip )
% Extract database to directory of images and ground truth text files.
%
% Call 'dbInfo(name)' first to specify the dataset. The format of the
% ground truth text files is the format defined and used in bbGt.m.
%
% USAGE
%  dbExtract( tDir, flatten )
%
% INPUTS
%  tDir     - [] target dir for image data (defaults to dataset dir)
%  flatten  - [0] if true output all images to single directory
%  skip     - [] specify frames to extract (defaults to skip in dbInfo)
%
% OUTPUTS
%
% EXAMPLE
%  dbInfo('InriaTest'); dbExtract;
%
% See also dbInfo, bbGt, vbb
%
% Caltech Pedestrian Dataset     Version 3.2.1
% Copyright 2014 Piotr Dollar.  [pdollar-at-gmail.com]
% Licensed under the Simplified BSD License [see external/bsd.txt]

[~,setIds,vidIds,~,~,dbName] = dbInfo();
if(nargin<1 || isempty(pth)), pth=dbInfo(); end
if(nargin<2 || isempty(tDir)), tDir=pth; end
if(nargin<3 || isempty(flatten)), flatten=0; end
if(nargin<4 || isempty(skip)), [~,~,~,skip]=dbInfo(); end

% if strcmp( dbName, 'kaist' )
%     % create local copy of fName which is in a imagesci/private
% %     sName = [fileparts(which('imread.m')) filesep 'private' filesep 'pngreadc.mexw64'];
%     sName = [fileparts(which('imread.m')) filesep 'private' filesep 'pngreadc.mexa64'];
%     tName = ['.' filesep 'pngreadc.mexa64'];
%     if(~exist(tName,'file')), copyfile(sName,tName); end
% end

for s=1:length(setIds)
    ticId = ticStatus(['Extract set' num2str(setIds(s)) ':'],0.2,1);
  for v=1:length(vidIds{s})
    % load ground truth
    name=sprintf('set%02d/V%03d',setIds(s),vidIds{s}(v));
    n = numel(dir([pth '/annotations/' name]))-2;
    if(flatten), post=''; else post=[name '/']; end
    if(flatten), f=[name '_']; f(6)='_'; else f=''; end
    fs=cell(1,n); 
    for i=1:n
        fs{i}=['I' int2str2(i-1,5)];
    end
    % extract images
    tid=[tDir '/images/' post]; if(~exist(tid,'dir')), mkdir(tid); end
    tad=[tDir '/annotations/' post]; if(~exist(tad,'dir')), mkdir(tad); end
    for i=skip-1:skip:n-1
      tif=[tid f fs{i+1} '.jpg'];
      cif=[pth '/images/' name '/' type '/' fs{i+1} '.jpg'];
      copyfile(cif,tif);
      taf=[tad f fs{i+1} '.txt'];
      caf=[pth '/annotations/' name '/' fs{i+1} '.txt'];
      copyfile(caf,taf);
    end
    tocStatus(ticId,v/length(vidIds{s})); 
  end
end
