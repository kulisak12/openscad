$fn = 50;

hole_r = 4.7 / 2; // 5 mm screw
thickness = 0.8;
length = 7;
eps = 0.01;

difference() {
    union() {
        scale([1,1,0.5]) sphere(hole_r + thickness);
        cylinder(h = length, r = hole_r + thickness);
    }
    cylinder(h = length + eps, r = hole_r);
}
