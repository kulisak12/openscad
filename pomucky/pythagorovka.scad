$fn = 20;

r = 1;
rezerva = 1;
h = 4 - 2*r;

a = 35;
b = 65;
size = a + b + 6*r + rezerva;

module triangle() {
	minkowski() {
		linear_extrude(h) polygon(points=[
			[0, 0],
			[0, a],
			[b, 0]
		]);
		sphere(r);
	}
}

module frame() {
	minkowski() {
		difference() {
			cube([size + 10, size + 10, h + 2*r]);
			translate([5, 5, 0.1]) cube([size, size, h + 2*r]);
		}
		sphere(r);
	}
}

for (i = [0 : 3])
translate([0, i * (a + 5), 0]) triangle();

translate([0, -150, 0]) frame();