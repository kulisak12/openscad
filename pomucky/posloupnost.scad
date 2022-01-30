$fn = 20;
include<../roundedCube.scad>;

h = 3;
round = 1;
a = 10;

module row(n) {
	for (i = [1 : n]) {
		translate([i*a, 0, 0]) roundedCube([a, a, h], round);
	}
}

row(3);


