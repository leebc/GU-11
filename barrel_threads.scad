include<gu-11-headers.scad>;

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
echo("ammo_length ", ammo_length);
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

ammo_chamber_half_inner_r =	(pod_r_wall_inner-ammo_chamber_inner_r)/2 + ammo_chamber_inner_r ;
ammo_feeder_cut_r = ammo_chamber_inner_r + ammo_d * 1;  // WAS *3/4
		// WAS ammo_chamber_half_inner_r + 1;
ammo_feeder_circle_position_r = ammo_chamber_inner_r + ammo_d * 1/4 ;
		// WAS ammo_chamber_half_inner_r - 1 ;
ammo_offset = 	sqrt(3*ammo_feeder_circle_position_r*ammo_feeder_circle_position_r);

ammo_slot_r = pvc_05in_315psi_r_inner ;
ammo_slot_r = pvc_05in_r_outer;

thread_depth = ammo_d ;
thread_width = 10 ;
thread_segment_height = 20 ; 
thread_seperation_height = 7 ; 

echo(" *** This block of ECHOs from ammo_feeder-05in_pvc.scad ***");
echo("ammo_chamber_half_inner_r= ", ammo_chamber_half_inner_r);
echo("ammo_feeder_cut_r ", ammo_feeder_cut_r);
echo("ammo_feeder_circle_position_r ", ammo_feeder_circle_position_r);
echo("ammo_offset = ", ammo_offset );
echo("thread_depth ", thread_depth);
echo("thread_width ", thread_width);

echo("sqrt 3 * r = " , sqrt(3) * ammo_feeder_circle_position_r, "(should match above)");

echo("ammo_slot_r ", ammo_slot_r);


// Zero Pane
* zero_pane();


// Center pin
*color("red")	cylinder(r=1, h= 2* muzzle_h_insert);


//  This test piece shows full inner diameter of pod
*		translate([0,0,muzzle_h_insert/2])
			cylinder(r=pod_r_wall_inner, //muzzle_r_first_step, 
					h=muzzle_h_insert,
					center=true, $fn=FN_pod);

//	This prints a rough dart
*color("orange")
	translate([pod_r_wall_inner-ammo_r -1,0,5])
		cylinder(r=ammo_r,h=ammo_length);



	difference(){
		union(){
			color("blue")
			//	linear_extrude(height = fanwidth, center = true, convexity = 10, twist = -fanrot, slices = 20, scale = 1.0) {...}
				linear_extrude(height = ammo_length +10 , twist = -360, slices = 60) {
					translate([pod_r_wall_inner-thread_depth/2 - 1,0,0])
			    	  square([thread_depth,thread_width], center = true);	
				}


		// End union

		*		translate([0,0,muzzle_h_insert/2])
					cylinder(r=ammo_chamber_half_inner_r,
								h=muzzle_h_insert,
								center=true, $fn=FN_pod);
		}  // End union 

		union() color("red") {
			translate([0,0,50+20])
				cube([100,100,100], center = true);
			

		}	// End union of differences
}	// End difference

	//Cylinder wall
	difference(){
			color("green")
				difference(){
					cylinder(r=pod_r_wall_inner, h=ammo_length +10, $fn=FN_pod );
					translate([0,0,-1])
						cylinder(r=pod_r_wall_inner-1, h=ammo_length +10 +2 , $fn= FN_pod);
				}  //End difference

			translate([0,0,50+20+thread_seperation_height])
				cube([100,100,100], center = true);
	}
