pod_r_outer = 			89.33 /2;
pod_r_wall_inner = 		76.5 /2;
pod_wall_thickness =		pod_r_outer - pod_r_wall_inner;

muzzle_r_first_step =		44.66 /2 ;
muzzle_r_final_step =		35.72 /2 ;
muzzle_h_first_to_final =	48.34 ;

muzzle_r_inner =			muzzle_r_final_step - pod_wall_thickness ;

muzzle_r_insert =			pod_r_wall_inner;
muzzle_h_insert =			20;


// zero plane
*color("lightblue")  cube([100,100,0.1], center=true);


// Pod barrel
*		color("yellow")
		translate([0,0,-10-muzzle_r_first_step])
			cylinder(r=pod_r_outer,
						h=10,
						center=false, $fn=FN_pod);

FN_pod=90;

pod_r_outer = 					89.33 /2;
pod_r_wall_inner = 			76.5 /2;
pod_wall_thickness =		pod_r_outer - pod_r_wall_inner;

muzzle_r_first_step =		44.66 /2 ;
muzzle_r_final_step =		35.72 /2 ;
muzzle_h_first_to_final =	48.34 ;

muzzle_r_inner =			muzzle_r_final_step - pod_wall_thickness ;

muzzle_r_insert =			pod_r_wall_inner;
muzzle_h_insert =			5;

pvc_05in_diameter_outer=			21.35;
pvc_05in_315psi_diameter_inner=	18.24;
pvc_05in_600psi_diameter_inner=	15.35;

pvc_05in_r_outer=					pvc_05in_diameter_outer / 2 ;
pvc_05in_315psi_r_inner=			pvc_05in_315psi_diameter_inner / 2;
pvc_05in_600psi_r_inner=			pvc_05in_600psi_diameter_inner / 2;
pvc_05in_offset=					sqrt(3*pvc_05in_r_outer*pvc_05in_r_outer);



echo("muzzle_d_final_step" ,muzzle_r_final_step*2);
echo("pvc_05in_diameter_outer" , pvc_05in_diameter_outer);
echo("pvc_05in_315psi_diameter_inner" , pvc_05in_315psi_diameter_inner);
echo("pvc_05in_600psi_diameter_inner" , pvc_05in_600psi_diameter_inner);
echo("pvc_05in_offset" , pvc_05in_offset);
echo("sqrt 3 * r = " , sqrt(3) * pvc_05in_r_outer);


