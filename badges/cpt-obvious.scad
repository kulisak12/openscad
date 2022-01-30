
difference() {
    import("badge.stl");
    translate([0, 0, 2]) rotate([-1, 0, 0]) linear_extrude(height = 1.2) {
        translate([0, 25]) text("CAPTAIN", size=9, font="Impact", halign="center");
        translate([0, 13]) text("OBVIOUS", size=9, font="Impact", halign="center");
    }
}
