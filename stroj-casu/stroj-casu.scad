$fs = 1;
$fa = 5;
use <springs.scad>;

module wheel() {
	difference() {
		rotate_extrude(angle=360) {
			difference() {
				square([40, 10]);
				translate([42, 5]) circle(d=12);
			}
		}
		cylinder(d=10, h=100);
	}

}

module axis() {
	color("Silver") cylinder(d=6, h=80);
	translate([0, 0, 40]) wheel();
}

module coil() {
	// spring(windings=20, r=2, R=16);
	color("DarkGray") translate([0, 0, -76]) hollow_cylinder(30, 150, 2);
	color("SaddleBrown") rotate([0, 180, 0]) spring(windings=20, r=1, R=18);
}

module string(r) {
	translate([50, r, 0]) rotate([0, 90, 0]) cylinder(r=1, h=350);
	translate([50, -r, 0]) rotate([0, 90, 0]) cylinder(r=1, h=350);
	translate([50, 0, 0]) rotate([0, 0, 90]) rotate_extrude(angle=180) {
		translate([r, 0]) circle(r=1);
	}
	translate([400, 0, 0]) rotate([0, 0, -90]) rotate_extrude(angle=180) {
		translate([r, 0]) circle(r=1);
	}
}

module hollow_cylinder(dia, height, thickness) {
	difference() {
		cylinder(d=dia, h=height);
		translate([0, 0, -1]) cylinder(d=(dia - 2*thickness), h=height+2);
	}
}

module bottle() {
	color("Aqua", alpha=0.3) translate([0, 0, 124]) rotate([180, 0, 0]) scale(180) import("bottle.stl");
}

module bottle_connector() {
	color("DarkOrange") hollow_cylinder(10, 150, 1);
	translate([5, 0, 40]) rotate([0, 90, 0]) bottle();
	translate([-5, 0, 40]) rotate([0, -90, 0]) bottle();
}

// connector
color("BurlyWood") difference() {
	translate([0, -25, 0]) cube([450, 50, 25]);
	translate([50, 0, -5]) cylinder(d=10, h=40);
	translate([400, 0, -5]) cylinder(d=10, h=40);
}

// wheels
translate([50, 0, 0]) axis();
translate([400, 0, 0]) axis();
color("SaddleBrown") translate([0, 0, 45]) string(42);

color("Silver") translate([400, 0, 75]) rotate([0, 0, -40]) translate([0, -28, 0]) rotate([90, 0, 0]) import("crank.stl");

color("BurlyWood") translate([50, 0, 200]) hollow_cylinder(50, 100, 1);
translate([50, 0, 205]) coil();

translate([50, 0, 60]) rotate([0, 0, 40]) bottle_connector();
