$fn = 50;

base_heigth = 1.5;

// Base
difference() {
	cylinder(r=12, h=base_heigth);
	translate([0, 9.5, 0]) scale([1.5, 1.0, 1.0]) cylinder(r=1.5, h=base_heigth);
}

// Text
translate([0, -1, base_heigth])
linear_extrude(height = 1) {
		#text("{ }", size = 12, font = "Impact", halign = "center", valign = "center");
}