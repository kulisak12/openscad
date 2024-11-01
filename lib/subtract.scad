// module subtr_2d(radius) {
//     render() difference() {
//         children();
//         minkowski() {
//             difference() {
//                 minkowski() {
//                     children();
//                     square(1, center = true);
//                 }
//                 children();
//             }
//             circle(radius);
//         }
//     }
// }

module subtr_2d(radius, bbox = 1000) {
    render() difference() {
        children();
        minkowski() {
            difference() {
                square(bbox, center = true);
                children();
            }
            circle(radius);
        }
    }
}

module subtr_3d(radius, bbox = 1000) {
    render() difference() {
        children();
        minkowski() {
            difference() {
                cube(bbox, center = true);
                children();
            }
            sphere(radius);
        }
    }
}
