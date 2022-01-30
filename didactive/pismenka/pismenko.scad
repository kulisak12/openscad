$fn = 12;

letterHeight = 1; // výška písmene

minkowski() {
	linear_extrude(0.1) {
		scale(0.75) import("f.svg");
	}
	intersection() {
		sphere(letterHeight);
		translate([0, 0, 2]) cube(4, center=true);
	}
}

// import("pismenko.stl");