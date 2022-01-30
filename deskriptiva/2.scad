u = 10;
include<deskriptiva.scad>

color("Lime")
transform([-2, 5, 2], [3, 2, 0], [1, 1, 5])
unitTriangle();

color("Yellow")
transform([-2, 2, 0], [0, 5, 5], [2, 2, 0])
unitTriangle();