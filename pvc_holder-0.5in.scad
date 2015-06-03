include<gu-11-headers.scad>;

FN=30;
FN_pod=60;

// pod_r_outer = 					89.33 /2;
// pod_r_wall_inner = 			76.5 /2;
// pod_wall_thickness =		pod_r_outer - pod_r_wall_inner;
 
muzzle_r_first_step =		44.66 /2 ;
muzzle_r_final_step =		35.72 /2 ;
muzzle_h_first_to_final =	48.34 ;

// muzzle_r_inner =			muzzle_r_final_step - pod_wall_thickness ;

// muzzle_r_insert =			pod_r_wall_inner;
// muzzle_h_insert =			5;

pvc_05in_diameter_outer=			21.35;
pvc_05in_315psi_diameter_inner=	18.24;
pvc_05in_600psi_diameter_inner=	15.35;

pvc_05in_r_outer=					pvc_05in_diameter_outer / 2 ;
pvc_05in_315psi_r_inner=			pvc_05in_315psi_diameter_inner / 2;
pvc_05in_600psi_r_inner=			pvc_05in_600psi_diameter_inner / 2;
pvc_05in_offset=					sqrt(3*pvc_05in_r_outer*pvc_05in_r_outer);

echo("This block of ECHOs from muzzel.scad");
echo("pod_r_outer ", pod_r_outer);
echo("pod_r_wall_inner ", pod_r_wall_inner);
echo("pod_wall_thickness ", pod_wall_thickness);
echo("muzzle_r_inner ", muzzle_r_inner);
echo("muzzle_r_insert ",muzzle_r_insert);
echo("muzzle_h_insert ",muzzle_h_insert);
echo("ammo_d ", ammo_d	 );
echo("ammo_r ", ammo_r	);
echo("ammo_chamber_inner_r ", ammo_chamber_inner_r);

echo("This block of ECHOs from pvc_hoder-0.5in.scad");
echo("muzzle_d_final_step" ,muzzle_r_final_step*2);
echo("pvc_05in_diameter_outer" , pvc_05in_diameter_outer);
echo("pvc_05in_315psi_diameter_inner" , pvc_05in_315psi_diameter_inner);
echo("pvc_05in_600psi_diameter_inner" , pvc_05in_600psi_diameter_inner);
echo("pvc_05in_offset" , pvc_05in_offset);
echo("sqrt 3 * r = " , sqrt(3) * pvc_05in_r_outer);


// Let's do some more math...
spec_width			=12.0    ;       // meters
scaled_width			=spec_width*scale;       // mm
measured_scale		=scaled_width/294;
engine_c_measured	=135*measured_scale;
engine_a_calculated=engine_c_measured/2;
engine_b_calculated=sqrt(
								engine_c_measured*engine_c_measured  -  
								engine_a_calculated*engine_a_calculated);
// echo("engine_c_measured/2", engine_c_measured/2);
// echo("engine_a_calculated", engine_a_calculated);
// echo("engine_b_calculated", engine_b_calculated);

engine12_y_offset=engine_a_calculated;
engine12_z_offset=engine_b_calculated/-3;
engine3_z_offset=engine_b_calculated*2/3;
e_shift=9/12;


// zero pane
*color("lightblue")  cube([100,100,0.1], center=true);

// Center pin
*color("red")	cylinder(r=1, h= 2* muzzle_h_insert);

*color("lightgrey")      // Very tip of muzzle
	translate([0,0,muzzle_h_insert+muzzle_r_first_step])
		cylinder(r1=muzzle_r_first_step, r2=muzzle_r_final_step, 
					h=muzzle_h_first_to_final,
					center=false, $fn=FN_pod);

projection(cut=false)
{	//  MAKE IT Flat!

//color("blue")
	difference(){
//		union(){
			color("blue")
				translate([0,0,muzzle_h_insert/2])
					cylinder(r=pod_r_wall_inner, //muzzle_r_first_step, 
								h=muzzle_h_insert,
								center=true, $fn=FN_pod);
		union() color("red") {
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

			// Thin circle that cuts out `bearing ring`
			translate([0,0,muzzle_h_insert/2])
			difference()
			{
				cylinder(r=ammo_chamber_inner_r, 
							h=muzzle_h_insert+2,
							center=true, $fn=FN_pod);
				cylinder(r=ammo_chamber_inner_r - 0.1, 
							h=muzzle_h_insert+2,
							center=true, $fn=FN_pod);
			}

		}	// End union of differences
}	// End difference

} //end projection