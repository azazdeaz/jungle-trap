// triangle base width including rounding
size = 1;
// radius of the edge rounding
rounding = .010;
//triangle side length w/o rounding
side = (size - rounding*2) + rounding/tan(30) * 2;
echo("side" ,side);
// triangle height w/o rounding
height = sqrt(3)/2 * side;
echo("height" ,height);

// right side of the top third triangle section
module section() {
    ox = 0;
    oy = 0;
    // length of the line from the center to a side (perpendicular)
    oa = sqrt(3)/3 * side/2;
    // point on the middle of the right side
    ax = ox + cos(30) * oa;
    ay = oy + sin(30) * oa;
    // length from triangle center to a corner
    raw_height = sqrt(pow(height/2,2) + pow(oa,2));
    rounding_center = raw_height - (side-size)/2 - rounding;
    echo("rounding_center", rounding_center);
    arc = [for (i=[30:2:90]) [
        cos(i)*rounding, 
        rounding_center + sin(i)*rounding
    ]];
    polygon(concat([[ox,oy],[ax,ay]], arc));
}
module third() {
    section();
    mirror([1,0,0])
    section();
}

module stick_profile() {
    for (i = [0,120,240]) {
        rotate([0,0,i])
        third();
    }
}
linear_extrude(5)
stick_profile();

section();