yellowHeight = 3;
blackHeight = 5;
layerHeight = 1;

module yellowKey() {
	hull() {
		translate([15, 0]) square(10, center=true);
		translate([60, 0]) circle(d=10);
	}
	hull() {
		translate([0, 13]) circle(d=5);
		translate([0, -10]) circle(d=5);
		translate([13, 13]) circle(d=5);
		translate([11, -10]) circle(d=5);
		translate([20, 0]) circle(d=10);
	}
	translate([3, 0]) circle(d=5);
}

module blackKey() {
	hull() {
		translate([15, 0]) square(10, center=true);
		translate([60, 0]) circle(d=10);
	}
	polygon(points=[[45, 0], [20, 9], [20, -9]]);
	hull() {
		translate([0, 13]) circle(d=5);
		translate([0, -13]) circle(d=5);
		translate([17, 13]) circle(d=5);
		translate([17, -13]) circle(d=5);
		translate([19, 0]) circle(d=10);
	}
	translate([3, 0]) circle(d=5);
}

module case() {
	linear_extrude(height = 6) {
		minkowski() {
			blackKey();
			circle(r=2);
		}
	}
}

difference() {
	case();
	translate([3, 0, -1]) scale([1, 1.5, 1]) cylinder(d=4, h=20, $fn=20);
	translate([0, 0, -0.01]) linear_extrude(height = 2) {
		yellowKey();
	}
	translate([0, 0, 4]) linear_extrude(height = 2.1) {
		blackKey();
	}
	translate([0, 0, 3.5]) linear_extrude(height = 1) intersection() {
		blackKey();
		square(42, center=true);
	}
	translate([0, 0, 3]) linear_extrude(height = 2) {
		translate([18, 0, 0]) minkowski() {
			square([15, 11], center=true);
			circle(1);
		}
	}
}