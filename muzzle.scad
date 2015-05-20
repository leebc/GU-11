FN=30;
FN_pod=60;

pod_r_outer = 					89.33 /2;
pod_r_wall_inner = 			76.5 /2;
pod_wall_thickness =		pod_r_outer - pod_r_wall_inner;

muzzle_r_first_step =		44.66 /2 ;
muzzle_r_final_step =		35.72 /2 ;
muzzle_h_first_to_final =	48.34 ;

muzzle_r_inner =			muzzle_r_final_step - pod_wall_thickness ;

muzzle_r_insert =			pod_r_wall_inner;
muzzle_h_insert =			20;


// zero pane
*color("lightblue")  cube([100,100,0.1], center=true);

// Top of round bit
*translate([0,0,muzzle_h_insert+muzzle_r_first_step])
	color("lightblue")  cube([100,100,0.1], center=true);

difference() {
	union()	{
		color("lightgrey")	// Very tip of muzzle
			translate([0,0,muzzle_h_insert+muzzle_r_first_step])
				cylinder(r1=muzzle_r_first_step, r2=muzzle_r_final_step, 
							h=muzzle_h_first_to_final,
							center=false, $fn=FN_pod);

		color("grey")	// below tip of muzzle
			translate([0,0,muzzle_h_insert+muzzle_r_first_step-muzzle_r_first_step/2+0.1])
				cylinder(r=muzzle_r_first_step, 
							h=muzzle_r_first_step+0.2,
							center=true, $fn=FN_pod);
//  *** Need to curve the tip of this

//		color("blue")
			difference(){
				union(){
					color("blue")
						//  The curved bit
						translate([0,0,muzzle_h_insert])
						hull()
							rotate_extrude(convexity = 10)	//$fn=FN_pod)
								translate([muzzle_r_first_step,0,0])
									circle(r = muzzle_r_first_step, $fn=FN_pod ); 

					sphere(r=1);
				}

				union(){
				// Cut the round part in half
				translate([0,0,muzzle_r_first_step/2+(muzzle_h_insert-muzzle_r_first_step)])
						cube([4*muzzle_r_first_step,4*muzzle_r_first_step, muzzle_r_first_step],
							 center=true);

				// carve out a hollow around the tip
				translate([0,0,muzzle_h_insert+muzzle_r_first_step])//-muzzle_r_first_step/2+0.1])
					cylinder(r=muzzle_r_first_step + 1, 
								h=muzzle_r_first_step+0.2,
								center=true, $fn=FN_pod);

				// Cut out notches
				translate([0,0,muzzle_h_insert+muzzle_r_first_step])
					{
						rotate([0,0,0])
							cube([10,pod_r_outer*2,muzzle_r_first_step], center=true);
						rotate([0,0,45])
							cube([10,pod_r_outer*2,muzzle_r_first_step], center=true);
						rotate([0,0,90])
							cube([10,pod_r_outer*2,muzzle_r_first_step], center=true);
						rotate([0,0,135])
							cube([10,pod_r_outer*2,muzzle_r_first_step], center=true);
					}   // End notches translate

				}
			}
		

		color("red") 			// insert
			translate([0,0,muzzle_h_insert/2])
				cylinder(r=muzzle_r_insert,
							h=muzzle_h_insert,
							center=true, $fn=FN_pod);
		
	
		}
	
	// This is what gets differenced from the whole thing
		translate([0,0,(muzzle_h_first_to_final + muzzle_h_insert + muzzle_r_first_step + 2)/2])
			cylinder(r=muzzle_r_inner, 
						h=muzzle_h_first_to_final + muzzle_h_insert + muzzle_r_first_step + 5 ,
						center=true, $fn=FN_pod);
}


// Pod barrel
*		color("yellow")
		translate([0,0,-10-muzzle_r_first_step])
			cylinder(r=pod_r_outer,
						h=10,
						center=false, $fn=FN_pod);

//color("slategrey")
//color("black")
//color("purple")
//color("LightSteelBlue")
//color("green")