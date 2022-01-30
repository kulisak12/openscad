$fn = 25;

difference() {
  cube([60, 10, 3]);
  translate([1, 3, 2.5])
  linear_extrude(height = 1) {
    text("70", size=4);
  }
}