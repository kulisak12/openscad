$fn = 20;

width = 15;

cube([15, width, 5]);
cube([5, width, 34]);
translate([0, 0, 34]) cube([20, width, 5]);

translate([13, width/2, 39]) {
	cylinder(d=4, h=10);
	translate([0, 0, 7]) cylinder(d=8, h=3);
}
