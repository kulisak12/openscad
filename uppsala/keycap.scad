$fn = 50;

r_mid = 19 / 2;
r_hole = r_mid - 2.5;
r_side = 16 / 2;
width = 26;
mid_shift = 5;
cutoff_inner = 4.5;
cutoff_hole = -6;
roundness = 1.2;

shell = 0.8;
height_inner = 2.8;
height_outer = 0.6;

module cutoff_square(cutoff) {
    translate([ -100, cutoff ]) square([ 200, 100 ]);
}

module key() {
    translate([ 0, -mid_shift ]) circle(r_mid);
    hull() {
        translate([ width / 2 - r_side, 0 ]) circle(r_side);
        translate([ -(width / 2 - r_side), 0 ]) circle(r_side);
    }
}

module expanded() {
    minkowski() {
        key();
        circle(shell);
    }
}

module inner() {
    difference() {
        expanded();
        key();
        cutoff_square(cutoff_inner);
    }
}

module outer() {
    difference() {
        expanded();
        minkowski() {
            difference() {
                translate([ 0, -mid_shift ]) circle(r_hole - roundness);
                cutoff_square(cutoff_hole);
            }
            circle(roundness);
        }
    }
}

translate([ 0, 0, 0 ]) linear_extrude(height_outer) outer();
translate([ 0, 0, height_outer ]) linear_extrude(height_inner) inner();
translate([ 0, 0, height_outer + height_inner ]) linear_extrude(height_outer) outer();
