$fn = 50;

inset = 2.4;
r_mid = 19 / 2;
r_hole = r_mid - inset;
r_side = 16 / 2;
width = 26;
mid_shift = 5;
cutoff_inner = 4.5;
cutoff_angle = 30;
cutoff_hole = -6;
roundness = 1.2;

shell = 0.8;
height_inner = 2.8;
height_outer = 0.6;

module cutoff_square(cutoff) {
    translate([ -100, cutoff ]) square([ 200, 100 ]);
}

module radial_cutoff_half() {
    intersection() {
        translate([ width / 2 - r_side, 0 ]) rotate(cutoff_angle) cutoff_square(0);
        rotate(-90) cutoff_square(0);
    }
}

module radial_cutoff() {
    radial_cutoff_half();
    mirror([ 1, 0 ]) radial_cutoff_half();
}

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

module expanded() {
    minkowski() {
        key();
        circle(shell);
    }
}

module lower() {
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

module inner() {
    difference() {
        expanded();
        key();
        radial_cutoff();
    }
}

module upper() {
    difference() {
        expanded();
        subtr_2d(inset) key();
        radial_cutoff();
    }
}

translate([ 0, 0, 0 ]) linear_extrude(height_outer) lower();
translate([ 0, 0, height_outer ]) linear_extrude(height_inner) inner();
translate([ 0, 0, height_outer + height_inner ]) linear_extrude(height_outer) upper();
