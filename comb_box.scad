// height of the triangle without rounding
size = 12;
// radius of the edge rounding
rounding = 1.2;

module tooth_profile() {
    ox = 0;
    oy = 0;
    oa = tan(30) * size/2;
    ax = ox + cos(30) * oa;
    ay = oy + sin(30) * oa;
    raw_height = sqrt(pow(size/2,2) + pow(oa,2));
    rounding_center = raw_height - rounding/sin(30);
    echo("rounding_center", rounding_center);
    arc = [for (i=[30:2:90]) [
        cos(i)*rounding, 
        rounding_center + sin(i)*rounding
    ]];
    polygon(concat([[ox,oy],[ax,ay]], arc));
}
module third() {
    tooth_profile();
    mirror([1,0,0])
    tooth_profile();
}
//tooth_profile();
for (i = [0,120,240]) {
    rotate([0,0,i])
    third();
 }
//tooth_length = 45;
//
//translate([0,0,tooth_length])
//rotate([-90,0,0])
//rotate_extrude(angle=360)
//rotate([0,0,0])
//tooth_profile();
//
//linear_extrude(tooth_length)
//union() {
//    mirror()
//    tooth_profile();
//    tooth_profile();
//}