/*
 * bq Aquaris A4.5 case
 */

// bq provided dimensions:
w = 63.48;
h = 131.77;
d = 9.25;

// Measured/estimated dimensions:
r = 5.5;

module aquarishape(width,height,depth,rounding){
	// Intermediate variables:
	shortwidth = width - 2*rounding;
	shortheight = height - 2*rounding;

	union() {
		// Bottom parallelepiped:
		translate([-shortwidth/2,-height/2,0]){
			cube([shortwidth,rounding,depth]);
		}

		// Middle parallelepiped:
		translate([-width/2,-shortheight/2,0]){
			cube([width,shortheight,depth]);
		}

		// Top parellelepiped:
		translate([-shortwidth/2,shortheight/2,0]){
			cube([shortwidth,rounding,depth]);
		}

		// Rounded corners:
		for(i=[-1,1]){
			for(j=[-1,1]){
				translate([i*shortwidth/2,j*shortheight/2,0]){
					cylinder(h=depth,r=rounding,$fn=64);
				}
			}
		}
	}
}

// Case:
tolerance = 0.6;
thickness = 2.4;
clip = 1.6;

difference() {
	union() {
		// Main case
		aquarishape(w + tolerance + thickness,
			h + tolerance + thickness,
			d + tolerance + thickness,
			r + (tolerance + thickness)/2);
	}
	// Case cavities
	translate([0,0,thickness/2]){
		aquarishape(w + tolerance,
			h + tolerance,
			d + tolerance,
			r + tolerance/2);
		aquarishape(w - clip,
			h - clip,
			d + tolerance + thickness,
			r - clip/ 2);
	}
	// Charging port and speakers
	translate ([0,-h/2-tolerance - thickness,d+thickness]) rotate(-90,[1,0,0]){
		aquarishape(w - 2*r - 4,2*d,0.6*h,r);
	}
	// Audio jack
	translate ([0,h/2-tolerance - thickness,d+thickness]) rotate(-90,[1,0,0]){
		aquarishape(w - 2*r - 26,2*d,0.6*h,r);
	}
	// Camera hole
	translate ([w/2-4-8,h/2-2-5.5,0]) aquarishape(16,11,thickness,1);
	// Volume & Locking Buttons
	translate ([w/2-tolerance/2-clip/2,h/2-70,0]) cube([2*thickness,42,1.5*d]);
	// Decorative & Material-saving Holes
	translate ([0,-10,0]){
		difference() {
			union() {
				cylinder(h=thickness,r=15,$fn=6);
				for(ra=[0:60:360]){
					rotate(ra,[0,0,1]) translate ([0,30,0]) cylinder(h=thickness,r=15,$fn=6);
				}
			}
			// Bounding cubes
			translate ([w/2-3*thickness,-h/2,0]) cube([10,h,10]);
			translate ([-w/2-10+3*thickness,-h/2,0]) cube([10,h,10]);
			translate ([-w/2-thickness, -h/2-thickness, 0]) cube([w+2*thickness,10,10]);
			translate ([-w/2-thickness, h/2-25+thickness, 0]) cube([w+2*thickness,25,10]);
		}
	}
}
