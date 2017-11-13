function A = annSplit( filepath,objStr,splitFrame,label1,label2 )
% Use for vbbLabelerX
% Split a continuous object into two
    A = vbb('vbbLoadTxt',filepath);
    id = find(A.objStr==objStr);
    obj1 = vbb( 'get', A, id, objStr,splitFrame-1);
    obj2 = vbb( 'get', A, id, splitFrame);
    if nargin == 4
        obj1.lbl = label1;
    elseif nargin == 5
        obj1.lbl = label1;
        obj2.lbl = label2;
    end
    A = vbb( 'del', A, id);
    obj1.id = -1;
    obj2.id = -1;
    A = vbb( 'add', A, obj1 );
    A = vbb( 'add', A, obj2 );
end

