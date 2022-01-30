$fn = 25;

module prism(l, w, h){
	polyhedron(
			points=[[0,0,0], [l,0,0], [l,w,0], [0,w,0], [0,w,h], [l,w,h]],
			faces=[[0,1,2,3],[5,4,3,2],[0,4,5,1],[0,3,4],[5,2,1]]
			);
	}

for (i = [0:120:240]) {
	rotate([0, 0, i]) {
		// sticks in the middle
		translate([-11, 0, 30]) rotate([0, 90, 0]) cylinder(r=1, h=11);
		// one side
		translate([-12.21, -20, 0]) {
			difference() {
				cube([2, 40, 40]);
				translate([0, 2, 2]) cube([1, 36, 36]);
			}
			translate([1, 38, 2]) rotate ([0, 0, 180]) prism(1, 36, 36);
		}
	}
}