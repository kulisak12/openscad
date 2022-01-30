$fn = 25;

module brim(l, w, h) {
	rotate([0, -90, 180])
	linear_extrude(height=l) {
		polygon(points=[[0, 0], [0, w], [0.5*h, 0.8*w], [0.8*h, 0.6*w], [h, 0.4*w], [h, 0]]);
	}
}

difference() {
	cube([80, 35, 2]);
	translate([40, 0, 1])
		linear_extrude(height=1) {
			translate([0, 18]) text("Davídek", size=12, font="Helvetica", halign="center");
			translate([0, 7]) text("CoPh", size=6, font="Helvetica", halign="center");
		}
}
translate([0, 35, 2]) brim(80, 3, 1);
translate([80, -0.6, 1]) rotate([-15, 0, 180]) brim(80, 5, 2);
translate([0, -0.6, 1]) rotate([-165, 0, 0]) brim(80, 5, 10);