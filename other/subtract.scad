$fn = 4;

module 2d_subtr(radius) {
	render() difference() {
		children();
		minkowski() {
			difference() {
				minkowski() {
					children();
					square(1, center=true);
				}
				children();
			}
			circle(radius);
		}
	}
}

module 3d_subtr(radius) {
	render() difference() {
		children();
		minkowski() {
			difference() {
				cube(1000, center=true);
				children();
			}
			sphere(radius);
		}
	}
}

for (i = [1 : 9]) {
	3d_subtr(1) import("teleso_teziste_0" + str(i) + ".stl");
}