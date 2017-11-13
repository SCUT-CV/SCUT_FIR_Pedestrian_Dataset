function [pth,setIds,vidIds,skip,ext,dbName] = dbInfo( name1, pth )
% Specifies data amount and location.
%
% 'name' specifies the name of the dataset. Valid options include: 'Usa',
% 'UsaTest', 'UsaTrain', 'InriaTrain', 'InriaTest', 'Japan', 'TudBrussels',
% 'ETH', and 'Daimler'. If dbInfo() is called without specifying the
% dataset name, defaults to the last used name (or 'UsaTest' on first call
% to dbInfo()). Finally, one can specify a subset of a dataset by appending
% digits to the end of the name (eg. 'UsaTest01' indicates first set of
% 'UsaTest' and 'UsaTest01005' indicate first set, fifth video).
%
% USAGE
%  [pth,setIds,vidIds,skip,ext] = dbInfo( [name] )
%
% INPUTS
%  name     - ['UsaTest'] specify dataset, caches last passed in name
%
% OUTPUTS
%  pth      - directory containing database
%  setIds   - integer ids of each set
%  vidIds   - [1xnSets] cell of vectors of integer ids of each video
%  skip     - specify subset of frames to use for evaluation
%  ext      - file extension determining image format ('jpg' or 'png')
%
% EXAMPLE
%  [pth,setIds,vidIds,skip,ext] = dbInfo
%
% See also
%
% Caltech Pedestrian Dataset     Version 3.2.1
% Copyright 2014 Piotr Dollar.  [pdollar-at-gmail.com]
% Licensed under the Simplified BSD License [see external/bsd.txt]

persistent name; % cache last used name
if(nargin && ~isempty(name1)), name=lower(name1); else
  if(isempty(name)), name='usatest'; end; end; name1=name;

vidId=str2double(name1(end-2:end)); % check if name ends in 3 ints
if(isnan(vidId)), vidId=[]; else name1=name1(1:end-3); end
setId=str2double(name1(end-1:end)); % check if name ends in 2 ints
if(isnan(setId)), setId=[]; else name1=name1(1:end-2); end

switch name1
  case 'usa' % Caltech Pedestrian Datasets (all)
    setIds=0:10; subdir='USA'; skip=30; ext='jpg';
    vidIds={0:14 0:5 0:11 0:12 0:11 0:12 0:18 0:11 0:10 0:11 0:11};
  case 'usatrain' % Caltech Pedestrian Datasets (training)
    setIds=0:5; subdir='USA'; skip=30; ext='jpg';
    vidIds={0:14 0:5 0:11 0:12 0:11 0:12};
  case 'usatest' % Caltech Pedestrian Datasets (testing)
    setIds=6:10; subdir='USA'; skip=30; ext='jpg';
    vidIds={0:18 0:11 0:10 0:11 0:11};
  case 'inriatrain' % INRIA peds (training)
    setIds=0; subdir='INRIA'; skip=1; ext='png'; vidIds={0:1};
  case 'inriatest' % INRIA peds (testing)
    setIds=1; subdir='INRIA'; skip=1; ext='png'; vidIds={0};
  case 'japan' % Caltech Japan data (not publicly avialable)
    setIds=0:12; subdir='Japan'; skip=30; ext='jpg';
    vidIds={0:5 0:5 0:3 0:5 0:5 0:5 0:5 0:5 0:4 0:4 0:5 0:5 0:4};
  case 'tudbrussels' % TUD-Brussels dataset
    setIds=0; subdir='TudBrussels'; skip=1; ext='png'; vidIds={0};
  case 'eth' % ETH dataset
    setIds=0:2; subdir='ETH'; skip=1; ext='png'; vidIds={0 0 0};
  case 'daimler' % Daimler dataset
    setIds=0; subdir='Daimler'; skip=1; ext='png'; vidIds={0};
  case 'pietro'
    setIds=0; subdir='Pietro'; skip=1; ext='jpg'; vidIds={0};
    
  %SCUT FIR Pedestrian Datasets 101
  case 'scut'
    setIds=0:20; subdir='scut'; skip=25; ext='jpg';
    vidIds={0:2 0:3 0:1 0:2 0:11 0:10 0:6 0:1 0:2 0:1 0 ...
            0:3 0:3 0:1 0:2 0:11 0:9  0:7 0:1 0:2 0:1};
  case 'scuttrain'
    setIds=0:10; subdir='scut'; skip=25; ext='jpg';
    vidIds={0:2 0:3 0:1 0:2 0:11 0:10 0:6 0:1 0:2 0:1 0};
  case 'scuttest'
    setIds=11:20; subdir='scut'; skip=25; ext='jpg';
    vidIds={0:3 0:3 0:1 0:2 0:11 0:9  0:7 0:1 0:2 0:1};
  
   % KAIST Multispectral Pedestrian Dataset (CVPR15)
  case 'kaist-train-all'
    setIds=0:5;     subdir='kaist'; skip=20; ext='png';     % Captured at 20fps
    vidIds={0:8 0:5 0:4 0:1 0:1 0}; dbName = 'kaist';
  case 'kaist-test-all'
    setIds=6:11;    subdir='kaist'; skip=20; ext='png'; 
    vidIds={0:4 0:2 0:2 0 0:1 0:1}; dbName = 'kaist';
  case 'kaist-test-day'
    setIds=6:8;    subdir='kaist'; skip=20; ext='png';
    vidIds={0:4 0:2 0:2}; dbName = 'kaist';
  case 'kaist-test-night'
    setIds=9:11;    subdir='kaist'; skip=20; ext='png';
    vidIds={0 0:1 0:1}; dbName = 'kaist';
  % KAIST All-Day Visual Place Recognition Dataset (CVPRW15 - VPRICE))
  case 'kaist-place'
    setIds=0:5;     subdir='place'; skip=20; ext='png';     % Captured at 20fps
    vidIds={0:3 0:3 0:3 0:3 0:3 0:3 }; dbName = 'kaist-place';
  % Add by Zhewei
  case 'kaist-all'
    setIds=0:11;    subdir='kaist'; skip=20; ext='jpg';
    vidIds={0:8 0:5 0:4 0:1 0:1 0 0:4 0:2 0:2 0 0:1 0:1}; dbName = 'kaist';

    otherwise, error('unknown data type: %s',name);
end

% optionally select only specific set/vid if name ended in ints
if(~isempty(setId)), setIds=setIds(setId); vidIds=vidIds(setId); end
if(~isempty(vidId)), vidIds={vidIds{1}(vidId)}; end

% actual directory where data is contained
if ~exist( 'pth', 'var' )
    pth=fileparts(mfilename('fullpath'));
    pth=[pth filesep 'data-' subdir];
end

end
