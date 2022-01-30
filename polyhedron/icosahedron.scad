//!OpenSCAD

r = 20;
sideZ = r / sqrt(5);
sideX = 2 * sideZ;

icosaVerteces = [
    [0, 0, r], // 0 = top vertex
    [cos(0)*sideX, sin(0)*sideX, sideZ], // 1 = x-most vertex, top layer
    [cos(72)*sideX, sin(72)*sideX, sideZ], // 2
    [cos(144)*sideX, sin(144)*sideX, sideZ], // 3
    [cos(216)*sideX, sin(216)*sideX, sideZ], // 4
    [cos(288)*sideX, sin(288)*sideX, sideZ], // 5
    [cos(36)*sideX, sin(36)*sideX, -sideZ], // 6 = bottom layer
    [cos(108)*sideX, sin(108)*sideX, -sideZ], // 7
    [cos(180)*sideX, sin(180)*sideX, -sideZ], // 8
    [cos(252)*sideX, sin(252)*sideX, -sideZ], // 9
    [cos(324)*sideX, sin(324)*sideX, -sideZ], // 10
    [0, 0, -r] // 11 = bottom vertex
];

icosaFaces = [
    // top 5
    [2, 1, 0],
    [3, 2, 0],
    [4, 3, 0],
    [5, 4, 0],
    [1, 5, 0],
    // middle 10
    [1, 2, 6], [7, 6, 2],
    [2, 3, 7], [8, 7, 3],
    [3, 4, 8], [9, 8, 4],
    [4, 5, 9], [10, 9, 5],
    [5, 1, 10], [6, 10, 1],
    // bottom 5
    [6, 7, 11],
    [7, 8, 11],
    [8, 9, 11],
    [9, 10, 11],
    [10, 6, 11]
];

difference() {
    rotate([0, atan(3 - sqrt(5)), 0])
        polyhedron(points = icosaVerteces, faces = icosaFaces);
    translate([-r, -r, -2*r]) cube(2*r);
}