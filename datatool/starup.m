
curdir = fileparts(mfilename('fullpath'));
addpath(curdir);
addpath(genpath(fullfile(curdir, 'kaist')));
addpath(genpath(fullfile(curdir, 'caltech')));
addpath(genpath(fullfile(curdir, 'scut')));
addpath(genpath(fullfile(curdir, 'util')));
addpath(genpath(fullfile(curdir, 'summary')));
cd(curdir);