//!OpenSCAD

ratio = 20 / sqrt(3);
phi = (sqrt(5) + 1) / 2;

dodecaVerteces = [
    [1, 1, 1], // 0
    [-1, 1, 1], // 1
    [1, -1, 1], // 2
    [-1, -1, 1], // 3
    [1, 1, -1], // 4
    [-1, 1, -1], // 5
    [1, -1, -1], // 6
    [-1, -1, -1], // 7

    [0, phi, 1/phi], // 8
    [0, -phi, 1/phi], // 9
    [0, phi, -1/phi], // 10
    [0, -phi, -1/phi], // 11

    [1/phi, 0, phi], // 12
    [-1/phi, 0, phi], // 13
    [1/phi, 0, -phi], // 14
    [-1/phi, 0, -phi], // 15

    [phi, 1/phi, 0], // 16
    [-phi, 1/phi, 0], // 17
    [phi, -1/phi, 0], // 18
    [-phi, -1/phi, 0], // 19
];

dodecaFaces = [
    [9, 3, 13, 12, 2], // top front
    [8, 0, 12, 13, 1], // top back
    [12, 0, 16, 18, 2], // top right
    [13, 3, 19, 17, 1], // top left

    [18, 6, 11, 9, 2], // front-right
    [19, 3, 9, 11, 7], // front-left
    [17, 1, 8, 10, 5], // bottom-left
    [16, 4, 10, 8, 0], // bottom-right

    [10, 4, 14, 15, 5], // bottom back
    [11, 7, 15, 14, 6], // bottom front
    [15, 7, 19, 17, 5], // bottom left
    [14, 4, 16, 18, 6], // bottom right
];

scale([ratio, ratio, ratio]) polyhedron(points = dodecaVerteces, faces = dodecaFaces);