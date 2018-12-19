stroke = 10;

bridge = 12;

height = 32;

module foot() {
    difference() {
        cube([stroke, stroke, bridge + (stroke / 2)], center=false);
        translate([stroke/2, stroke/2, bridge + stroke / 2 -0.5]) cylinder(h=2, r=4.4);
    }
}

cube([stroke, height, stroke / 2]);
translate([0, -stroke, 0]) foot();
translate([0, height, 0]) foot();

