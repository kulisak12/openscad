$fn = 15;
include<logo.scad>
include<mrizky.scad>

a = 15; // jednotková vzdálenost
numCubes = 10; // počet jednotek

// hlavní deska
border = 3; // prostor kolem hranolku, respektive vzdálenost mezi nimi
boardHeight = 9; // plná tloušťka destičky
indentDepth = 7; // hloubka díry pro hranolek

// horní část
freeSpace = 10; // meziprostor
numberedBlockHeight = 5; // výška hranolku s číslem
numberedBlockLength = 25; // délka hranolku s číslem
topIndentExtension = 5; // místo navíc na odebírání hranolku
textDepth = 1; // hloubka zářezu textu a mřížek

extraSpace = 0.5; // rezerva
roundness = 1; // zaoblení
logoDepth = 0.5; // hloubka loga
logoSize = 20; // velikost loga

chunkSize = a + border + 2*extraSpace;
boardSize = numCubes * chunkSize + border;
topSize = freeSpace + numberedBlockLength + 2*extraSpace + topIndentExtension + border;

module base() {
	translate([roundness - topSize, roundness, 0]) sphere(roundness);
	translate([chunkSize + border - roundness, roundness, 0]) sphere(roundness);
	translate([10*a + 2*border + 2*extraSpace - roundness, boardSize - chunkSize - roundness, 0]) sphere(roundness);
	translate([10*a + 2*border + 2*extraSpace - roundness, boardSize - roundness, 0]) sphere(roundness);
	translate([roundness - topSize, boardSize - roundness, 0]) sphere(roundness);
}

module chunk(size) {
	cube([a*size + 2*extraSpace, a + 2*extraSpace, indentDepth]);
}

module board() {
	difference() {
		hull() {
			translate([0, 0, roundness]) base();
			translate([0, 0, boardHeight - roundness]) base();	
		}
		// indents
		for (i = [1 : numCubes]) {
			translate([border, border + (i-1) * chunkSize, boardHeight-indentDepth]) chunk(i);
		}
		// top indents
		for (i = [1 : numCubes]) {
			translate([border - topSize, border + (i-1) * chunkSize, boardHeight-indentDepth])
			cube([numberedBlockLength + 2*extraSpace + topIndentExtension, a + 2*extraSpace, indentDepth]);
		}
	}
}

module roundedCuboid(size = [1, 1, 1], r = 1) {
	hull() {
		translate([r, r, r]) sphere(r);
		translate([r, size[1] - r, r]) sphere(r);
		translate([r, r, size[2] - r]) sphere(r);
		translate([r, size[1] - r, size[2] - r]) sphere(r);

		translate([size[0] - r, r, r]) sphere(r);
		translate([size[0] - r, size[1] - r, r]) sphere(r);
		translate([size[0] - r, r, size[2] - r]) sphere(r);
		translate([size[0] - r, size[1] - r, size[2] - r]) sphere(r);
	}
}

module numberedBlock(number) {
	rotate([0, -90, 0]) difference() {
		roundedCuboid([a, numberedBlockLength, numberedBlockHeight], roundness);
		translate([a/2, numberedBlockLength / 2, numberedBlockHeight - textDepth])
		linear_extrude(textDepth + 0.01) {
			text(str(number), size=0.65*a, halign="center", valign="center");
		}
		translate([a/4, a/4, -0.01]) resize([a/2, 0, textDepth], auto=true) grid(number);
	}
	}

// deska
difference() {
	board();
	// logo
	translate([logoSize + 2, boardSize - logoDepth, (boardHeight - 0.15*logoSize) / 2])
	rotate([90, 0, 180]) resize([logoSize, 0, 1.01*logoDepth], auto=true) logoText();
}

// hranolky
translate([0, -30, 0]) numberedBlock(7);