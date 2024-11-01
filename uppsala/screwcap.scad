use <../lib/BaNG_Metric.scad>
$fn = 50;

screw = 5;
screw_r = screw / 2;
thickness = 0.8;
height = 7;
adjustment = 0.2;


intersection() {
    nut(screw, height_=height, tolerance="Loose", thread_adjustment=adjustment);
    cylinder(h = height, r = screw_r + thickness);
}
difference() {
    scale([1,1,0.5]) sphere(screw_r + thickness);
    translate([-10, -10, 0]) cube(20);
}
