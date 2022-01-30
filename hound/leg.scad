//$fn = 100;

module shape() {
    minkowski() {
        polygon([
            [2.5, -2.8],
            [3.3, -1.5],
            [3.3, 1.5],
            [2.5, 2.8],
            [-2.5, 3],
            [-3.3, 2],
            [-3.3, -2],
            [-2.5, -3]
        ]);
        circle(0.3);
    }
}

module jointShape() {
    hull() {
        translate([3, -2]) circle(0.6);
        translate([3, 2]) circle(0.6);
        translate([1.5, -1.7]) circle(0.2);
        translate([1.5, 1.7]) circle(0.2);
    }
}

module joint() {
    rotate([90, 0, 0])
    rotate_extrude($fn=50) jointShape();
    scale([1, 2.4, 1]) sphere(1.6, $fn=40);
}

rotate([0, -10, 0]) linear_extrude(height=20, scale=0.85, twist=-5) shape();
mirror([0, 0, 1]) linear_extrude(height=20, scale=0.6, twist=-5) shape();
intersection() {
    translate([-10, 0, -1]) rotate([90, 0, 0]) scale([1, 1, 0.95])
    rotate_extrude($fn=100) translate([10, 0]) shape(); 
    translate([2, 0, 0]) cube([8, 10, 10], center=true);
}

translate([-3.9, 0, 21.8]) rotate([0, 0, 5]) scale([0.9, 0.7, 0.9]) joint();
translate([-0, 0, -22]) rotate([0, 0, 5]) scale([0.8, 0.5, 0.8]) joint();