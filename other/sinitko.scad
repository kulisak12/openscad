$fn = 25;

dx = 0.1;
pi = 3.14159265;
h = 5;

module sinusoid() {
	translate([0, 0, -0.1]) linear_extrude(height=1.2) scale([10, 10])	
	for (i = [0 : dx : 2*pi]) {
		translate([i, 0]) polygon([[0, sin(i*180/pi)], [1.001*dx, sin((i+dx) * 180 / pi)], [1.001*dx, h], [0, h]]);
	}
}

module lines() {
	translate([0, 0, 0.85]) cube([10*pi, 0.3, 0.15]);
	translate([0, -20*pi, 0.85]) cube([0.3, 10*pi, 0.15]);
	translate([5*pi, -20*pi, 0.85]) cube([5*pi, 0.3, 0.15]);
	translate([15*pi, -20*pi, 0.85]) cube([5*pi, 0.3, 0.15]);
	translate([20*pi, -10*pi, 0.85]) cube([0.3, 10*pi, 0.15]);
}

difference() {
	translate([-30, -80, 0]) cube([100, 100, 1]);
	sinusoid();
	translate([0, -20*pi, 0]) rotate([0, 0, 90]) scale([1, 2, 1]) sinusoid();
	translate([20*pi, , 0]) rotate([0, 0, -90]) scale([1, 1/2, 1]) sinusoid();
	translate([10*pi, -20*pi, 0]) rotate([0, 0, 180]) scale([1/2, 1/2, 1]) sinusoid();
	translate([20*pi, -20*pi, 0]) rotate([0, 0, 180]) scale([1/2, 1, 1]) sinusoid();
	translate([-30, 0, -0.1]) cube([30, 20, 1.2]);
	translate([-30, -20*pi-20, -0.1]) cube([30, 20, 1.2]);
	translate([20*pi, 0, -0.1]) cube([30, 20, 1.2]);
	translate([20*pi, -20*pi-20, -0.1]) cube([30, 20, 1.2]);
	lines();
}
//color("red") lines();