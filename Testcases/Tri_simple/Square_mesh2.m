%  Matlab mesh
% untitled, Created by Gmsh
% ASCII
clear msh;
msh.nbNod = 24;
msh.POS = [
0 -0.5 0;
1 -0.5 0;
1 0.5 0;
0 0.5 0;
0 -0.5 0;
1 -0.5 0;
1 0.5 0;
0 0.5 0;
0.5 -0.5 0;
1 0 0;
0.5 0.5 0;
0 0 0;
0.5 -0.5 0;
1 0 0;
0.5 0.5 0;
0 0 0;
0.25 -0.25 0;
0.625 -0.1249999999999999 0;
0.71875 0.2187500000000001 0;
0.345703125 0.154296875 0;
0.75 0.25 0;
0.625 -0.1250000000000001 0;
0.2812499999999999 -0.2187500000000001 0;
0.345703125 0.154296875 0;
];
msh.MAX = max(msh.POS);
msh.MIN = min(msh.POS);
msh.LINES =[
 1 9 0
 9 2 0
 2 10 0
 10 3 0
 3 11 0
 11 4 0
 4 12 0
 12 1 0
 5 13 0
 13 6 0
 6 14 0
 14 7 0
 7 15 0
 15 8 0
 8 16 0
 16 5 0
];
msh.TRIANGLES =[
 2 18 9 0
 10 18 2 0
 4 20 11 0
 12 20 4 0
 3 19 10 0
 11 19 3 0
 9 17 1 0
 1 17 12 0
 18 20 17 0
 17 20 12 0
 9 18 17 0
 19 20 18 0
 11 20 19 0
 10 19 18 0
 6 22 13 0
 14 22 6 0
 8 24 15 0
 16 24 8 0
 13 23 5 0
 5 23 16 0
 7 21 14 0
 15 21 7 0
 21 24 22 0
 15 24 21 0
 21 22 14 0
 22 24 23 0
 23 24 16 0
 22 23 13 0
];
msh.PNT =[
 1 0
 2 0
 3 0
 4 0
 5 0
 6 0
 7 0
 8 0
];
