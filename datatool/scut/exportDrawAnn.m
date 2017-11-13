% s = 0;
% v = 2;
% f = 1375;
load list
for i = 1:numel(list)
s = list(i,1);
v = list(i,2);
f = list(i,3);
s = s+1;
v = v+1;
tdir = 'example/';
[pthl,setIds,vidIds] = dbInfo('scut');
pth = pthl;

name=sprintf('set%02d/V%03d',setIds(s),vidIds{s}(v));
A=vbb('vbbLoadTxt',[pth '/annotations/' name]);
objList = A.objLists{f};
objLabel = A.objLbl([objList.id]);
n = numel(objList);

sr=seqIo([pth '/videos/' name '.seq'],'reader'); info=sr.getinfo();
sr.seek(f-1); I=sr.getframe();
fig = figure(11);imshow(I,'border','tight');

lw = 2;

for i = 1:n
    pos = objList(i).pos;
    occ = objList(i).occl;
    id  = objList(i).id;
    lbl = A.objLbl{id};
    
    switch lbl
        case 'walk_person'
            lbl = 'walk person';
            col = 'g';
            ls  = '-';            
        case 'ride_person'
            lbl = 'ride person';
            col = 'r';
            ls  = '-';
        case 'squat_person'
            lbl = 'squat person';
            col = 'b';
            ls  = '-';
        case 'people'
            col = 'y';
            ls  = '-';
        case 'person?'
            col = 'm';
            ls  = '-';
        case 'people?'
            col = 'y';
            ls  = '-';       
    end
    %如果标记了遮挡,则线性为--
    if occ == 1
        ls = '--';
    end
    
    hs = bbApply( 'draw', pos, col, lw, ls);
%     ht=text(pos(1),pos(2)-10, lbl);
%     set(ht,'color','w','FontSize',10,'FontWeight','bold');
end
name(6) = '_';
saveas(gcf,[tdir name '_I' int2str2(f,5)],'fig');
end




