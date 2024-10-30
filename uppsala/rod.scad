$fn = 50;

outer_r = 24 / 2;
inner_r = 7 / 2;
space = 1 / 2;
height = 12;
angle = 3;

module semicircle() {
    difference() {
        circle(outer_r);
        translate([ 0, -50 + space ]) square(100, center = true);
    }
}

difference() {
    union() {
        linear_extrude(height, center = true) semicircle();
        linear_extrude(height, center = true) rotate(180) semicircle();
    }
    rotate([ 0, angle, 0 ]) cylinder(1.5 * height, r = inner_r, center = true);
}
