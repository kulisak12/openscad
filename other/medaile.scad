$fa = 1;
$fs = 0.1;

eps = 0.001;
round = 0.3;

medal_h = 3;
medal_r = 35;
ingrave_h = 1.5;
ingrave_scale = 0.4;
hole_d = 2;
hole_w = 22;

module oval() {
	hull() {
		translate([-hole_w / 2, 0]) circle(d=hole_d);
		translate([hole_w / 2, 0]) circle(d=hole_d);
	}
}

module disc() {
	minkowski() {
		translate([0, 0, round]) cylinder(r=medal_r - round, h=medal_h - 2*round);
		sphere(r=round);
	}
}

module medal() {
	difference() {
		disc();
		translate([-13, -30, medal_h - ingrave_h / 2 + eps]) scale([ingrave_scale, ingrave_scale, 1]) resize([0, 0, ingrave_h]) import("front.stl");
		translate([0, 28, -eps]) linear_extrude(medal_h + 2*eps) oval();
	}
}

medal();
