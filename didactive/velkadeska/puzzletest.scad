$fn = 12;
include<logo.scad>

a = 15; // jednotková vzdálenost
startSize = 2; // nejmenší jednotka
endSize = 3; // největší jednotka
numCubes = endSize - startSize + 1; // počet jednotek

// hlavní deska
border = 3; // prostor kolem hranolku, respektive vzdálenost mezi nimi
boardHeight = 9; // plná tloušťka destičky
indentDepth = 7; // hloubka díry pro hranolek
puzzleEnlargement = 0.2; // rezerva puzzlíku

// horní část
freeSpace = 0; // meziprostor
numberedBlockHeight = 5; // výška hranolku s číslem
numberedBlockLength = 0; // délka hranolku s číslem
topIndentExtension = 0; // místo navíc na odebírání hranolku
textDepth = 1; // hloubka zářezu textu a mřížek


extraSpace = 0.5; // rezerva
roundness = 1; // zaoblení
logoDepth = 0.5; // hloubka loga
logoSize = 20; // velikost loga

chunkSize = a + border + 2*extraSpace;
boardSize = numCubes * chunkSize + border;
topSize = 0; //freeSpace + numberedBlockLength + 2*extraSpace + topIndentExtension + border;

module base() {
	translate([roundness - topSize, roundness, 0]) sphere(roundness);
	translate([chunkSize + (startSize-1) * a + border - roundness, roundness, 0]) sphere(roundness);
	translate([endSize*a + 2*border + 2*extraSpace - roundness, boardSize - chunkSize - roundness, 0]) sphere(roundness);
	translate([endSize*a + 2*border + 2*extraSpace - roundness, boardSize - roundness, 0]) sphere(roundness);
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
		for (i = [0 : numCubes - 1]) {
			translate([border, border + i * chunkSize, boardHeight-indentDepth]) chunk(startSize + i);
		}
		// top indents
		for (i = [0 : numCubes - 1]) {
			translate([border - topSize, border + i * chunkSize, boardHeight-indentDepth])
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

module finalShape() {
	// deska
	difference() {
		board();
		// logo
		translate([logoSize + 2, boardSize - logoDepth, (boardHeight - 0.15*logoSize) / 2])
		rotate([90, 0, 180]) resize([logoSize, 0, 1.01*logoDepth], auto=true) logoText();
	}
}

module puzzle(size, larger) {
	minkowski() {
		union() {
			square([size, size/2], center=true);
			translate([3/4*size, 0]) circle(d=size, $fn=40);
		}
		if (larger) {
			circle(puzzleEnlargement);
		}
	}
}

module splitter(larger) {
	translate([-100, -1, -1]) cube([100 + 0.4 * endSize * a, boardSize + 2, boardHeight + 2]);
	translate([0.4 * endSize * a, border + a/2 + extraSpace, -1])
	linear_extrude(boardHeight + 2) puzzle(0.75*a, larger);
	translate([0.4 * endSize * a, boardSize - border - a/2 - extraSpace, -1])
	linear_extrude(boardHeight + 2) puzzle(0.75*a, larger);
}


// část 1
intersection() {
	finalShape();
	splitter(false);
}

// část 2
translate([0, 50, 0]) difference() {
	finalShape();
	splitter(true);
}