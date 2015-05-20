FN=30;
FN_pod=180;

pod_r_outer = 					89.33 /2;
pod_r_wall_inner = 			76.5 /2;
pod_wall_thickness =		pod_r_outer - pod_r_wall_inner;

muzzle_r_first_step =		44.66 /2 ;
muzzle_r_final_step =		35.72 /2 ;
muzzle_h_first_to_final =	48.34 ;

muzzle_r_inner =			muzzle_r_final_step - pod_wall_thickness ;

muzzle_r_insert =			pod_r_wall_inner;
muzzle_h_insert =			20;




difference() {
	union()	{
		color("grey") 
			translate()
				cylinder(r1=muzzle_r_first_step, r2=muzzle_r_final_step, 
							h=muzzle_h_first_to_final,
							center=false, $fn=FN_pod);


		color("red") 			// insert
			translate([0,0,-muzzle_h_insert])
				cylinder(r=muzzle_r_insert,
							h=muzzle_h_insert,
							center=false, $fn=FN_pod);
		
	
		}
	

		translate([0,0,-1-muzzle_h_insert])
			cylinder(r=muzzle_r_inner, 
						h=muzzle_h_first_to_final + muzzle_h_insert + 2 ,
						center=false, $fn=FN_pod);
	}


// Pod barrel

		color("yellow")
		translate([0,0,-muzzle_h_insert])
			cylinder(r=pod_r_outer,
						h=10,
						center=false, $fn=FN_pod);