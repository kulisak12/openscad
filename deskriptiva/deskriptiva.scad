module unitTriangle() {
	linear_extrude(0.01)
	polygon([[0, 0], [u, 0], [0, u]]);
}

module unitParallelogram() {
	linear_extrude(0.01)
	polygon([[0, 0], [u, 0], [0, u], [-u, u]]);
}

module unitPyramid(n) {
	step = 360 / n;
		hull() {
		for (i = [0: n]) {
			translate([cos(i*step) * u, sin(i*step) * u, 0]) cube(0.01, center=true);
		}
		translate([0, 0, u]) cube(0.01, center=true);
	}
}

module unitLine() {
	translate([u/2, 0, 0]) cube([u, 0.01, 0.01], center=true);
}

module magnify(thickness) {
	minkowski() {
		children();
		sphere(thickness);
	}
}

module transform(A, B, C) {
	// all y coords are switched
    dA = [0, 0, 0];
    dB = [B.x - A.x, - B.y + A.y, B.z - A.z];
    dC = [C.x - A.x, - C.y + A.y, C.z - A.z];
    m = [
        [dB.x, dC.x, 1, u*A.x],
        [dB.y, dC.y, 1, -u*A.y],
        [dB.z, dC.z, 1, u*A.z],
        [0, 0, 0, 1]
    ];
    
    multmatrix(m) children();
} 

module oneAxisTransform(S, A, V) {
	// all y coords are switched
    dS = [0, 0, 0];
    dA = [A.x - S.x, - A.y + S.y, A.z - S.z];
    dV = [V.x - S.x, - V.y + S.y, V.z - S.z];
	dANormal = cross([0, 0, 1], dA);
    m = [
        [dA.x, dANormal.x, dV.x, u*S.x],
        [dA.y, dANormal.y,dV.y, -u*S.y],
        [dA.z, dANormal.z, dV.z, u*S.z],
        [0, 0, 0, 1]
    ];
    
    multmatrix(m) children();
}