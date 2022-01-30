
difference() {
    import("badge.stl");
    translate([0, 0, 2]) linear_extrude(height = 1.2) {
        translate([0, 21]) text("PAMPELIŠKA", size=9, font="Impact", halign="center");
    }
}
