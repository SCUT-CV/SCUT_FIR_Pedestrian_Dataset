% Demo for aggregate channel features object detector on SCUT dataset.
%
% See also acfReadme.m
%
% Piotr's Computer Vision Matlab Toolbox      Version 3.40
% Copyright 2014 Piotr Dollar.  [pdollar-at-gmail.com]
% Licensed under the Simplified BSD License [see external/bsd.txt]
%
% 2015.06.02. Modified by Soonmin Hwang [smhwang-at-rcv.kaist.ac.kr]
% 2015.07.27. Some bugs are fixed. 
%   - dbInfo2.m
%   - detector/acfDemoKAIST.m
%   - detector/acfTest.m
%   - channels/chnsPyramid.m
%   - channels/TMagTOri.m (added)
% 2017.09.18. Modified by Zhewei Xu [xzhewei@gmail.com]
%   - acfDetectT.m
%   - acfModifyT.m
%   - acfTestT.m
%   - acfTrainT.m
%   - chnsComputeT.m
%   - chnsPyramidT.m
%   - chnsScalingT.m
%   - imreadThermal.m
    

%% extract training and testing images and ground truth
cd(fileparts(which('acfDemoSCUT.m'))); dataDir='../data-scut/';
% addpath( genpath( '..' ) );
skip = 75;

%% set up opts for training detector (see acfTrain)
opts=acfTrainT(); opts.modelDs=[28 13]; opts.modelDsPad=[38 19]; %opts.modelDs=[50 20.5]; opts.modelDsPad=[64 32];
opts.pPyramid.smooth=.5;
% opts.pPyramid.pChns.pColor.smooth=0; 
% opts.nWeak=[64 256 1024 4096];
opts.nWeak=[32 128 512 2048];
opts.pBoost.pTree.maxDepth=2; 
opts.pBoost.pTree.fracFtrs=1/16; 
% opts.pPyramid.pChns.pGradHist.softBin=1;
opts.pJitter=struct('flip',1);
% opts.nAccNeg=25000;
% all
opts.posGtDir=[dataDir 'train' int2str2(skip,2) '/annotations'];
opts.posImgDir=[dataDir 'train' int2str2(skip,2) '/images'];

% % pre trian pre test
% opts.name=[ 'models/AcfSCUT-RGB' ];
opts.name=[ 'models/scut/AcfSCUT-T' ];
% opts.name=[ 'models/scut/AcfSCUT-T-TM-TO-S' ];
% opts.name=[ 'models/scut/ACF-T-THOG-S' ];
% opts.name=[ 'models/AcfSCUT-RGB-T-TM-TO-THOG' ];
opts.name=[opts.name '-'  int2str2(skip,2) '-' int2str2(opts.nWeak(end),2) '-' int2str2(opts.nAccNeg,2)];

pLoad={'lbls',{'walk_person','ride_person'},'ilbls',{'people',...
      'person?','people?','squat_person'}};
evalcond = 'overall';
switch(evalcond)
    case 'overall'
    opts.pLoad = [pLoad 'hRng',[20 inf], 'vType',{'none'}];
    opts.name= [ opts.name '-overall'];
    case 'reasonable-all' % Reasonable    
    opts.pLoad = [pLoad 'hRng',[50 inf], 'vType',{'none'}];
    opts.name= [ opts.name '-reasonable-all'];
    case 'reasonable-walk' % Reasonable    
    opts.pLoad = [pLoad 'hRng',[50 inf], 'vType',{'none'}];
    opts.pLoad.lbls = {'walk_person'};
    opts.name= [ opts.name '-reasonable-walk'];
    case 'reasonable-ride' % Reasonable    
    opts.pLoad = [pLoad 'hRng',[50 inf], 'vType',{'none'}];
    opts.pLoad.lbls = {'ride_person'};
    opts.name= [ opts.name '-reasonable-ride'];
    case 'near'      % Scale-Near
    opts.pLoad = [pLoad 'hRng',[80 inf], 'vType',{'none'}];
    opts.name= [ opts.name '-near'];
    case 'medium'    % Scale-Medium
    opts.pLoad = [pLoad, 'hRng',[30 80],'vType',{'none'}];
    opts.name= [ opts.name '-medium'];
    case 'far'       % Scale-far
    opts.pLoad = [pLoad, 'hRng',[1  30],'vType',{'none'}];
    opts.name= [ opts.name '-far'];
    case 'none'      % Occlusion-None
    opts.pLoad = [pLoad, 'hRng',[55 inf],'vType',{'none'}];
    opts.name= [ opts.name '-none'];
    case 'partial'   % Occlusion-Partial
    opts.pLoad = [pLoad, 'hRng',[55 inf],'vType',{'partial'}];
    opts.name= [ opts.name '-partial'];
    otherwise
    disp('Evaluation setting default using reasonable.');
    opts.pLoad = [pLoad 'hRng',[55 inf], 'vType', {'none'} ];
    opts.name= [ opts.name '-reasonable-all'];
