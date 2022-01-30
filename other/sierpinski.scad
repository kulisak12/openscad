module triangle(a) {
	t = sqrt(3)*a/3;
	polygon(points=[
		[0, t],
		[cos(30)*t, -sin(30)*t],
		[-cos(30)*t, -sin(30)*t]
	]);
}

module recursion(a) {
	smallest = 4;
	t = sqrt(3)*a/6;
	if (a > smallest) {
		translate([0, t]) recursion(a/2);
		translate([cos(30)*t, -sin(30)*t]) recursion(a/2);
		translate([-cos(30)*t, -sin(30)*t]) recursion(a/2);
	}
	else {
		triangle(smallest * 1.2);
	}
}

linear_extrude(2) recursion(128);