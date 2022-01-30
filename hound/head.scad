$fn = 40;

module shape() {
    minkowski() {
        translate([400, 0]) rotate([0, 0, -90])
        intersection() {
            translate([0, -30]) circle(50); // top
            translate([67, -50]) circle(100); // sides top
            translate([-67, -50]) circle(100);
            translate([92, 27]) circle(100); // sides middle
            translate([-92, 27]) circle(100);
            translate([0, 54]) circle(50); // bottom
        }
        circle(1, $fn=12);
    }
}

module headPart() {
    translate([0, 0, -10])
    difference() {
        intersection() {
            translate([0, 0, -400]) rotate([90, 0, 0]) rotate_extrude($fn=200) shape();
            cube(60, center=true);
        }
        translate([35, 0, 5]) rotate([0, 40, 0]) cube(30, center=true);
        translate([-30, 0, 0]) rotate([0, -50, 0]) cube(30, center=true);
    }
}

module eyes() {
    translate([0, 8.5, 0.5]) sphere(1.5);
    translate([3, 9, 4]) sphere(1.5);
    translate([-3, 9, 4]) sphere(1.5);
}

module neckShape() {
    circle(4);
    translate([4, 0]) circle(1);
    translate([0, -4]) circle(1);
}

difference() {
    import("headPart.stl");
    translate([-15, 7, 8.5]) sphere(1);
    translate([-15, -7, 8.5]) sphere(1);
}

difference() {
    scale([1.1, 1.1, 1.1]) import("headPart.stl");;
    translate([10, 0, 15]) rotate([0, -50, 0]) cube(50, center=true);
    translate([-2, 0, 0]) rotate([0, -40, 0]) cube(20, center=true);
}

difference() {
    intersection() {
        scale([1.05, 1.1, 1.1]) import("headPart.stl");
        union() {
            translate([0, 10, 5]) rotate([90, 0, 0]) cylinder(h=20,d=15);
            translate([15, 0, 17]) cube(30, center=true);
            translate([-2, 0, 17]) rotate([0, -30, 0]) cube(20, center=true);
        }
    }
    translate([24, -5, 4]) rotate([0, -50, 0]) cube([4, 2, 1]);
    translate([24, -1, 4]) rotate([0, -50, 0]) cube([4, 2, 1]);
    translate([24, 3, 4]) rotate([0, -50, 0]) cube([4, 2, 1]);
}

eyes();
mirror([0, 1, 0]) eyes();

translate([-50, 0, -10]) rotate([0, 70, 0]) linear_extrude(height=35, twist=100) neckShape();