$fn = 25;

round = 3;
thickness = 3.5;
vertexes = [
	[0 + round, 0],
	[7 + 0.6*round, 23.5 - 0.8*round],
	[65 + 0.6*round, 42 - 0.8*round],
	[95 - 0.6*round, 80 - 0.8*round],
	[251 - 0.6*round, 80 - 0.8*round],
	[280 - 0.6*round, 42 - 0.8*round],
	[326 - 0.6*round, 21 - 0.8*round],
	[336 - 0.8*round, 14 - 0.6*round],

	[336 - 0.8*round, -(14 - 0.6*round)],
	[326 - 0.6*round, -(21 - 0.8*round)],
	[280 - 0.6*round, -(42 - 0.8*round)],
	[251 - 0.6*round, -(80 - 0.8*round)],
	[95 - 0.6*round, -(80 - 0.8*round)],
	[65 + 0.6*round, -(42 - 0.8*round)],
	[7 + 0.6*round, -(23.5 - 0.8*round)],
];

module base() {
	linear_extrude(height = thickness) {
		minkowski() {
			polygon(points = vertexes);
			circle(r = round);
		}
	}
}

module rim() {
	linear_extrude(height = 4) {
		difference() {
			minkowski() {
				polygon(points = vertexes);
				circle(r = round);
			}
			minkowski() {
				polygon(points = vertexes);
				circle(r = round - 1);
			}
		}
	}
}

module screwHole() {
	translate([0, 0, -0.01]) cylinder(d = 6, h = 0.4*thickness);
	cylinder(d = 3, h = 1.01*thickness);
}

module invertScrewHole() {
	translate([0, 0, thickness+0.02]) mirror([0, 0, 1]) screwHole();
}

module hole(dia) {
	translate([0, 0, -0.01]) cylinder(d = dia, h = 1.01*10);
}

module podvozek() {
	// rims
	intersection() {
		union() {
			translate([0, 0, thickness]) rim();
			translate([50, -1, thickness]) cube([250, 2, 4]); // center stripe
		}
		translate([197, 0, -130]) rotate([0, -8, 0]) cube(300, center=true);
		translate([176, 0, -135]) rotate([0, 7, 0]) cube(300, center=true);
	}

	difference() {
		base();
		// front part
		translate([7, 0, 0]) screwHole();
		translate([14, 19, 0]) screwHole();
		translate([14, -19, 0]) screwHole();
		translate([40, 17, 0]) hole(5);
		translate([40, -17, 0]) hole(5);
		translate([48.5, 17, 0]) screwHole();
		translate([48.5, -17, 0]) screwHole();
		translate([59, 17, 0]) screwHole();
		translate([59, -17, 0]) screwHole();

		// middle part
		translate([96.5, 24, 0]) screwHole();
		translate([96.5, -24.5, 0]) screwHole();
		translate([105, 23, 0]) screwHole();
		translate([105.5, 31, 0]) hole(5);
		translate([154, 23.5, 0]) screwHole();
		translate([154, 31.5, 0]) hole(5);

		translate([184.5, 10.3, 0]) screwHole();
		translate([261, -12, 0]) screwHole();
		translate([262.5, 12, 0]) screwHole();
		translate([264, 35, 0]) screwHole();
		translate([269.5, 41, 0]) screwHole();

		// back part
		translate([331, 11, 0]) screwHole();
		translate([331, -11, 0]) screwHole();
		translate([316.5, 16.8, 0]) hole(5);
		translate([316.5, -16.8, 0]) hole(5);
		translate([309.5, 16.8, 0]) screwHole();
		translate([309.5, -16.8, 0]) screwHole();
		translate([298.5, 16.8, 0]) screwHole();
		translate([298.5, -16.8, 0]) screwHole();

		// for holder
		translate([137.5, 71, 0]) screwHole();
		translate([149.5, 71, 0]) screwHole();
		translate([227.5, 71, 0]) screwHole();
		translate([239.5, 71, 0]) screwHole();
		translate([237.5, -68, 0]) screwHole();
		translate([249.5, -68, 0]) screwHole();

		// connectors
		translate([160, 0, 0]) {
			translate([13, -60, -0.01]) invertScrewHole();
			translate([7, -40, -0.01]) invertScrewHole();
			translate([13, -20, -0.01]) invertScrewHole();
			translate([13, 20, -0.01]) invertScrewHole();
			translate([7, 40, -0.01]) invertScrewHole();
			translate([13, 60, -0.01]) invertScrewHole();
		}

		// for metal plate
		translate([15, 0, -0.01]) invertScrewHole();
		translate([325, 0, -0.01]) invertScrewHole();
	}

