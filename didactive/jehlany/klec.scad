$fn = 20;
include<logo.scad>

a = 50; // strana krychle v mm
rawEdgeThickness = 6; // průměr hran
indent = 2; // zářez do hran
extraSpace = 0.5; // rezerva
roundness = 1; // zaoblení

edgeThickness = rawEdgeThickness - 2*roundness;
netSize = a + 2 * (extraSpace - indent + rawEdgeThickness - roundness);

module roundedCuboid(size = [1, 1, 1], r = 1) {
	hull() {
		translate([r, r, r]) sphere(r);
		translate([r, size[1] - r, r]) sphere(r);
		translate([r, r, size[2] - r]) sphere(r);
		translate([r, size[1] - r, size[2] - r]) sphere(r);

		translate([size[0] - r, r, r]) sphere(r);
		translate([size[0] - r, size[1] - r, r]) sphere(r);
		translate([size[0] - r, r, size[2] - r]) sphere(r);
		translate([size[0] - r, size[1] - r, size[2] - r]) sphere(r);
	}
}

/*
module baseSquare() {
	translate([-a/2, -a/2, 0]) roundedCuboid([a, edgeThickness, edgeThickness], roundness);
	translate([-a/2, a/2 - edgeThickness, 0]) roundedCuboid([a, edgeThickness, edgeThickness], roundness);
	translate([-a/2, -a/2, 0]) roundedCuboid([edgeThickness, a, edgeThickness], roundness);
	translate([a/2 - edgeThickness, -a/2, 0]) roundedCuboid([edgeThickness, a, edgeThickness], roundness);
}

module verticalEdges() {
	translate([-a/2, -a/2, 0]) roundedCuboid([edgeThickness, edgeThickness, a], roundness);
	translate([-a/2, a/2 - edgeThickness, 0]) roundedCuboid([edgeThickness, edgeThickness, a], roundness);
	translate([a/2 - edgeThickness, -a/2, 0]) roundedCuboid([edgeThickness, edgeThickness, a], roundness);
	translate([a/2 - edgeThickness, a/2 - edgeThickness, 0]) roundedCuboid([edgeThickness, edgeThickness, a], roundness);
}
*/

module baseSquare() {
	translate([-netSize/2, -netSize/2, 0]) cube([netSize, edgeThickness, edgeThickness]);
	translate([-netSize/2, netSize/2 - edgeThickness, 0]) cube([netSize, edgeThickness, edgeThickness]);
	translate([-netSize/2, -netSize/2, 0]) cube([edgeThickness, netSize, edgeThickness]);
	translate([netSize/2 - edgeThickness, -netSize/2, 0]) cube([edgeThickness, netSize, edgeThickness]);
}

module verticalEdges() {
	translate([-netSize/2, -netSize/2, 0]) cube([edgeThickness, edgeThickness, netSize]);
	translate([-netSize/2, netSize/2 - edgeThickness, 0]) cube([edgeThickness, edgeThickness, netSize]);
	translate([netSize/2 - edgeThickness, -netSize/2, 0]) cube([edgeThickness, edgeThickness, netSize]);
	translate([netSize/2 - edgeThickness, netSize/2 - edgeThickness, 0]) cube([edgeThickness, edgeThickness, netSize]);
}

minkowski() {
	difference() {
		union() {
			baseSquare();
			verticalEdges();
			translate([0, 0, netSize - edgeThickness]) baseSquare();
		}
		translate([0, 0, a/2 + 2*edgeThickness - indent]) 
		cube([a + 2*extraSpace + 2*roundness, a + 2*extraSpace + 2*roundness, a + 2*edgeThickness], center=true);
	}
	sphere(roundness);
}