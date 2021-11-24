function [W,Q] = disTipQ4(order,phi,nodes,tip,nsubDiv,intType)

global elemType plothelp

epsilon  = 0.00001;
corner   = [1 2 3 4 1];
node     = [-1 -1; 1 -1; 1 1; -1 1];

coord = zeros(1,2);
ksi   = 0;
eta   = 0;
iter  = 10;

inc = 1;
while (inc < iter)
    [N,dNdxi]=lagrange_basis(elemType,coord);   % compute shape functions
    x = N'*nodes(:,1);
    y = N'*nodes(:,2);
    df1dr = dNdxi(:,1)' * nodes(:,1);
    df1ds = dNdxi(:,2)' * nodes(:,1);
    df2dr = dNdxi(:,1)' * nodes(:,2);
    df2ds = dNdxi(:,2)' * nodes(:,2);
 
    f1 = x - tip(1);
    f2 = y - tip(2);

    detF = df1dr*df2ds - df1ds*df2dr ;  %Jacobien

    invf(1,1) =  1.0/detF * df2ds;
    invf(1,2) = -1.0/detF * df1ds;
    invf(2,1) = -1.0/detF * df2dr;
    invf(2,2) =  1.0/detF * df1dr;

    ksi = ksi - invf(1,1)*f1 - invf(1,2)*f2;
    eta = eta - invf(2,1)*f1 - invf(2,2)*f2;

    coord(1) = ksi;
    coord(2) = eta;

    if( (abs(ksi - coord(1)) < epsilon) && ...
            (abs(eta - coord(2)) < epsilon) )
        inc  = iter + 1;
        ntip = coord;
    else
        inc = inc + 1;
    end
end

% loop on element edges
for i = 1:4
    n1 = corner(i);
    n2 = corner(i+1);
    if phi(n1)*phi(n2) < 0
        r    = phi(n1)/(phi(n1)-phi(n2));
        pnt  = (1-r)*node(n1,:)+r*node(n2,:);
        node = [node;pnt];
    end
end

% insert the tip into the Delaunay triangulation
node = [node;ntip];

%do delaunay triangulation
tri = delaunay(node(:,1),node(:,2)) ;
tri = tricheck(node,tri) ;

if( nsubDiv == 0)
    triangles = tri ;
    triNodes = node ;
else
    [triNodes,triangles] = subTriXFEM(node,tri,nsubDiv);
end

node = triNodes ;
tri = triangles ;
% 
% % % ---- plot of the triangulation ------------
% % % -------------------------------------------
% v=get(0,'ScreenSize');
if plothelp
 %figure('Color',[1 1 1],'Position', [0 0 0.4*v(1,3) 0.4*v(1,4)])
 figure(2)
 nd=[];
    for igp = 1 : size(node,1)
         gpnt = node(igp,:);
         [N,dNdxi]=lagrange_basis(elemType,gpnt);
         Gpnt = N' * nodes; % global GP
         nd = [nd;Gpnt];
    end
 triplot(tri, nd(:,1),nd(:,2),'g')
end
% 
% % ------------------------------------------

% loop over subtriangles to get quadrature points and weights
pt = 1;
for e=1:size(tri,1)
    [w,q] = quadrature(order,intType,2);
    t = size(w,1) ;
%     disp(['Number of integration points     ',  num2str(t)])
    % transform quadrature points into the parent element
    coord = node(tri(e,:),:);
    a = det([coord,[1;1;1]])/2;
    if ( a<0 )  % need to swap connectivity
        coord=[coord(2,:);coord(1,:);coord(3,:)];
        a = det([coord,[1;1;1]])/2;
    end

    if ( a~=0 )
        for n=1:length(w)
            N = lagrange_basis('T3',q(n,:));
            Q(pt,:) = N'*coord;
            W(pt,1) = 2*w(n)*a;
            pt = pt+1;
        end
    end

end