	// fuel cell holders
	translate([112, -80, thickness]) difference() {
		cube([2, 68, 8]);
		translate([0, 5, 4]) rotate([0, 90, 0]) hole(2);
		translate([0, 63.5, 4]) rotate([0, 90, 0]) hole(2);
	}
	translate([218, -80, thickness]) difference() {
		cube([2, 68, 8]);
		translate([0, 5, 4]) rotate([0, 90, 0]) hole(2);
		translate([0, 63.5, 4]) rotate([0, 90, 0]) hole(2);
	}
}

module diagonal() {
	difference() {
		rotate([0, 45, 0]) cube([17, 1, 17]);
		translate([0, -0.01, -26]) cube([25, 1.02, 25]);
	}
}

module leg() {
	difference() {
		translate([0, 0, 2]) cube([24, 8, 4], center=true);
		translate([-8, 0, 0]) hole(3);
		translate([8, 0, 0]) hole(3);
	}
	translate([-4, -4, 0]) cube([8, 8, 35]);
	translate([-12, 3, 4]) diagonal();
	translate([-12, -4, 4]) diagonal();
}

module thinHole() {
	hole(3);
	translate([0, 0, -0.01]) cylinder(d=8, h=3.1);
}

module holder() {
	holderThickness = 6;
	holderPoints = [
		[-1, -2], // screw 3
		[10, -18],
		[90, -19], // screw 2
		[130, -30],
		[130, -95],
		[174, -95],
		[174, -18], // screw 1a
		[174, 50],
		[35, 50],
		[25, 10],
		[-1, 4],
	];

	difference() {
		union() {
			linear_extrude(height = holderThickness) {
				polygon(points = holderPoints);
			}
			translate([80, -19, 3]) cube([20, 14, 3]);
			translate([160, -53, 2]) cube([14, 76, 3]);
		}
		translate([4, 0, 0]) hole(6); // 3
		translate([90, -14, 0]) hole(3); // 2
		translate([170.5, -10, 0]) hole(3); // 1a
		translate([168.5, -35, 0]) hole(3); // 1b
		translate([85, -20, -0.01]) cube([10, 10, 3]);
		translate([164, -48, -0.01]) cube([10, 66, 2]);

		translate([162, -82, 0]) thinHole();
		translate([138, -82, 0]) thinHole();
		translate([162, 36, 0]) thinHole();
		translate([138, 36, 0]) thinHole();

		translate([45, -5, -0.01]) cube([60, 35, 7]);
		translate([140, -70, -0.01]) cube([18, 93, 7]);
	}

	translate([70, 30, -35]) cube([6, 6, 35]);
	translate([148, 30, -35]) leg();
	translate([150, -78, -35]) leg();
}

module divider() {
	translate([-100, 0, 0]) cube([200, 200, 30], center=true);
	difference() {
		for (i = [-90 : 40 : 70]) {
			translate([0, i, 0]) rotate([0, -10, 0]) cube([20, 20, 10]);
			translate([0, i+20, thickness]) rotate([0, 10, 0]) translate([0, 0, -10]) cube([20, 20, 10]);
		}
	}
}

%intersection() {
	//podvozek();
	//translate([160, 0, 0]) divider();
}
translate([93.5, 24, 35+thickness]) holder();