end

%% To handle thermal channel
opts.imreadf = @imreadThermal;

pCustom(1).enabled = 1;         % T      (T1)
pCustom(2).enabled = 0;         % TM+TO  (T2)
pCustom(3).enabled = 0;         % THOG   (T3)

pCustom(1).hFunc = @TRaw;
pCustom(2).hFunc = @TMagTOri;
pCustom(3).hFunc = @THog;

pCustom(1).name = 'T';
pCustom(2).name = 'TM+TO';
pCustom(3).name = 'THOG';

pCustom(1).pFunc = {};
pCustom(2).pFunc = {};
pCustom(3).pFunc = {};

opts.pPyramid.pChns.pCustom = pCustom;

%% train detector (see acfTrain)
detector = acfTrainT( opts );

%% modify detector (see acfModify)
pModify=struct('cascThr',-1,'cascCal',.025);
detector=acfModifyT(detector,pModify);

%% run detector on a sample image (see acfDetect)
imgDir = [dataDir 'test25' '/images'];       gtDir = [dataDir 'test25' '/annotations']; 

imgNms=bbGt('getFiles', {imgDir});
I=imread(imgNms{105}); I = rgb2gray(I); tic, bbs=acfDetectT(I,detector); toc
figure(3); imshow(I); bbApply('draw',bbs); pause(.1);

%% test detector and plot roc (see acfTest)
evalcond = 'far';
switch(evalcond)
    case 'overall'
    opts.pLoad = [pLoad 'hRng',[20 inf], 'vType',{'none','partial'},'xRng',[10 700],'yRng',[10 570]];
    case 'reasonable-all' % Reasonable    
    pLoad = [pLoad, 'hRng',[50 inf],'vType',{{'none','partial'}},'xRng',[10 700],'yRng',[10 570]];
    case 'reasonable-walk' % Reasonable    
    pLoad = [pLoad, 'hRng',[50 inf],'vType',{{'none','partial'}},'xRng',[10 700],'yRng',[10 570]];
    pLoad.lbls = {'walk_person'};
    case 'reasonable-ride' % Reasonable    
    pLoad = [pLoad, 'hRng',[50 inf],'vType',{{'none','partial'}},'xRng',[10 700],'yRng',[10 570]];
    pLoad.lbls = {'ride_person'};
    case 'near'      % Scale-Near
    pLoad = [pLoad, 'hRng',[80 inf],'vType',{{'none'}},'xRng',[10 700],'yRng',[10 570]];
    case 'medium'    % Scale-Medium
    pLoad = [pLoad, 'hRng',[30  80],'vType',{{'none'}},'xRng',[10 700],'yRng',[10 570]];
    case 'far'       % Scale-far
    pLoad = [pLoad, 'hRng',[20    30],'vType',{{'none'}},'xRng',[10 700],'yRng',[10 570]];
    case 'none'      % Occlusion-None
    pLoad = [pLoad, 'hRng',[50 inf],'vType',{{'none'}},'xRng',[10 700],'yRng',[10 570]];
    case 'partial'   % Occlusion-Partial
    pLoad = [pLoad, 'hRng',[50 inf],'vType',{{'partial'}},'xRng',[10 700],'yRng',[10 570]];
    otherwise
    disp('Evaluation setting default using reasonable.');
    pLoad = [pLoad, 'hRng',[50 inf],'vType',{{'none','partial'}},'xRng',[10 700],'yRng',[10 570]];
end

if(ishghandle(11)),close(11);end
[miss,~,gt,dt]=acfTestT('name',opts.name,'imgDir',imgDir,...
  'gtDir',gtDir,'pLoad',pLoad,...
  'pModify',pModify,'reapply',1,'show',11,...
  'lims', [3.1e-3 3.1e1 .2 1],'type', evalcond, 'clr', 'r', 'lineSt', '-');
result_export(opts.name,evalcond,imgDir);
fprintf('%s%s log-average miss rate = %.2f%%\n',opts.name,evalcond,miss*100);