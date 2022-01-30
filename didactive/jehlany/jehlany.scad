$fn = 50;
include<logo.scad>

a = 50; // strana krychle v mm
includeMagnets = true; // včetně děr na magnety
rawMagnetDiameter = 16; // průměr magnetu
rawMagnetHeight = 5; // výška magnetu
indentSize = 3; // velikost výstupku
indentWidth = 0.7; // tloušťka výstupku

logoDepth = 0.5; // hloubka loga

// rezervy
magnetHeight = rawMagnetHeight + 1;
magnetDiameter = rawMagnetDiameter + 0.0; // zde lze upravit

module magnetHole() {
	translate([a/3, a/3, sqrt(0.501) * a - magnetHeight]) difference() {
		cylinder(d = magnetDiameter + 2*indentSize, h = magnetHeight);
		for (i = [0 : 120 : 240]) {
			rotate([0, 0, i]) translate([magnetDiameter/2, -indentWidth/2, 0])
				cube([indentSize, indentWidth, magnetHeight]);
		}
	}
}

module pyramid() {
	difference() {
		cube(a);
		translate([0, -1, a]) rotate([0, 45, 0]) cube(2*a);
		translate([-1, 0, a]) rotate([-45, 0, 0]) cube(2*a);
		if (includeMagnets) {
			rotate([0, 45, 0]) magnetHole();
			rotate([-45, 0, 0]) magnetHole();
		}
	}
}

difference() {
	pyramid();
	translate([0.05*a, logoDepth, 0.05*a]) rotate([90, 0, 0])
	resize([a/2, 0, 1.01*logoDepth], auto=true) logoText();
}

//translate([-10, 0, 0]) rotate([0, 0, 90]) pyramid();
//translate([-10, -10, 0]) rotate([0, 0, 180]) pyramid();