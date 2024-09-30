$fn = 50;

r_mid = 19 / 2;
r_side = 15 / 2;
width = 25;
mid_shift = 4.5;
cutoff_angle = 50;

shell = 0.8;
inset_inner = 2.4;
height_inner = 2.8;
height_outer = 0.6;

module key() {
    translate([ 0, -mid_shift ]) circle(r_mid);
    hull() {
        translate([ width / 2 - r_side, 0 ]) circle(r_side);
        translate([ -(width / 2 - r_side), 0 ]) circle(r_side);
    }
}

module subtr_2d(radius) {
    render() difference() {
        children();
        minkowski() {
            difference() {
                minkowski() {
                    children();
                    square(1, center = true);
                }
                children();
            }
            circle(radius);
        }
    }
}

module cutoff() {
    translate([ width / 2 - r_side, 0 ]) rotate(cutoff_angle) translate([ -5, 0 ]) square(15);
}

module outline(inset) {
    difference() {
        minkowski() {
            key();
            circle(r = shell);
        }
        subtr_2d(inset) key();
        cutoff();
        mirror([ 1, 0 ]) cutoff();
    }
}

translate([ 0, 0, 0 ]) linear_extrude(height_outer) outline(inset_inner);
translate([ 0, 0, height_outer ]) linear_extrude(height_inner) outline(0);
translate([ 0, 0, height_outer + height_inner ]) linear_extrude(height_outer) outline(inset_inner);
