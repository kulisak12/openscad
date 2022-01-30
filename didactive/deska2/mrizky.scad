$fn = 25;
//include<logo.scad>

outerSize = 25; // jednotková vzdálenost (vnější)
rawInnerSize = 15; // místo uvnitř
extraSpace = 0; // rezerva

height = 4; // výška
roundnessFlat = 5; // zaoblení podél x-y
roundnessZ = 1; // zaoblení nahoře a dole

innerSize = rawInnerSize + 2*roundnessZ + 2*extraSpace;
edge = (outerSize - innerSize) / 2;

module oval(size=[1, 1, 1], r = 1) {
	linear_extrude(height = size[2])
	hull() {
		translate([r, r]) circle(r);
		translate([r, size[1] - r]) circle(r);
		translate([size[0] - r, r]) circle(r);
		translate([size[0] - r, size[1] - r]) circle(r);
	}
}

module unitGrid() {
	difference() {
		translate([roundnessZ, roundnessZ])
		oval([outerSize - 2*roundnessZ, outerSize - 2*roundnessZ, height], roundnessFlat);
		translate([edge, edge, -0.01]) cube([innerSize, innerSize, 1.01*height]);
	}
}

module grid(numPieces) {
	if (numPieces == 1) {
		unitGrid();
	}
	else {
		row1 = (numPieces - numPieces % 2) / 2;
		row2 = row1 + numPieces % 2;

		difference() {
			translate([roundnessZ, roundnessZ]) union() {
				oval([2*outerSize - 2*roundnessZ, row1*outerSize - 2*roundnessZ, height], roundnessFlat);
				oval([outerSize - 2*roundnessZ, row2*outerSize - 2*roundnessZ, height], roundnessFlat);
			}
			translate([edge, edge, -0.01]) for (i = [0:row2]) {
				translate([0, i*outerSize, 0]) cube([innerSize, innerSize, 1.01*height]);
				translate([outerSize, i*outerSize, 0]) cube([innerSize, innerSize, 1.01*height]);
			}
		}
	}
}