$fn = 15;
include<logo.scad>

a = 15; // jednotková vzdálenost
numCubes = 10; // počet jednotek

border = 3; // prostor kolem hranolku, respektive vzdálenost mezi nimi
boardHeight = 9; // plná tloušťka destičky
indentDepth = 7; // hloubka díry pro hranolek
extraSpace = 0.5; // rezerva

roundness = 1; // zaoblení
logoDepth = 0.5; // hloubka loga
logoSize = 20; // velikost loga

chunkSize = a + border + 2*extraSpace;
boardSize = numCubes * chunkSize + border;

module base() {
	translate([roundness, roundness, 0]) sphere(roundness);
	translate([chunkSize + border - roundness, roundness, 0]) sphere(roundness);
	translate([10*a + 2*border + 2*extraSpace - roundness, boardSize - chunkSize - roundness, 0]) sphere(roundness);
	translate([10*a + 2*border + 2*extraSpace - roundness, boardSize - roundness, 0]) sphere(roundness);
	translate([roundness, boardSize - roundness, 0]) sphere(roundness);
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
	}
}

difference() {
	board();
	// logo
	translate([logoSize + 2, boardSize - logoDepth, (boardHeight - 0.15*logoSize) / 2])
	rotate([90, 0, 180]) resize([logoSize, 0, 1.01*logoDepth], auto=true) logoText();
}