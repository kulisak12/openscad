$fn = 50;

outer_r = 24 / 2;
inner_r = 7 / 2;
space = 1 / 2;
height = 12;
angle = 5;

module semicircle() {
    difference() {
        circle(outer_r);
        translate([ 0, -50 ]) square(100, center = true);
    }
}

module single() {
    difference() {
        linear_extrude(height, center = true) semicircle();
        translate([ 0, -space, 0 ]) rotate([ 0, angle, 0 ]) cylinder(1.5 * height, r = inner_r, center = true);
    }
}

single();
translate([ 0, -2, 0 ]) mirror([ 0, 1, 0 ]) single();
