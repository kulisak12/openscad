$fn = 50;

thickness = 1.6;
width = 18 + 2 * thickness;
hole_height = 13;
hole_r = 5 / 3;
rim_r = 5 / 2;
basket_thickness = 1;
base_height = hole_height + 5;
base_height_front = rim_r + 2;

clip_width_inner = 9;
clip_width_outer = 12;
clip_height_inner = 1;
clip_height_outer = 1;
clip_length = 23;
lever_length = 32;
lever_width = 5;

rod_r = 20 / 2;
rod_distance = rim_r + thickness + rod_r + 8;
rod_angle = 16;

module base_2d() {
    difference() {
        union() {
            translate([ -thickness, -base_height ]) square([ thickness + basket_thickness, base_height ]);
            translate([ basket_thickness, -base_height_front ]) square([ thickness, base_height_front ]);
            translate([ rim_r, 0 ]) circle(rim_r + thickness);
        }
        translate([ rim_r, 0 ]) circle(rim_r);
        translate([ 0, -base_height ]) square([ basket_thickness, base_height ]);
    }
}

module base() {
    difference() {
        rotate([ 90, 0, 0 ]) linear_extrude(width, center = true) base_2d();
        translate([ 0, 0, -hole_height ]) rotate([ 0, -90, 0 ]) cylinder(r = hole_r, h = 10, center = true);
    }
}

module clip_2d() {
    translate([ -clip_width_outer / 2, 0 ]) square([ clip_width_outer, clip_height_outer ]);
    translate([ -clip_width_inner / 2, clip_height_outer ]) square([ clip_width_inner, clip_height_inner ]);
    translate([ -clip_width_outer / 2, clip_height_outer + clip_height_inner ]) square([ clip_width_outer, clip_height_outer ]);
}

module clip() {
    translate([ lever_length - clip_length, 0, 0 ]) rotate([ 90, 0, 90 ]) linear_extrude(clip_length) clip_2d();
    translate([ 0, -lever_width / 2, clip_height_outer + clip_height_inner ]) cube([ lever_length, lever_width, clip_height_outer ]);
}

module rod_holder_2d() {
    difference() {
        hull() {
            circle(rim_r + thickness);
            translate([ rod_distance, 0 ]) circle(rod_r);
        }
        circle(rim_r);
        translate([ -12, 0 ]) square(20, center = true); // mask
    }
}

module rod_holder() {
    rotate([ 90, 0, 0 ]) linear_extrude(thickness) rod_holder_2d();
}

module rod_with_holder() {
    translate([ 0, width / 2, 0 ]) rod_holder();
    translate([ 0, -width / 2 + thickness, 0 ]) rod_holder();
    translate([ rod_distance, 0, 0 ]) rotate([90, 0, 0]) cylinder(r = rod_r, h = width, center = true);
}

translate([ -rim_r, 0, 0 ]) base();
rotate([ 0, -rod_angle, 0 ]) rod_with_holder();
