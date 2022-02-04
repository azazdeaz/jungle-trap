// triangle base width including rounding
size = 1;
// radius of the edge rounding
rounding = .100;

// right side of the top third triangle section
module section(size, rounding) {
    //triangle side length w/o rounding
    side = (size - rounding*2) + rounding/tan(30) * 2;
    // triangle height w/o rounding
    height = sqrt(3)/2 * side;
    // triangle center
    ox = 0;
    oy = 0;
    // length of the line from the center to a side (perpendicular)
    oa = sqrt(3)/3 * side/2;
    // point on the middle of the right side
    ax = ox + cos(30) * oa;
    ay = oy + sin(30) * oa;
    // length from triangle center to a corner
    raw_height = side*sqrt(3)/3;
    rounding_center = raw_height - rounding * 2;
    echo("rounding_center", rounding_center);
    arc = [for (i=[30:2:90]) [
        cos(i)*rounding, 
        rounding_center + sin(i)*rounding
    ]];
    polygon(concat([[ox,oy],[ax,ay]], arc));
}
module third(size, rounding) {
    section(size, rounding);
    mirror([1,0,0])
    section(size, rounding);
}

module stick_profile(size, rounding) {
    for (i = [0,120,240]) {
        rotate([0,0,i])
        third(size, rounding);
    }
}

module stick(width, rounding, length) {
    linear_extrude(length)
    stick_profile(width, rounding);
}


stick(size, rounding, 5);