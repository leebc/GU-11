include <gu-11-headers.scad>;

FN=30;
FN_pod=90;

echo(" *** This block ECHOs values from gu-11-headers.scad *** ");
echo("pod_r_outer ", pod_r_outer);
echo("pod_r_wall_inner ", pod_r_wall_inner);
echo("pod_wall_thickness ", pod_wall_thickness);
echo("muzzle_r_inner ", muzzle_r_inner);
echo("muzzle_r_insert ",muzzle_r_insert);
echo("muzzle_h_insert ",muzzle_h_insert);
echo("muzzle_r_first_step ", muzzle_r_first_step);
echo("muzzle_r_final_step ", muzzle_r_final_step);
echo("muzzle_h_first_to_final ", muzzle_h_first_to_final);
echo("ammo_d ", ammo_d	 );
echo("ammo_r ", ammo_r	);
echo("ammo_chamber_inner_r ", ammo_chamber_inner_r);
echo("pvc_05in_diameter_outer ", pvc_05in_diameter_outer);
echo("pvc_05in_600psi_diameter_inner ", pvc_05in_600psi_diameter_inner);
echo("pvc_05in_315psi_diameter_inner ", pvc_05in_315psi_diameter_inner);
echo("pvc_05in_hamper_diameter_inner ", pvc_05in_hamper_diameter_inner);
echo("pvc_05in_r_outer ", pvc_05in_r_outer);
echo("pvc_05in_315psi_r_inner ", pvc_05in_315psi_r_inner);
echo("pvc_05in_600psi_r_inner ", pvc_05in_600psi_r_inner);
echo("pvc_05in_hamper_r_inner ", pvc_05in_hamper_r_inner);
echo("pvc_05in_offset ", pvc_05in_offset);

echo(" *** This block of ECHOs from pvc_hoder-0.5in.scad ***");
echo("sqrt 3 * r = " , sqrt(3) * pvc_05in_r_outer, "(should match above)");

muzzle_h_insert=0;		// OVERRIDE  How far into the pod the muzzle is inserted between 5 and 20
muzzle_step=20;		// 20 is a guess as to the should be height of the curvy piece


// Zero Pane
*zero_pane();

// Center pin
*color("red")	cylinder(r=1, h= 7* muzzle_h_insert);

scale([1,1,1])
difference() {
	union()	{

		color("yellow")
		translate([0,0,0])
			cylinder(r=pod_r_outer,
						h=muzzle_step,
						center=false, $fn=FN_pod);

		color("blue")
		translate([0,0,muzzle_step])
			scale([1,1,0.55])
				difference()
				{
					sphere(r=pod_r_outer, $fn=FN_pod);
					
					color("purple")
					union(){
						translate([-pod_r_outer,-pod_r_outer,-pod_r_outer*2])
							cube([pod_r_outer*2,pod_r_outer*2,pod_r_outer*2]);

						translate([0,0,pod_r_outer*3/4])
							cylinder(r=ammo_chamber_inner_r+pod_wall_thickness + 1, 
										h=pod_r_outer,
										center=true, $fn=FN_pod);

						// Cut out notches
						translate([0,0,0*muzzle_h_insert+muzzle_r_first_step])
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

					}	// End union what is differenced form the curvy part
				}	// End difference the curvy part (blue)


		color("grey")	// Main Muzzle tip
			translate([0,0,muzzle_step*2.5])
				cylinder(r1=ammo_chamber_inner_r+pod_wall_thickness, 
							r2=ammo_chamber_inner_r+pod_wall_thickness-2.5,
							h=muzzle_step*3,
							center=true, $fn=FN_pod);

		color("lightgrey")	// Very tip of muzzle
			translate([0,0,muzzle_step*4])
				cylinder(r1=ammo_chamber_inner_r+pod_wall_thickness-2.5,
							r2=ammo_chamber_inner_r,
							h=2,
							center=false, $fn=FN_pod);

		color("blue")
//			difference(){
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

	*			union(){
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

	//			}
			}
		

		color("red") 			// inserts into pod
			translate([0,0,-muzzle_h_insert/2])
				cylinder(r=muzzle_r_insert,
							h=muzzle_h_insert,
							center=true, $fn=FN_pod);
		
	
		}
	
	// This is what gets differenced from the whole thing
		translate([0,0,-muzzle_h_insert])
					//WAS  muzzle_h_first_to_final + muzzle_h_insert + muzzle_r_first_step + 2)/2])
			cylinder(r=ammo_chamber_inner_r,    // WAS muzzle_r_inner, 
						h=300,
					// WAS muzzle_h_first_to_final + muzzle_h_insert + muzzle_r_first_step + 5 ,
						center=true, $fn=FN_pod);
			//cube([500,500,500]);
}


// Pod barrel diameter
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