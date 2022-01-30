u = 10;

hull() {
	translate([-4*u, -2.5*u, 0]) cube(0.01, center=true);
	translate([4.5*u, -0.5*u, 0]) cube(0.01, center=true);
	translate([2*u, -8.9*u, 0]) cube(0.01, center=true);
	translate([1.9*u, -4*u, 7.1*u]) cube(0.01, center=true);
}

%linear_extrude(height=9*u) hull() {
	translate([3*u, -0.5*u, 0]) square(0.01, center=true);
	translate([5*u, -5*u, 0]) square(0.01, center=true);
	translate([0.5*u, -7.1*u, 0]) square(0.01, center=true);
	translate([-1.5*u, -2.6*u, 0]) square(0.01, center=true);
}