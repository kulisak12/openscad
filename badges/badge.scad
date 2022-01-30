$fn = 100;

intersection() {
	translate([60, 30, 0]) cylinder(r=100, h=3);
	translate([-60, 30, 0]) cylinder(r=100, h=3);
	translate([0, -110, 0]) cylinder(r=150, h=3);
}