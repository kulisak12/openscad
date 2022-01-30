$fn = 40;
size = 11.7;

module outerShape() {
	hull() {
		translate([-size, 0]) circle(d=32);
		translate([size, 0]) circle(d=32);
	}
}

module innerShape() {
	hull() {
		translate([-size, 0]) circle(d=24);
		translate([size, 0]) circle(d=24);
	}
}

module screwHole() {
	a = 3.2;
	translate([0, 0, -0.01]) linear_extrude(height=0.4*6) {
		polygon(points=[
			[0, a],
			[sin(60)*a, cos(60)*a],
			[sin(120)*a, cos(120)*a],
			[0, -a],
			[sin(-120)*a, cos(-120)*a],
			[sin(-60)*a, cos(-60)*a],
		]);
	}
	cylinder(d = 3.2, h = 1.01*6);
}

module clipIn() {
	difference() {
		outerShape();
		innerShape();
		translate([10, 16]) rotate([0, 0, 50]) square(30, center=true);
		translate([-10, 16]) rotate([0, 0, -50]) square(30, center=true);
	}
}

module screwHolder(length) {
	difference() {
		translate([-53.4/2, -16, 8 - length]) cube([53.4, 4, length]);
		translate([23.5, -11, 4]) rotate([90, 0, 0]) screwHole();
		translate([-23.5, -11, 4]) rotate([90, 0, 0]) screwHole();
	}
}

module battery1() {
	difference() {
		linear_extrude(height=3) {
			difference() {
				outerShape();
				translate([0, 13]) square([15, 32], center=true);
			}
		}
		translate([0, 1.5, 1.7]) hull() {
			translate([-11, 0, 0]) cylinder(d=12, h=2);
			translate([11, 0, 0]) cylinder(d=12, h=2);
		}
	}

	translate([0, 0, 3]) linear_extrude(height=10) clipIn();
	translate([0, 0, 13]) screwHolder(21);
}

module battery2() {
	linear_extrude(height=3) outerShape();

	translate([0, 0, 3]) linear_extrude(height=15) clipIn();
	translate([0, 0, 19]) screwHolder(27);
}

//battery1();
battery2();