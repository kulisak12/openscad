$fn = 40;

for (i = [1 : 4]) {
	translate([i*20, 0, 0]) difference() {
		minkowski() {
			cube([10, 20, 5]);
			sphere(i / 2);
		}
		translate([1, 3, 4.5 + i/2]) linear_extrude(3) {
			text(str(i));
		}
	}
}