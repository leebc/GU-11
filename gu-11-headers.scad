pod_r_outer = 			89.33 /2;
pod_r_wall_inner = 		76.5 /2;
pod_wall_thickness =		pod_r_outer - pod_r_wall_inner;

ammo_d	 =			13 ;
ammo_r	 =			ammo_d / 2 ;
ammo_chamber_inner_r =		pod_r_wall_inner - (2 * ammo_r ) ; 

muzzle_r_first_step =		pod_r_outer - 15 ;// WAS 44.66 /2 ;
muzzle_r_final_step =		35.72 /2 ;
muzzle_h_first_to_final =	48.34 ;

muzzle_r_inner =		pod_r_wall_inner -  15 ;  
		//  WAS	muzzle_r_final_step - pod_wall_thickness ;
muzzle_r_insert =		pod_r_wall_inner;
muzzle_h_insert =		20;

pvc_05in_diameter_outer=	21.35;
pvc_05in_600psi_diameter_inner=	15.35;
pvc_05in_315psi_diameter_inner=	18.24;
pvc_05in_hamper_diameter_inner=	18.5;

pvc_05in_r_outer=		pvc_05in_diameter_outer / 2 ;
pvc_05in_315psi_r_inner=	pvc_05in_315psi_diameter_inner / 2;
pvc_05in_600psi_r_inner=	pvc_05in_600psi_diameter_inner / 2;
pvc_05in_hamper_r_inner=	pvc_05in_hamper_diameter_inner / 2;

pvc_05in_offset=		sqrt(3*pvc_05in_r_outer*pvc_05in_r_outer);

// zero pane
module zero_pane() {
	color("lightblue")  cube([100,100,0.1], center=true);
}

echo("Loaded header definitions from <gu-11-headers.scad>...");
echo ();


