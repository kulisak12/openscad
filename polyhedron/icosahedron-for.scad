//!OpenSCAD

r = 20;
sideZ = r / sqrt(5);
sideX = 2 * sideZ;

function row(angle, sign) = angle < 360 ? concat([[cos(angle)*sideX, sin(angle)*sideX, sign*sideZ]], row(angle + 72, sign)) : [];

icosaVertexes = concat(
    [[0, 0, r]],
    row(0, 1),
    row(36, -1),
    [[0, 0, -r]]
);

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

rotate([0, atan(3 - sqrt(5)), 0])
polyhedron(points = icosaVertexes, faces = icosaFaces);