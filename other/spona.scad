$fn = 20;
r = 1.5;
length = 10;
height = 40;
width = 6.8;
hook = 4;
hole = 2.8;

module block() {
	hull() {
		translate([r, r, r]) sphere(r);
		translate([r, length - r, r]) sphere(r);
		translate([r, length - r, height - r]) sphere(r);
		translate([r, r, height - r]) sphere(r);

		translate([width + hook - r, r, r]) sphere(r);
		translate([width + hook - r, length - r, r]) sphere(r);
		translate([width - r, length - r, height - r]) sphere(r);
		translate([width - r, r, height - r]) sphere(r);
	}
}

module tooth(i) {
	size = hole * (15 + i)/30;
	rotate([0, 45, 0]) cube([size, length + 0.02, size], center=true);
}

module saw() {
	numPieces = 16;
	for (i = [0:numPieces]) {
		translate([0, length/2, 2 + i * (height-11)/numPieces]) tooth(i);
	}
	translate([0, length/2, 0]) rotate([90, 0, 0]) cylinder(r=1.5, h=length+0.02, center=true);
	translate([0, length/2, 33]) rotate([90, 0, 0]) hull() {
		cylinder(r=2, h=length+0.02, center=true);
		translate([0, 2, 0]) cylinder(r=2, h=length+0.02, center=true);
	}
}

module ridge() {
	hull() {
		translate([0, length+0.01, 15]) rotate([90, 0, 0]) cylinder(r=0.7, length + 0.02);
		translate([0.1, -0.01, -1]) cube([2*0.7, length+0.02, 1]);
	}
	translate([0.8, length/2, 0]) rotate([0, 45, 0]) cube([2, length + 0.02, 2], center=true);
}

difference() {
	block();
	translate([3.6, 0, 0]) saw();
	translate([6.7, 0, 0]) ridge();
}