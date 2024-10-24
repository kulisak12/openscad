$fn = 50;

outer_r = 24 / 2;
inner_r = 7 / 2;
space = 1 / 2;
height = 12;

module rod_2d() {
    difference() {
        circle(outer_r);
        translate([ 0, -space ]) circle(inner_r);
        translate([ 0, -50 ]) square(100, center = true);
    }
}

linear_extrude(height) rod_2d();
