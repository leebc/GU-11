FN=30;
FN_pod=180;

pod_outer = 					89.33;
pod_wall_inner = 			76.5;
pod_wall_thickness =		pod_outer - pod_wall_inner;

muzzle_r_first_step =		515.1 / 2;
muzzle_r_final_step =		412.08 / 2 ;
muzzle_h_first_to_final =	557.52 / 2;
muzzle_r_inner =			muzzle_r_final_step - (2 * pod_wall_thickness);




	difference() {
		union()	{
			translate()
				color("grey") 
				cylinder(r1=muzzle_r_first_step, r2=muzzle_r_final_step, 
							h=muzzle_h_first_to_final,
							center=false, $fn=FN_pod);
			translate([0,0,-10])
			color("red")
				cylinder(r=pod_wall_inner/2, 
							h=muzzle_h_first_to_final,
							center=false, $fn=FN_pod);
		
	
		}
	

		translate([0,0,-1])
			cylinder(r=muzzle_r_final_step - pod_wall_thickness, 
						h=muzzle_h_first_to_final+2, 
						center=false, $fn=FN_pod);
	}
