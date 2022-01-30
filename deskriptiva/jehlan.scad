u = 10;
include<deskriptiva.scad>

difference() {
	oneAxisTransform([0, 4, 0], [-4, 2.5, 0], [0, 4, 6.5])
	unitPyramid(6);

	translate([4.5*u, -100, 0]) rotate([0, -60, 0]) cube(200);
}