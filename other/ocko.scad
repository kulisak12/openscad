$fn = 20;

linear_extrude(height = 6) difference() {
	minkowski() {
		square([7, 14], center=true);
		circle(2);
	}
	square([7, 14], center=true);
}