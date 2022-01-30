$fn = 20;

vyska = 3;
kulatost = 1;

for (i=[0:4]){
    translate([150*i,0,0]) KulatyTvar([100/(2*pow(2,i)), 100/(pow(2,i)), vyska], kulatost);
    translate([150*i+75,0,0]) KulatyTvar([100/(2*pow(2,i)),100/(2*pow(2,i)),vyska], kulatost);
    }
//KulatyTvar([5,4,vyska],kulatost);


module KulatyTvar (rozmery, r){
    hull(){
        translate([r,r,r]) sphere(r);
        translate([rozmery[0]-r,r,r]) sphere(r);
        translate([r,rozmery[1]-r,r]) sphere(r);
        translate([rozmery[0]-r,rozmery[1]-r,r]) sphere(r);
        translate([r,r,rozmery[2]-r]) sphere(r);
        translate([rozmery[0]-r,rozmery[1]-r,rozmery[2]-r]) sphere(r);
        translate([rozmery[0]-r,r,rozmery[2]-r]) sphere(r);
        translate([r,rozmery[1]-r,rozmery[2]-r]) sphere(r);
        }
    }