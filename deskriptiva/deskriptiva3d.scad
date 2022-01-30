module unitTrianglePrism() {
	linear_extrude(u)
	polygon([[u, 0], [-1/2*u, sqrt(3)/2*u], [-1/2*u, -sqrt(3)/2*u]]);
}

module transform3d(T, A, v) {
	// all y coords are switched
    dT = [0, 0, 0];
    dA = [A.x - T.x, - A.y + T.y, A.z - T.z];
	sizedA = sqrt(dA.x * dA.y + dA.x * dA.y + dA.z * dA.z);
    m = [
        [dA.x, 1, 1, u*T.x],
        [dA.y, 1, 1, -u*T.y],
        [dA.z, 1, v, u*T.z],
        [0, 0, 0, 1]
    ];
    
    multmatrix(m) children();
} 