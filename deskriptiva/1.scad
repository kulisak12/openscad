u = 10;
include<deskriptiva.scad>

color("Lime") magnify(0.3)
transform([-3, 1, 5], [3, 4, 3], [-3, 1, 5])
unitLine();

color("Yellow")
transform([0, 1, 7], [-3, 6, 2], [0, 6, 0])
unitParallelogram();