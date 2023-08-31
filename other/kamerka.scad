$fn = 40;

module top() {
	difference() {
		hull() {
			translate([30, 2]) circle(2);
			translate([30, 27]) square(4, center=true);
			translate([2, 2]) square(4, center=true);
			translate([2, 27]) square(4, center=true);
		}
		translate([13, 15]) clipHole();
		translate([17, 6]) sideHole();
	}
	hull() {
		translate([23.3, 29]) square([8.7, 1]);
		translate([23.3+8.5/2, 37]) circle(d=8.7);
	}

	difference() {
		translate([0, 33]) circle(12);
		translate([-30, 25]) square(30);
		translate([0, 41]) square(20);
	}

	translate([17, 29]) leg();
}

module bottom() {
	difference() {
		translate([16.1, 6]) square([4, 12]);
		translate([20, 15]) rotate([0, 0, 45]) square(6);
	}

	translate([11, 31.2]) intersection() {
		circle(11.1);
		translate([5.5, 0]) square(20);
	}

	translate([16, 26]) hull() {
		translate([0.5, 0]) circle(1);
		translate([3, 2]) circle(1);
		translate([3, 6]) circle(1);
	}
}

module clipHole() {
	hull() {
		translate([0, 2]) circle(2);
		translate([0, 20]) square(4, center=true);
	}
}

module sideHole() {
	intersection() {
		square([6.3, 30]);
		translate([10, -7]) rotate([0, 0, 45]) square(30); 
	}
}

module leg() {
	difference() {
		hull() {
			translate([-1, 10.5]) circle(1.5);
			translate([1, 3]) circle(1);
			translate([-2, 0]) square(2);
		}
		translate([-16, 5.5]) circle(15);
	}
}

module clipper() {
	difference() {
		linear_extrude(10) {
			top();
			mirror([1, 0, 0]) top();
		}
		translate([0, 35.01, 1]) cube([3.5, 12, 2.01], center=true);
	}

	linear_extrude(3) {
		bottom();
		mirror([1, 0, 0]) bottom();
	}
}

curvature = 100;
difference() {
	translate([0, -20, -5]) rotate([5, 0, 0]) clipper();
	translate([0, 0, curvature]) sphere(curvature, $fn=200);
}
