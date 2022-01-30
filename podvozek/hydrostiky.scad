$fn = 25;

module screwHole() {
	translate([0, 0, -0.01]) cylinder(d = 6, h = 0.4*6);
	cylinder(d = 3, h = 1.01*6);
}

module oneTube(includeBack) {
	if (includeBack) translate([0, 0, -3]) cylinder(d=28, h=3);
	linear_extrude(height=10) {
			difference() {
				circle(d=28);
				circle(d=22);
				translate([5, 19]) rotate([0, 0, 30]) square(30, center=true);
				translate([-5, 19]) rotate([0, 0, -30]) square(30, center=true);
			}
		}
}

module hydrostik(includeBack) {
	

	translate([-13, 0, 0]) oneTube(includeBack);
	translate([13, 0, 0]) oneTube(includeBack);

	#translate([-35, -15, includeBack ? -3 : 0]) difference() {
		cube([70, 4, includeBack ? 13 : 10]);
		translate([5, 5, includeBack ? 6.5 : 5]) rotate([90, 0, 0]) screwHole();
		translate([65, 5, includeBack ? 6.5 : 5]) rotate([90, 0, 0]) screwHole();
	}
}

hydrostik(true);
translate([0, 40, 0]) hydrostik(false);