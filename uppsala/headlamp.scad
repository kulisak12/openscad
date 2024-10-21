$fn = 50;

thickness = 1.6;
width = 18 + 2 * thickness;

hole_height = 20;
hole_r = 5 / 2;
rim_r = 5.5 / 2;
rim_free_space = 4;
basket_thickness = 2;
base_height = hole_height + 5;
base_height_front = hole_height - 10;

rod_r = 25 / 2;
rod_distance = rim_r + thickness + rod_r + 8;
rod_angle = 25;

module body_2d_hole() {
    hull() {
        circle(rim_r);
        translate([ -rim_r, -rim_free_space ]) square([ basket_thickness, rim_free_space ]);
    }
    translate([ -rim_r, -base_height ]) square([ basket_thickness, base_height ]);
}

module body_2d_upper() {
    difference() {
        minkowski() {
            body_2d_hole();
            circle(thickness);
        }
        body_2d_hole();
        translate([ 0, -50 - base_height_front]) square(100, center=true);
    }
    rotate(rod_angle) translate([ rod_distance, 0 ]) circle(rod_r);
}

module body_2d() {
    translate([ -thickness - rim_r, -base_height ]) square([ thickness, base_height ]);
    body_2d_upper();
}

module body() {
    difference() {
        rotate([ 90, 0, 0 ]) linear_extrude(width, center = true) body_2d();
        translate([ 0, 0, -hole_height ]) rotate([ 0, -90, 0 ]) cylinder(r = hole_r, h = 10, center = true);
    }
}

module rod_holder_2d() {
    difference() {
        hull() body_2d_upper();
        body_2d_hole();
    }
}

module rod_holder() {
    rotate([ 90, 0, 0 ]) linear_extrude(thickness) rod_holder_2d();
}

body();
translate([ 0, width / 2, 0 ]) rod_holder();
translate([ 0, -width / 2 + thickness, 0 ]) rod_holder();
