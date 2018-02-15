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

	linear_extrude(height = depth, center = false, convexity = 1, twist = 0, slices = 1, scale = 1.0)
		offset(rounding,$fn=64)
			square([shortwidth,shortheight],true);
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
	// Decorative & Material-saving Holes
	translate ([0,-9,0]){
		intersection() {
			union() {
				for(i=[-2:1:3]){
					translate ([0,i*30,-1]){
						cylinder(h=thickness+2,r=15,$fn=6);
						for(ra=[60,300]){
							rotate(ra,[0,0,1]) translate ([0,30,0]) cylinder(h=thickness+2,r=15,$fn=6);
						}
					}
				}
			}
			// Bounding space
			translate ([0,0,-1]) aquarishape(w-16,90,10,3);
		}
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
}
