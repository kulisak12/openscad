$fn = 20;
include<../roundedCube.scad>;

h = 3;
round = 1;

a = 45;
b = 35;

roundedCube([a, a, h], round);
//roundedCube([a, b, h], round);
//roundedCube([b, b, h], round);