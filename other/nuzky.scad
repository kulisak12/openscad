$fn = 20;
thickness = 1.5;

module nuzky() {
	cube([14, 8.5, 15], center=true);
	translate([0, 0, 7.5]) linear_extrude(height=50, scale=0.8) square([14, 5], center=true);
	translate([0, 0, 57.5]) linear_extrude(height=10, scale=0.5) square([14*0.8, 5*0.8], center=true);
}

//nuzky();


difference() {
	minkowski() {
		nuzky();
		sphere(thickness);
	}
	nuzky();
	translate([0, 0, -17.5]) cube([40, 40, 20.01], center=true);
}