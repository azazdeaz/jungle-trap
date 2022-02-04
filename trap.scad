use <stick.scad>;

width = 100;
depth = 100;
height = 60;
stick_count = 9;
wall_width = 2;
ledge_width = 5;
ledge_height = 46;

ww2 = wall_width*2;



difference() {
    cube([width, depth, height], center = true);
    translate([0,0,wall_width])
cube([width - ww2, depth - ledge_width*2, height], center = true);
    translate([0,0,ledge_height])
    cube([width - ww2, depth - ww2, height], center = true);
};

rotate([90,0,0])
translate([width,0,0])
stick((width-ww2) / stick_count,1.2,depth - ww2 - 2);