module roundedSquare(size, r, center = false) {
    if (center) {
        translate([ -size[0] / 2, -size[1] / 2 ]) _roundedSquare(size, r);
    } else {
        _roundedSquare(size, r);
    }
}

module _roundedSquare(size, r) {
    hull() {
        translate([ r, r ]) circle(r);
        translate([ r, size[1] - r ]) circle(r);
        translate([ size[0] - r, r ]) circle(r);
        translate([ size[0] - r, size[1] - r ]) circle(r);
    }
}

module roundedCube(size, r, center = false) {
    if (center) {
        translate([ -size[0] / 2, -size[1] / 2, -size[2] / 2 ]) _roundedCube(size, r);
    } else {
        _roundedCube(size, r);
    }
}

module _roundedCube(size, r) {
    hull() {
        translate([ r, r, r ]) sphere(r);
        translate([ r, size[1] - r, r ]) sphere(r);
        translate([ r, r, size[2] - r ]) sphere(r);
        translate([ r, size[1] - r, size[2] - r ]) sphere(r);

        translate([ size[0] - r, r, r ]) sphere(r);
        translate([ size[0] - r, size[1] - r, r ]) sphere(r);
        translate([ size[0] - r, r, size[2] - r ]) sphere(r);
        translate([ size[0] - r, size[1] - r, size[2] - r ]) sphere(r);
    }
}
