module logo() {
	translate([-7, 68, 0]) logoText();
	logoShapes();
}

module logoText() {
	linear_extrude(height = 10) {
		minkowski() {
			text("DIDACTIVE", size=71.7, font="Century Gothic");
			circle(1);
		}
	}
}

module logoShapes() {
	step = 63;
	linear_extrude(height = 10) {
		translate([0*step, 0]) logoSquare();
		translate([1*step, 0]) logoCircle();
		translate([2*step, 0]) logoTriangle();
		translate([3*step, 0]) logoCircle();
		translate([4*step, 0]) logoSquare();
		translate([5*step, 0]) logoCircle();
		translate([6*step, 0]) logoTriangle();
		translate([7*step, 0]) logoCircle();
	}
}

module logoSquare() {
	difference() {
		square(52);
		translate([12, 12]) square(28);
	}
}

module logoCircle() {
	difference() {
		square(52);
		translate([26, 26]) circle(d=35);
	}
}

module logoTriangle() {
	a = 20;
	points = [[0, a], [-cos(30)*a, -sin(30)*a], [cos(30)*a, -sin(30)*a]];
	difference() {
		square(52);
		translate([26, 22]) polygon(points);
	}
}