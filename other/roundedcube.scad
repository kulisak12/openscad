module roundedCube(size, r) {
	hull() {
		translate([r, r, r]) sphere(r);
		translate([size[0] - r, r, r]) sphere(r);
		translate([size[0] - r, size[1] - r, r]) sphere(r);
		translate([r, size[1] - r, r]) sphere(r);
		translate([r, r, size[2] - r]) sphere(r);
		translate([size[0] - r, r, size[2] - r]) sphere(r);
		translate([size[0] - r, size[1] - r, size[2] - r]) sphere(r);
		translate([r, size[1] - r, size[2] - r]) sphere(r);
	}
}

$fn = 20;
roundedCube([50, 50, 50], 5);