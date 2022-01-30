
difference() {
    import("badge.stl");
    translate([0, 0, 2]) linear_extrude(height = 1.2) {
        translate([0, 25]) text("TEAM", size=9, font="Impact", halign="center");
        translate([0, 13]) text("FLEGMATIK", size=9, font="Impact", halign="center");
    }
}
