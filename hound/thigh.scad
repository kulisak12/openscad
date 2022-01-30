$fn = 100;

module shape() {
    translate([-5, -10])
    difference() {
        intersection() {
            polygon([
                [0, 0],
                [0, 24],
                [10, 25], // 5, 25 for front
                [15, 16],
                [8, 0]
            ]);
            translate([80, 15]) circle(80);
        }
        translate([87, -10]) circle(80);
    }
}

module joint() {
    difference() {
        cylinder(d1=2, d2=3, h=1);
        cylinder(d1=1.7, d2=1, h=1);
    }
}

rotate([90, 0, 0])
difference() {
    linear_extrude(height=2, scale=0.9) shape();
    translate([0, 7, 1.7]) joint();
}