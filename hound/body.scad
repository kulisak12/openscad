$fn = 200;

module innerShape() {
    translate([0, -26])
    intersection() {
        translate([0, -50]) circle(70); // top
        translate([92, 0]) circle(100); // sides top
        translate([-92, 0]) circle(100);
        translate([92, 27]) circle(100); // sides middle
        translate([-92, 27]) circle(100);
        translate([80, 55]) circle(100); // sides bottom
        translate([-80, 55]) circle(100);
        translate([0, 50]) circle(50); // bottom
    }
}

module outerShape() {
    minkowski() {
        innerShape();
        circle(0.5);
    }
}

module holes() {
    translate([4.35, -5.5, 43]) sphere(0.5, $fn=20);
    translate([4.1, -4.5, 44]) sphere(0.5, $fn=20);
    translate([4.0, -5, 46]) sphere(0.5, $fn=20);
    translate([3.7, -4, 47]) sphere(0.5, $fn=20);
}

translate([0, 0, 30]) rotate([90, 0, 0]) {
    // inner
    translate([0, 0, 0]) scale([1, 1, 1]) linear_extrude(height=8, scale=1.1) innerShape();
    translate([0, 0, 8]) scale([1.1, 1.1, 1]) linear_extrude(height=10, scale=1.01) innerShape();
    translate([0, 0, 18]) scale([1.122, 1.122, 1]) linear_extrude(height=7, scale=0.91) innerShape();
    translate([0, 0, 25]) scale([1.021, 1.021, 1]) linear_extrude(height=7, scale=0.86) innerShape();
    translate([0, 0, 32]) scale([0.878, 0.878, 1]) linear_extrude(height=9, scale=0.68) innerShape();
    translate([0, 0, 41]) scale([0.597, 0.597, 1]) linear_extrude(height=8, scale=0.77) innerShape();
    translate([0, 0, 49]) scale([0.460, 0.460, 1]) linear_extrude(height=8, scale=0.95) innerShape();

    // outer
    translate([0, -15, -1]) scale([0.8, 0.8, 1]) linear_extrude(height=1, scale=1.25) translate([0, 15]) outerShape();
    translate([0, 0, 0]) scale([1, 1, 1]) linear_extrude(height=7.7, scale=1.1) outerShape();
    difference() {
        translate([0, 0, 8]) scale([1.1, 1.1, 1]) linear_extrude(height=9.7, scale=1.01) outerShape();
        translate([6.4, -23, 16.5]) rotate([5, 0, 0]) rotate([12, 90, 0]) linear_extrude(0.5) text("451", size=3.5, font="Times");
    }
    translate([0, 0, 18]) scale([1.122, 1.122, 1]) linear_extrude(height=6.7, scale=0.91) outerShape();
    translate([0, 0, 25]) scale([1.021, 1.021, 1]) linear_extrude(height=6.7, scale=0.86) outerShape();
    translate([0, 0, 32]) scale([0.878, 0.878, 1]) linear_extrude(height=8.7, scale=0.68) outerShape();
    difference() {
        translate([0, 0, 41]) scale([0.597, 0.597, 1]) linear_extrude(height=7.7, scale=0.77) outerShape();
        holes();
        mirror([1, 0, 0]) holes();
    }
    translate([0, 0, 49]) scale([0.460, 0.460, 1]) linear_extrude(height=8, scale=0.95) outerShape();
    translate([0, -0.437*15, 57]) scale([0.437, 0.437, 1]) linear_extrude(height=1, scale=0.8) translate([0, 15]) outerShape();
}

translate([-2, -17.3, 23.2]) cube([4, 4, 1]);
translate([-2, -12.4, 23.2]) cube([4, 4, 1]);