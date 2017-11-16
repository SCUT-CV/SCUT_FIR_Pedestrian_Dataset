function made = mkdir_if_missing(path)
% path 文件夹如果不存在，则新建一个文件夹
% INPUT
%     - path [] 文件夹路径
% OUPUT 
%     - made [] 如果新建了文件夹为true，否则为false
% EXAMPLE
%     made = mkdir_if_missing('./datasets')
% -------------------------------------------------------
% Copyright (c) 2017, Zhewei Xu
% -------------------------------------------------------
made = false;
if exist(path, 'dir') == 0
  mkdir(path);
  made = true;
end
