//!OpenSCAD

$fn = 25;

dotHeight = 0.48;
dotRadius = 0.72;
dotDistance = 2.34;
charDistance = 6.2;
lineHeight = 10;

module dot() {
    scale([dotRadius, dotRadius, dotHeight])
    difference() {
        sphere(1);
        translate([0, 0, -1])
            cube(2, center=true);
    }
}

module dotSet(d1, d2, d3, d4, d5, d6) {
    if (d1) translate([0, 0, 0]) dot();
    if (d2) translate([dotDistance, 0, 0]) dot();
    if (d3) translate([2*dotDistance, 0, 0]) dot();
    if (d4) translate([0, dotDistance, 0]) dot();
    if (d5) translate([dotDistance, dotDistance, 0]) dot();
    if (d6) translate([2*dotDistance, dotDistance, 0]) dot();
}

module character(c) {
    // regular characters
    if (c == "a") dotSet(1, 0, 0, 0, 0, 0);
    if (c == "b") dotSet(1, 1, 0, 0, 0, 0);
    if (c == "c") dotSet(1, 0, 0, 1, 0, 0);
    if (c == "d") dotSet(1, 0, 0, 1, 1, 0);
    if (c == "e") dotSet(1, 0, 0, 0, 1, 0);
    if (c == "f") dotSet(1, 1, 0, 1, 0, 0);
    if (c == "g") dotSet(1, 1, 0, 1, 1, 0);
    if (c == "h") dotSet(1, 1, 0, 0, 1, 0);
    if (c == "i") dotSet(0, 1, 0, 1, 0, 0);
    if (c == "j") dotSet(0, 1, 0, 1, 1, 0);
    if (c == "k") dotSet(1, 0, 1, 0, 0, 0);
    if (c == "l") dotSet(1, 1, 1, 0, 0, 0);
    if (c == "m") dotSet(1, 0, 1, 1, 0, 0);
    if (c == "n") dotSet(1, 0, 1, 1, 1, 0);
    if (c == "o") dotSet(1, 0, 1, 0, 1, 0);
    if (c == "p") dotSet(1, 1, 1, 1, 0, 0);
    if (c == "q") dotSet(1, 1, 1, 1, 1, 0);
    if (c == "r") dotSet(1, 1, 1, 0, 1, 0);
    if (c == "s") dotSet(0, 1, 1, 1, 0, 0);
    if (c == "t") dotSet(0, 1, 1, 1, 1, 0);
    if (c == "u") dotSet(1, 0, 1, 0, 0, 1);
    if (c == "v") dotSet(1, 1, 1, 0, 0, 1);
    if (c == "w") dotSet(1, 1, 1, 0, 1, 1);
    if (c == "x") dotSet(1, 0, 1, 1, 0, 1);
    if (c == "y") dotSet(1, 0, 1, 1, 1, 1);
    if (c == "z") dotSet(1, 0, 1, 0, 1, 1);
    // accented characters
    if (c == "á") dotSet(1, 0, 0, 0, 0, 1);
    if (c == "č") dotSet(1, 0, 0, 1, 0, 1);
    if (c == "ď") dotSet(1, 0, 0, 1, 1, 1);
    if (c == "é") dotSet(0, 0, 1, 1, 1, 0);
    if (c == "ě") dotSet(1, 1, 0, 0, 0, 1);
    if (c == "í") dotSet(0, 0, 1, 1, 0, 0);
    if (c == "ň") dotSet(1, 1, 0, 1, 0, 1);
    if (c == "ó") dotSet(0, 1, 0, 1, 0, 1);
    if (c == "ř") dotSet(0, 1, 0, 1, 1, 1);
    if (c == "š") dotSet(1, 0, 0, 0, 1, 1);
    if (c == "ť") dotSet(1, 1, 0, 0, 1, 1);
    if (c == "ú") dotSet(0, 0, 1, 1, 0, 1);
    if (c == "ů") dotSet(0, 1, 1, 1, 1, 1);
    if (c == "ý") dotSet(1, 1, 1, 1, 0, 1);
    if (c == "ž") dotSet(0, 1, 1, 1, 0, 1);
    // special
    if (c == " ") dotSet(0, 0, 0, 0, 0, 0);
    if (c == "#") dotSet(0, 0, 1, 1, 1, 1); // number prefix
    if (c == "^") dotSet(0, 0, 0, 0, 0, 1); // capital letter prefix
}

module braille(message) {
    for (i = [0 : len(message) - 1])
        translate([0, i*charDistance, 0])
            character(message[i]);
}

// ### Objects ###

translate([-4, -2, 0]) cube([23, 70, 2]);
translate([0, 0, 2]) braille("^gymnázium");
translate([lineHeight, 0, 2]) braille("^nad ^alejí");