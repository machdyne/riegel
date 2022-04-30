/*
 * Riegel Case
 * Copyright (c) 2022 Lone Dynamics Corporation. All rights reserved.
 *
 */

$fn = 100;

board_width = 40;
board_thickness = 1.5;
board_length = 90;
board_height = 20;
board_spacing = 2;

ldq_board();

translate([0,0,15])
	ldq_case_top();

translate([0,0,-15])
	ldq_case_bottom();

module ldq_board() {
	
	difference() {
		color([0,0.5,0])
			roundedcube(board_width,board_length,board_thickness,3);
		translate([5, 5, -1]) cylinder(d=3.2, h=10);
		translate([5, 85, -1]) cylinder(d=3.2, h=10);
		translate([35, 5, -1]) cylinder(d=3.2, h=10);
		translate([35, 85, -1]) cylinder(d=3.2, h=10);
	}	
	
}

module ldq_case_top() {
	
	difference() {
				
		color([0.5,0.5,0.5])
			roundedcube(board_width,board_length,15,3);
			
		translate([1.5,2,-2])
			roundedcube(board_width-3.5,board_length-4,4,3);

		translate([1.5,10,-2])
			roundedcube(board_width-8,board_length-20,15,3);

		translate([10,2,-2])
			roundedcube(board_width-20,board_length-4,15,5);
		
		// ISP header
		translate([16,66.5,2]) cube([12,6,20]);
		
		// VGA
		translate([30,26.2-(31/2),-2]) cube([30,31,12.5+2]);

		// PS2
		translate([30,55.6-(14.5/2),-2]) cube([30,14.5,13+2]);

		// USBC
		translate([30,74.45-(9.5/2),-2]) cube([30,9.5,3.5+1.75]);
		
		// SD
		translate([20-(15/2),70,-2]) cube([15,30,2+2]);

		// SD resistor cutouts
		translate([8,74,-2]) cube([15,10,2+2]);
		translate([17,74,-2]) cube([15,10,2+2]);

		// PMODA
		translate([20,-2,0]) cube([16,30,10],center=true);

		// PMODB
		translate([0,23.65,0]) cube([5,16,10], center=true);
		
		// bolt holes
		translate([5, 5, -21]) cylinder(d=3.5, h=40);
		translate([5, 85, -21]) cylinder(d=3.5, h=40);
		translate([35, 5, -20]) cylinder(d=3.5, h=40);
		translate([35, 85, -21]) cylinder(d=3.5, h=40);

		// flush mount bolt holes
		translate([5, 5, 14]) cylinder(d=5, h=4);
		translate([5, 85, 14]) cylinder(d=5, h=4);
		translate([35, 5, 14]) cylinder(d=5, h=4);
		translate([35, 85, 14]) cylinder(d=5, h=4);

		// riegel text
		rotate(270)
			translate([-35,18.5,14])
				linear_extrude(5)
					text("R I E G E L", size=6, halign="center",
						font="Ubuntu:style=Bold");

	}	
}

module ldq_case_bottom() {
	
	difference() {
		color([0.5,0.5,0.5])
			roundedcube(board_width,board_length,8.5,3);
		
		translate([2,10,2])
			roundedcube(board_width-4,board_length-20,8,3);
				
		translate([10,2.5,2])
			roundedcube(board_width-20,board_length-5,8,3);

		// bolt holes
		translate([5, 5, -11]) cylinder(d=3.2, h=25);
		translate([5, 85, -11]) cylinder(d=3.2, h=25);
		translate([35, 5, -11]) cylinder(d=3.2, h=25);
		translate([35, 85, -11]) cylinder(d=3.2, h=25);

		// nut holes
		translate([5, 5, -1.5]) cylinder(d=7, h=4.5, $fn=6);
		translate([5, 85, -1.5]) cylinder(d=7, h=4.5, $fn=6);
		translate([35, 5, -1.5]) cylinder(d=7, h=4.5, $fn=6);
		translate([35, 85, -1.5]) cylinder(d=7, h=4.5, $fn=6);

	}	
}

// https://gist.github.com/tinkerology/ae257c5340a33ee2f149ff3ae97d9826
module roundedcube(xx, yy, height, radius)
{
    translate([0,0,height/2])
    hull()
    {
        translate([radius,radius,0])
        cylinder(height,radius,radius,true);

        translate([xx-radius,radius,0])
        cylinder(height,radius,radius,true);

        translate([xx-radius,yy-radius,0])
        cylinder(height,radius,radius,true);

        translate([radius,yy-radius,0])
        cylinder(height,radius,radius,true);
    }
}
