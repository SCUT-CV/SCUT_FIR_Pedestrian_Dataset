[~,setIds,vidIds,~,~,dbName] = dbInfo('kaist-all');
pth = 'F:/Code/method/piotr-toolbox-kaist/data-kaist';

%% convert lwir imgs to avi
if(0)
type = 'lwir';
for s=1:length(setIds)
      tDir = sprintf('F:/KAIST/avi/set%02d',setIds(s));
      if(~exist(tDir,'dir')), mkdir(tDir);end
  for v=1:length(vidIds{s})
      sname   = sprintf('%s/%s_V%03d',tDir,upper(type),vidIds{s}(v));
      dirname = sprintf('videos/set%02d/V%03d/%s',setIds(s),vidIds{s}(v),type);
      pic = dir([pth '/' dirname '/*.jpg']);
      a = size(pic);
      num = a(1);
      vidObj = VideoWriter([sname '.avi']);
%       vidObj.CompressionRatio = 1;
%       vidObj.Height = 512;
%       vidObj.Width = 640;
%       vidObj.FrameRate = 20;
      open(vidObj);
      for i=1:num
          iname = sprintf('%s/%s/I%05d.jpg',pth,dirname,i-1);
          im(:,:,:,i)=imread(iname);
          imshow(im(:,:,:,i),'border','tight');
          currFrame=getframe;
          writeVideo(vidObj,currFrame);
      end
      close(vidObj);
      disp(sname);
  end
end
end

%% convert visible imgs to avi
if(0)
type = 'visible';
for s=1:length(setIds)
      tDir = sprintf('F:/KAIST/avi/set%02d',setIds(s));
      if(~exist(tDir,'dir')), mkdir(tDir);end
  for v=1:length(vidIds{s})
      sname   = sprintf('%s/%s_V%03d',tDir,upper(type),vidIds{s}(v));
      dirname = sprintf('videos/set%02d/V%03d/%s',setIds(s),vidIds{s}(v),type);
      pic = dir([pth '/' dirname '/*.jpg']);
      a = size(pic);
      num = a(1);
      vidObj = VideoWriter([sname '.avi']);
%       vidObj.CompressionRatio = 1;
%       vidObj.Height = 512;
%       vidObj.Width = 640;
%       vidObj.FrameRate = 20;
      open(vidObj);
      for i=1:num
          iname = sprintf('%s/%s/I%05d.jpg',pth,dirname,i-1);
          im(:,:,:,i)=imread(iname);
          imshow(im(:,:,:,i),'border','tight');
          currFrame=getframe;
          writeVideo(vidObj,currFrame);
      end
      close(vidObj);
      disp(sname);
  end
end
end

%% conver avi to seq
if(1)
info.width = 0;
info.height = 0;
info.fps = 0;
info.quality = 100; 
info.codec = 'jpg';
pth = 'F:/KAIST/avi';
dth = 'F:/KAIST/seq';
type= {'lwir','visible'};
for s=1:length(setIds)
  pDir = sprintf('%s/set%02d',pth,setIds(s));
  dDir = sprintf('%s/set%02d',dth,setIds(s));
  if(~exist(dDir,'dir')), mkdir(dDir);end
  for v=1:length(vidIds{s})
      sname   = sprintf('/%s_V%03d',upper(type{1}),vidIds{s}(v));
      disp(['Start convert:' sname]);
      seqIo( [dDir sname '.seq'], 'frImgs', info, 'aviName', [pDir sname '.avi']);
      disp(['Start convert:' sname]);
      sname   = sprintf('/%s_V%03d',upper(type{2}),vidIds{s}(v));
      seqIo( [dDir sname '.seq'], 'frImgs', info, 'aviName', [pDir sname '.avi']);
  end
end
end







