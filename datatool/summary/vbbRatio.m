function vbbRatio
pth = 'F:\DataSet\KAIST\';
if ~exist('allbboxList', 'var')
    load([pth 'analysis.mat']);
end

% RENAME 
% type = 'Person';
type = 'person'; % KAIST
if (strcmp(type,'Person'))
    index1 = strcmp([allbboxList.label]','walk_person');
    index2 = strcmp([allbboxList.label]','ride_person');
    index = index1 | index2;
else
    index = strcmp([allbboxList.label]',type);
end
ratio = [allbboxList(index).ratio];
rmin = min(ratio);
rmax = max(ratio);
% rmin = 0.05;
% rmax = 1;
% rlog = linspace(log(rmin),log(rmax),64);
% rbin = exp(rlog);
rbin = linspace(0,1,64);

rdist = figure();
raxes = axes('Parent',rdist);
hold(raxes,'on');

% Create histogram
rdist = histogram(ratio,'Parent',raxes,'Normalization','probability',...
                  'BinEdges',rbin);

% Create xlabel
xlabel('aspect ratio (w/h)','FontSize',14);

% Create ylabel
ylabel('Probability','FontSize',14);

% Uncomment the following line to preserve the X-limits of the axes
% xlim(axes1,[0 256]); Set the remaining axes properties
set(raxes,'XMinorTick','on','XScale','linear','XTick',[0 0.2 0.4 0.6 0.8 1],...
    'YGrid','on','XLim',[0 1]);

% Create title&save
switch(lower(type))
    case 'ride_person'
        title('Ride\_Person aspect ratio','FontSize',14);
        saveas(rdist,[pth 'Ride_Person Aspect Ratio Distribution(Probability)'],'png');
    case 'walk_person'
        title('Walk\_Person aspect ratio','FontSize',14);
        saveas(rdist,[pth 'Walk_Person Aspect Ratio Distribution(Probability)'],'png');
    case 'person'
        title('Person aspect ratio','FontSize',14);
        saveas(rdist,[pth 'Person Aspect Ratio Distribution(Probability)'],'png');
end

% Summarize distribution parameters
file = fopen([pth type '_ratiolog.txt'],'w');

fprintf(file,[type ' Ratio Distribution\n']);
fprintf(file,[repmat('-',1,76) '\n']);
fprintf(file,'Min : %.2f\n', rmin);
fprintf(file,'Max : %.2f\n', rmax);
fprintf(file,'Median : %.2f\n', median(ratio));
fprintf(file,'Math Average : %.2f\n', sum(ratio)/length(ratio));
fprintf(file,'Log-Average : %.2f\n', exp(sum(log(ratio))/length(ratio)));
end