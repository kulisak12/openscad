a = 20;
polyhedron(
    points = [
        [a, 0, 0], // 0
        [-sin(30)*a, cos(30)*a, 0], // 1
        [-sin(30)*a, -cos(30)*a, 0], // 2
        [0, 0, sqrt(5)*a/2] // 3
    ],
    faces = [
        [0, 1, 2], // bottom
        [0, 3, 1],
        [1, 3, 2],
        [2, 3, 0]
    ]
);