include<gu-11-headers.scad>;

FN=30;
FN_pod=60;

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

ammo_chamber_middle_r =	(pod_r_wall_inner-ammo_chamber_inner_r)/2 + ammo_chamber_inner_r ;
ammo_feeder_cut_r = pod_r_wall_inner - 2 ;
		// WAS ammo_r * 0;  // WAS *3/4
		// WAS ammo_chamber_half_inner_r + 1;
ammo_feeder_outer_r = pod_r_wall_inner - 2;
// ammo_feeder_circle_position_r = pod_r_wall_inner;
		// WAS ammo_chamber_inner_r + ammo_d * 0 ;
		// WAS ammo_chamber_half_inner_r - 1 ;
// ammo_offset = 6;
		// WAS sqrt(3*ammo_feeder_circle_position_r*ammo_feeder_circle_position_r);
ammo_slot_center_r = ammo_feeder_outer_r - ammo_r;
ammo_slot_r = pvc_05in_315psi_r_inner ;
//ammo_slot_r = pvc_05in_r_outer;
 

echo(" *** This block of ECHOs from ammo_feeder-05in_pvc.scad ***");
echo("ammo_chamber_middle_r= ", ammo_chamber_middle_r);
echo("ammo_feeder_cut_r ", ammo_feeder_cut_r);
echo("ammo_feeder_circle_position_r ", ammo_feeder_circle_position_r);
echo("ammo_offset = ", ammo_offset );
echo("sqrt 3 * r = " , sqrt(3) * ammo_feeder_circle_position_r, "(should match above)");

echo("ammo_slot_r ", ammo_slot_r);


// Zero Pane
* zero_pane();


// Center pin
*color("red")	cylinder(r=1, h= 2* muzzle_h_insert);


//  This test piece shows full inner diameter of pod
%		translate([0,0,muzzle_h_insert/2])
			cylinder(r=pod_r_wall_inner, //muzzle_r_first_step, 
					h=muzzle_h_insert,
					center=true, $fn=FN_pod);



//projection(cut=false)	//  MAKE IT Flat!
{	//  MAKE IT Flat!

//color("blue")
	difference(){
//		union(){
			color("blue")
				translate([0,0,muzzle_h_insert/2])
					cylinder(r=ammo_feeder_outer_r,
								h=muzzle_h_insert,
								center=true, $fn=FN_pod);


		union() color("red") {

		// ===== These are the holes for the PVC =====
			// top
			translate([0,pvc_05in_offset*2/3,muzzle_h_insert/2])
				cylinder(r=pvc_05in_r_outer, 
							h=muzzle_h_insert+2,
							center=true, $fn=FN_pod);
			//bottom left
			translate([-pvc_05in_r_outer,pvc_05in_offset/-3,muzzle_h_insert/2])
				cylinder(r=pvc_05in_r_outer, 
							h=muzzle_h_insert+2,
							center=true, $fn=FN_pod);
			//bottom right
			translate([pvc_05in_r_outer,pvc_05in_offset/-3,muzzle_h_insert/2])
				cylinder(r=pvc_05in_r_outer, 
							h=muzzle_h_insert+2,
							center=true, $fn=FN_pod);

			// On center
			translate([0,0,muzzle_h_insert/2])
				cylinder(r=pvc_05in_r_outer*2/3, 
							h=muzzle_h_insert+2,
							center=true, $fn=FN_pod);


		// ===== These are the slots for the darts =====
			for ( slot_angle = [ -120, 0, 120 ])  
			{
				rotate([0,0,slot_angle+60])
					translate([0,ammo_slot_center_r,muzzle_h_insert/2])
					{
						cylinder(r=ammo_slot_r, 
									h=muzzle_h_insert+2,
									center=true, $fn=FN_pod);
						translate([0,ammo_slot_r,0])
							cube([ammo_slot_r*2, ammo_slot_r*2, muzzle_h_insert+2], center=true);
					}
			}
			// End Dart slots


// Comment out this block to get the solid piece
			// Thin circle that cuts out `bearing ring`
*			translate([0,0,muzzle_h_insert/2])
			difference()
			{
				cylinder(r=ammo_chamber_inner_r + 0.1, 
							h=muzzle_h_insert+2,
							center=true, $fn=FN_pod);
				cylinder(r=ammo_chamber_inner_r, 
							h=muzzle_h_insert+2,
							center=true, $fn=FN_pod);
			}

		}	// End union of differences
}	// End difference

} //end projection