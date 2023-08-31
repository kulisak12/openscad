$fn = 50;
use <gears-lib.scad>;

modul = 1.8;
height = 3;
joiner_height = 2;
bore = 4.5;
axis_clearance = 1;
big_gear_teeth = 34;
small_gear_teeth = 22;
gear_clearance = 0.2;
joiner_padding = 15;

big_gear_radius = big_gear_teeth * modul / 2;
small_gear_radius = small_gear_teeth * modul / 2;

module triangle(a)
{
    t = sqrt(3) * a / 3;
    polygon(points = [ [ 0, t ], [ cos(30) * t, -sin(30) * t ], [ -cos(30) * t, -sin(30) * t ] ]);
}

module center_arrow()
{
    a = 0.6 * joiner_padding;
    linear_extrude(height) triangle(a);
}

module curved_arrow()
{
    rotate_extrude(angle = 60) translate([ 0.4 * small_gear_radius, 0 ]) square(height);
    linear_extrude(height) translate([ 0.4 * small_gear_radius + height / 2, 0 ]) rotate(180) triangle(height * 2);
}

module gear(tooth_number)
{
    spur_gear(modul = modul, tooth_number = tooth_number, width = height, bore = bore, pressure_angle = 20,
              helix_angle = 0, optimized = false);
}

module big_gear()
{
    gear(big_gear_teeth);
}

module small_gear()
{
    difference()
    {
        rotate([ 0, 0, 180 / small_gear_teeth ]) gear(small_gear_teeth);
        translate([ 0, 0, height - 1 ]) rotate(-25) curved_arrow();
    }
    translate([ 0.75 * small_gear_radius, 0, height ]) cylinder(d = 2, h = height);
}

module joiner()
{
    difference()
    {
        // no need to care about clearance
        translate([ -(2 * big_gear_radius + joiner_padding), -joiner_padding / 2, 0 ])
            cube([ 2 * (big_gear_radius + small_gear_radius + joiner_padding), joiner_padding, joiner_height ]);
        translate([ -(2 * big_gear_radius + joiner_padding / 2), 0, joiner_height - 1 ]) rotate([ 0, 0, -90 ]) center_arrow();
        translate([ (2 * small_gear_radius + joiner_padding / 2), 0, joiner_height - 1 ]) rotate([ 0, 0, 90 ]) center_arrow();
    }
    translate([ -(big_gear_radius + gear_clearance), 0, joiner_height ]) cylinder(d = bore - axis_clearance, h = 2*height);
    translate([ small_gear_radius + gear_clearance, 0, joiner_height ]) cylinder(d = bore - axis_clearance, h = 2*height);
}

translate([ -(big_gear_radius + gear_clearance), 0, 0 ]) big_gear();
translate([ small_gear_radius + gear_clearance, 0, 0 ]) small_gear();
translate([ 0, 0, -joiner_height - 1 ]) joiner();
