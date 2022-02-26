use <stick.scad>;
$fn=100;
width = 40;
depth = 60;
height = 40;
stick_count = 8;
wall_width = 1.2;
ledge_width = 2.5;
ledge_height = 25;
rim_height = 12;
rim_bloat = 7;

ww2 = wall_width*2;





//module box() {
//    difference() {
//        cube([width, depth, height], center = true);
//        translate([0,0,wall_width])
//    cube([width - ww2, depth - ledge_width*2, height], center = true);
//        translate([0,0,ledge_height])
//        cube([width - ww2, depth - ww2, height], center = true);
//    };    
//}

rotate([90,0,0])
translate([width,0,0])
stick((width-(ww2+0.3*stick_count)) / stick_count,1.2,depth - ww2 - 0.5);

//box();
//linear_extrude(height=30)
//linear_extrude(height=height)
//square([width, depth], center=true);

module footprint() {
    cube([width, depth, 0.1], center=true);
}

module inner_footprint() {
    cube([width-wall_width*2, depth-wall_width*2, 0.1], center=true);
}

module box() {
    hull() {
        translate([0,0,height])
        children();
        children();
    }



    rim_start = height;
    rim_end = rim_start + rim_height;
    step_size = 1;
    function f(i) = 1+ pow((i-rim_start) / rim_height,2); 
    function easeInOutQuad(x) = x < 0.5 ? 2 * x * x : 1 - pow(-2 * x + 2, 2) / 2;
    function rim_profile(h) = easeInOutQuad((h-rim_start) / rim_height);
    function rim_profile_scale(h) = [1,1] + rim_profile(h) * [(width+rim_bloat)/width-1, (height+rim_bloat)/height-1];

    for(i=[rim_start:step_size:rim_end]) {
        echo("III", i, rim_profile(i))
        hull() {
            translate([0,0,i])
            scale(rim_profile_scale(i))
            children();
            translate([0,0,i+step_size])
            scale(rim_profile_scale(i+step_size))
            children();
        }
    }
}

difference() {
    box()
    footprint();
    
    translate([0,0,wall_width])
    box()
    inner_footprint();
}


//step = 10;
//for (i=[0:step:153])
//hull()
//{
//  translate([0, 0, i])
//    scale(f(i)*[1,1.19255])
//      cylinder(r=161/2, h = .01);
//  translate([0, 0, i+step])
//    scale(f(i+step)*[1,1.19255])
//      cylinder(r=161/2, h = .01);
//}
//
//function f(i) = 1+ pow(i/200,2); 