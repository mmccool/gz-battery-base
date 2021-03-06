// Goal Zero Lithium 1400 Base
// Developed by: Michael McCool
// Copyright 2018 Michael McCpp;
// License: CC BY 3.0.  See LICENSE.md
include <tols.scad>
include <smooth_model.scad>
//include <smooth_make.scad>
include <bolt_params.scad>
use <bolts.scad>
use <bar.scad>

//tol = 0.05;
//eps = 0.0001;
//sm_base = 10;

foot_h = 5;
foot_h1 = 4;
foot_h2 = 4;
foot_r = 31.5/2;
foot_ir = 10/2; // M10 bolt hole
foot_b = 0.5; // bezel

case_x = 254;
case_y = 358;
case_r = 17;
case_h = 240;
case_fh = 5;
case_sm = 8*sm_base;
case_zo = foot_h;

pad_w = 4;
pad_h = 2*pad_w + 15 + foot_h1;
pad_x = 40;
pad_y = 40;
pad_r = case_r+2;
pad_rr = 30/2 + 0.5;
pad_hh = 3.4 - 1;
pad_xo = -5;
pad_yo = -5;
pad_xo2 = -19;
pad_yo2 = -19;
pad_xd = pad_xo2 - pad_xo;
pad_yd = pad_yo2 - pad_yo;

bar_w = pad_w + 2;
bar_y = 300;
bar_ey = (case_y/2 - (case_r + foot_ir + bar_w)) - bar_y/2;
bar_x = 150;
bar_ex = (case_x/2 - (case_r + foot_ir + bar_w)) - bar_x/2;
bar_tol = 0.4/2;
bar_h = 15;
ebar_h = bar_h + 2*bar_tol;

bolt_m3_hole_r = 3.2/2;
bolt_m3_chole_r = 2.9/2;
bolt_m3_cap_r = 6.2/2 + tol;
bolt_m3_nut_r = 6.2/(cos(30)*2) + tol;
bolt_h = 8;
bolt_h2 = 6;
bolt_o = 5;
bolt_q = 5.5;
bolt_sm = 20;

washer_r = 11;
washer_h = 1.5;

nut_r = 20/2;
nut_h = 8;

rod_r = 13/2;
rod_z = 300;
rod_sm = 4*sm_base;

shelf_z = rod_z - 15;
shelf_h = 5;

insert_r1 = 17.9/2;
insert_r2 = 16.6/2;
insert_h = 31.34;
insert_z = shelf_z - foot_h;
insert_sm = 4*sm_base;
insert_tol = 0.1;
insert_R1 = insert_r1 + insert_tol;
insert_R2 = insert_r2 + insert_tol;

shelf_R = 22/2;
shelf_R_tol = 0.1;
shelf_eh = 0;
shelf_H = shelf_h + shelf_eh;
shelf_sm = 4*sm_base;

module foot() {
  difference() {
    cylinder(r=foot_r,h=foot_h,$fn=case_sm);
    translate([0,0,-foot_h/2])
      cylinder(r=foot_ir,h=2*foot_h,$fn=case_sm);
  }
}

module feet() {
  translate([-case_x/2+case_r,-case_y/2+case_r,0]) foot();
  translate([ case_x/2-case_r,-case_y/2+case_r,0]) foot();
  translate([-case_x/2+case_r, case_y/2-case_r,0]) foot();
  translate([ case_x/2-case_r, case_y/2-case_r,0]) foot();
}
module body() {
  hull() {
    translate([-case_x/2+case_r,-case_y/2+case_r,case_zo])
      cylinder(r=case_r,h=case_h,$fn=case_sm);
    translate([ case_x/2-case_r,-case_y/2+case_r,case_zo])
      cylinder(r=case_r,h=case_h,$fn=case_sm);
    translate([-case_x/2+case_r, case_y/2-case_r,case_zo])
      cylinder(r=case_r,h=case_h,$fn=case_sm);
    translate([ case_x/2-case_r, case_y/2-case_r,case_zo])
      cylinder(r=case_r,h=case_h,$fn=case_sm);
  }
}
module case() {
  color([0.5,0.5,0.5,1.0]) body();
  color([0.4,0.8,0.3,1.0]) feet();
}
module bars() {
  color([0.2,0.2,0.7,1.0]) {
    translate([-bar_x/2,-case_y/2+bar_h/2+pad_w,-pad_w])
      bar(bar_x);
    translate([-bar_x/2, case_y/2-bar_h/2-pad_w,-pad_w])
      bar(bar_x);
    translate([-case_x/2+bar_h/2+pad_w, -bar_y/2,-pad_w])
      rotate(90) 
        bar(bar_y);
    translate([ case_x/2-bar_h/2-pad_w, -bar_y/2,-pad_w])
      rotate(90) 
        bar(bar_y);
  }
}
se = (1-tol);
module ebars(t=0) {
  translate([-bar_x/2-bar_ex,-case_y/2+bar_h/2+pad_w,-pad_w]) 
    translate([-t,-ebar_h/2-t,-ebar_h+bar_tol-t])
      cube([bar_x+2*bar_ex+2+2*t,ebar_h+2*t,ebar_h+2*t]);
  translate([-bar_x/2-bar_ex, case_y/2-bar_h/2-pad_w,-pad_w])
    translate([-t,-ebar_h/2-t,-ebar_h+bar_tol-t])
      cube([bar_x+2*bar_ex+2*t,ebar_h+2*t,ebar_h+2*t]);
  translate([-case_x/2+bar_h/2+pad_w, -bar_y/2-bar_ey,-pad_w])
    rotate(90) 
      translate([-t,-ebar_h/2-t,-ebar_h+bar_tol-t])
        cube([bar_y + 2*bar_ey+2*t,ebar_h+2*t,ebar_h+2*t]);
  translate([ case_x/2-bar_h/2-pad_w, -bar_y/2-bar_ey,-pad_w])
    rotate(90) 
      translate([-t,-ebar_h/2-t,-ebar_h+bar_tol-t])
        cube([bar_y + 2*bar_ey+2*t,ebar_h+2*t,ebar_h+2*t]);
}
ruler_x = 217;
ruler_y = 114;
module ruler(t=0) {
  translate([-ruler_y/2,-case_y/2+bar_h/2+pad_w-bar_h,-pad_w]) 
    translate([-t,-ebar_h/2-t,-ebar_h+bar_tol-t])
      cube([ruler_y,ebar_h+2*t,ebar_h+2*t]);
  translate([-ruler_y/2, case_y/2-bar_h/2-pad_w+bar_h,-pad_w])
    translate([-t,-ebar_h/2-t,-ebar_h+bar_tol-t])
      cube([ruler_y,,ebar_h+2*t,ebar_h+2*t]);
  translate([-case_x/2+bar_h/2+pad_w-bar_h, -bar_y/2-bar_ey,-pad_w])
    rotate(90) 
      translate([-t,-ebar_h/2-t,-ebar_h+bar_tol-t])
        cube([bar_y + 2*bar_ey+2*t,ebar_h+2*t,ebar_h+2*t]);
  translate([ case_x/2-bar_h/2-pad_w+bar_h, -bar_y/2-bar_ey,-pad_w])
    rotate(90) 
      translate([-t,-ebar_h/2-t,-ebar_h+bar_tol-t])
        cube([bar_y + 2*bar_ey+2*t,ebar_h+2*t,ebar_h+2*t]);
}
bolt_cap_h = 0;
module pad(shelf=false) {
  difference() {
    translate([-case_x/2+case_r,-case_y/2+case_r,-pad_h+foot_h1]) {
      difference() {
        union() {
          hull() {
            translate([0,0,-foot_h2]) {
              translate([0,0,pad_h+foot_h2-foot_b-eps])
                cylinder(r=pad_r-foot_b,h=foot_b+eps,$fn=case_sm);
              translate([0,0,foot_b])
                cylinder(r=pad_r,h=pad_h+foot_h2-2*foot_b,$fn=case_sm);
              translate([0,0,0])
                cylinder(r=pad_r-foot_b,h=foot_b+eps,$fn=case_sm);
            }
            translate([pad_x,0,-foot_h2]) {
              translate([0,0,pad_h+foot_h2-foot_b-eps])
                cylinder(r=pad_r-foot_b,h=foot_b+eps,$fn=case_sm);
              translate([0,0,foot_b])
                cylinder(r=pad_r,h=pad_h+foot_h2-2*foot_b,$fn=case_sm);
              translate([0,0,0])
                cylinder(r=pad_r-foot_b,h=foot_b+eps,$fn=case_sm);
            }
            translate([0,pad_y,-foot_h2]) {
              translate([0,0,pad_h+foot_h2-foot_b-eps])
                cylinder(r=pad_r-foot_b,h=foot_b+eps,$fn=case_sm);
              translate([0,0,foot_b])
                cylinder(r=pad_r,h=pad_h+foot_h2-2*foot_b,$fn=case_sm);
              translate([0,0,0])
                cylinder(r=pad_r-foot_b,h=foot_b+eps,$fn=case_sm);
            }
          }
          // shelf cutout key
          if (shelf && shelf_H > 0) {
             hull() {
               cylinder(r=shelf_R,h=pad_h+shelf_H,$fn=shelf_sm);
               rotate(45)
                 translate([-tol+cos(45)*pad_x+pad_r,
                            -shelf_R,
                            pad_h-tol-foot_b])
                   cube([tol,2*shelf_R,shelf_H+foot_b+tol]);
             }
          }
        }
        if (shelf) {
          // insert hole
          translate([0,0,insert_h-tol])
            cylinder(r=insert_R2,h=insert_h,$fn=insert_sm);
          translate([0,0,0])
            cylinder(r1=insert_R1,r2=insert_R2,h=insert_h,$fn=insert_sm);
          translate([0,0,-insert_h+tol])
            cylinder(r=insert_R1,h=insert_h,$fn=insert_sm);
        } else {
          // caster mount, shaft hole
          translate([0,0,-pad_h/2])
            cylinder(r=foot_ir,h=2*pad_h,$fn=case_sm);
          // caster mount, case foot recess
          translate([0,0,pad_h-foot_h])
            cylinder(r=foot_r+tol,h=2*foot_h,$fn=case_sm);
          // caster mount, washer recess
          translate([0,0,-washer_h-foot_h2])
            cylinder(r=washer_r+tol,h=2*washer_h,$fn=case_sm);
          // caster mount, M10 nut recess
          translate([0,0,pad_h-foot_h-nut_h])
            rotate(-15) // prints better if laid on hypoteneuse
              cylinder(r=nut_r+tol,h=2*nut_h,$fn=6);
        }
        // M3 retaining bolts for extrusions (back)
        translate([pad_x+bolt_o+pad_xo,0,pad_h/2-foot_h1/2])
          rotate([-90,0,0]) {
            cylinder(r=bolt_m3_hole_r,h=pad_x,$fn=bolt_sm);
            translate([0,0,bolt_h])
              cylinder(r=bolt_m3_nut_r,h=pad_x,$fn=6);
          }
        translate([0,pad_y+bolt_o+pad_yo,pad_h/2-foot_h1/2])
          rotate([0,90,0]) {
            cylinder(r=bolt_m3_hole_r,h=pad_x,$fn=bolt_sm);
            translate([0,0,bolt_h])
              rotate(30) cylinder(r=bolt_m3_nut_r,h=pad_x,$fn=6);
          }
        translate([pad_x+bolt_o+pad_xo2,0,pad_h/2-foot_h1/2])
          rotate([-90,0,0]) {
            cylinder(r=bolt_m3_hole_r,h=pad_x,$fn=bolt_sm);
            translate([0,0,bolt_h])
              cylinder(r=bolt_m3_nut_r,h=pad_x,$fn=6);
          }
        translate([0,pad_y+bolt_o+pad_yo2,pad_h/2-foot_h1/2])
          rotate([0,90,0]) {
            cylinder(r=bolt_m3_hole_r,h=pad_x,$fn=bolt_sm);
            translate([0,0,bolt_h])
              rotate(30) cylinder(r=bolt_m3_nut_r,h=pad_x,$fn=6);
          }
        // M3 retaining bolts for extrusions (front)
        translate([pad_x+bolt_o+pad_xo,-pad_x,pad_h/2-foot_h1/2])
          rotate([-90,0,0]) {
            cylinder(r=bolt_m3_hole_r,h=pad_x,$fn=bolt_sm);
          }
        translate([-pad_x,pad_y+bolt_o+pad_yo,pad_h/2-foot_h1/2])
          rotate([0,90,0]) {
            cylinder(r=bolt_m3_hole_r,h=pad_x,$fn=bolt_sm);
          }
        translate([pad_x+bolt_o+pad_xo2,-pad_x,pad_h/2-foot_h1/2])
          rotate([-90,0,0]) {
            cylinder(r=bolt_m3_hole_r,h=pad_x,$fn=bolt_sm);
          }
        translate([-pad_x,pad_y+bolt_o+pad_yo2,pad_h/2-foot_h1/2])
          rotate([0,90,0]) {
            cylinder(r=bolt_m3_hole_r,h=pad_x,$fn=bolt_sm);
          }
        // M3 retaining bolts for extrusions (top)
        translate([pad_x+bolt_o,-bolt_q,pad_h/2+foot_h1/2])
          rotate([0,0,0]) {
            cylinder(r=bolt_m3_hole_r,h=pad_x,$fn=bolt_sm);
            translate([0,0,bolt_h2])
              rotate(-15)
                cylinder(r=bolt_m3_nut_r,h=pad_x,$fn=6);
          }
        translate([-bolt_q,pad_y+bolt_o,pad_h/2+foot_h1/2])
          rotate([0,0,0]) {
            cylinder(r=bolt_m3_hole_r,h=pad_x,$fn=bolt_sm);
            translate([0,0,bolt_h2])
              rotate(-15)
                cylinder(r=bolt_m3_nut_r,h=pad_x,$fn=6);
          }
        translate([pad_x+bolt_o+pad_xd,-bolt_q,pad_h/2+foot_h1/2])
          rotate([0,0,0]) {
            cylinder(r=bolt_m3_hole_r,h=pad_x,$fn=bolt_sm);
            translate([0,0,bolt_h2])
              rotate(-15)
                cylinder(r=bolt_m3_nut_r,h=pad_x,$fn=6);
          }
        translate([-bolt_q,pad_y+bolt_o+pad_yd,pad_h/2+foot_h1/2])
          rotate([0,0,0]) {
            cylinder(r=bolt_m3_hole_r,h=pad_x,$fn=bolt_sm);
            translate([0,0,bolt_h2])
              rotate(-15)
                cylinder(r=bolt_m3_nut_r,h=pad_x,$fn=6);
          }
        // M3 retaining bolts for extrusions (bottom)
        translate([pad_x+bolt_o,-bolt_q,pad_h/2-foot_h1-4])
          rotate([180,0,0]) {
            cylinder(r=bolt_m3_hole_r,h=pad_x,$fn=bolt_sm);
            translate([0,0,bolt_h2])
              cylinder(r=bolt_m3_cap_r,h=pad_x,$fn=bolt_sm);
          }
        translate([-bolt_q,pad_y+bolt_o,pad_h/2-foot_h1-4])
          rotate([180,0,0]) {
            cylinder(r=bolt_m3_hole_r,h=pad_x,$fn=bolt_sm);
            translate([0,0,bolt_h2])
              cylinder(r=bolt_m3_cap_r,h=pad_x,$fn=bolt_sm);
          }
        translate([pad_x+bolt_o+pad_xd,-bolt_q,pad_h/2-foot_h1-4])
          rotate([180,0,0]) {
            cylinder(r=bolt_m3_hole_r,h=pad_x,$fn=bolt_sm);
            translate([0,0,bolt_h2])
              cylinder(r=bolt_m3_cap_r,h=pad_x,$fn=bolt_sm);
          }
        translate([-bolt_q,pad_y+bolt_o+pad_yd,pad_h/2-foot_h1-4])
          rotate([180,0,0]) {
            cylinder(r=bolt_m3_hole_r,h=pad_x,$fn=bolt_sm);
            translate([0,0,bolt_h2])
              cylinder(r=bolt_m3_cap_r,h=pad_x,$fn=bolt_sm);
          }
        // HW mounting holes
        translate([pad_x+bolt_o,-bolt_q+bar_h,pad_h/2-foot_h1-4])
          rotate([180,0,0]) {
            cylinder(r=bolt_m3_chole_r,h=pad_x,$fn=bolt_sm);
          }
        translate([-bolt_q+bar_h,pad_y+bolt_o,pad_h/2-foot_h1-4])
          rotate([180,0,0]) {
            cylinder(r=bolt_m3_chole_r,h=pad_x,$fn=bolt_sm);
          }
        translate([pad_x+bolt_o+pad_xd,-bolt_q+bar_h,pad_h/2-foot_h1-4])
          rotate([180,0,0]) {
            cylinder(r=bolt_m3_chole_r,h=pad_x,$fn=bolt_sm);
          }
        translate([-bolt_q+bar_h,pad_y+bolt_o+pad_yd,pad_h/2-foot_h1-4])
          rotate([180,0,0]) {
            cylinder(r=bolt_m3_chole_r,h=pad_x,$fn=bolt_sm);
          }
        translate([pad_x+bolt_o+pad_xo-5,0,pad_h/2-foot_h1/2])
          rotate([0,0,-45]) rotate([-90,0,0]) {
            translate([0,0,15]) cylinder(r=bolt_m3_chole_r,h=pad_x,$fn=bolt_sm);
          }
        translate([pad_x+bolt_o+pad_xo-5,0,pad_h/2-foot_h1/2])
          rotate([0,0,-45]) rotate([-90,0,0]) {
            translate([0,0,15]) cylinder(r=bolt_m3_chole_r,h=pad_x,$fn=bolt_sm);
          }
        translate([0,pad_y+bolt_o+pad_yo-5,pad_h/2-foot_h1/2])
          rotate([0,0,45]) rotate([0,90,0]) {
            translate([0,0,15]) cylinder(r=bolt_m3_chole_r,h=pad_x,$fn=bolt_sm);
          }
        // indent for cushions
        translate([pad_x,0,pad_h-pad_hh])
          cylinder(r=pad_rr,h=pad_h+foot_h2,$fn=case_sm);
        translate([0,pad_y,pad_h-pad_hh])
          cylinder(r=pad_rr,h=pad_h+foot_h2,$fn=case_sm);
      }
    }
    ebars();
  }
}

module pad_assembly(shelf=false) {
  pad(shelf=shelf);
  translate([-case_x/2+case_r,case_y/2-case_r,0])
    rotate(-90) 
      translate([case_x/2-case_r,case_y/2-case_r,0])
        pad(shelf=shelf);
  translate([case_x/2-case_r,-case_y/2+case_r,0])
    rotate(90) 
      translate([case_x/2-case_r,case_y/2-case_r,0])
        pad(shelf=shelf);
  translate([case_x/2-case_r,case_y/2-case_r,0])
    rotate(180) 
      translate([case_x/2-case_r,case_y/2-case_r,0])
        pad(shelf=shelf);
}

module rod() {
  translate([0,0,case_zo+case_h])
    cylinder(r=rod_r,h=rod_z,$fn=rod_sm);
}
module rod_assembly() {
  translate([-case_x/2+case_r,-case_y/2+case_r,0]) rod();
  translate([ case_x/2-case_r,-case_y/2+case_r,0]) rod();
  translate([-case_x/2+case_r, case_y/2-case_r,0]) rod();
  translate([ case_x/2-case_r, case_y/2-case_r,0]) rod();
}

module insert() {
  translate([0,0,case_zo+case_h])
    difference() {
      cylinder(r1=insert_r1,r2=insert_r2,h=insert_h,$fn=insert_sm);
      translate([0,0,-1])
        cylinder(r=rod_r+tol,h=insert_h+2,$fn=rod_sm);
    }
}
module insert_assembly() {
  translate([-case_x/2+case_r,-case_y/2+case_r,0]) insert();
  translate([ case_x/2-case_r,-case_y/2+case_r,0]) insert();
  translate([-case_x/2+case_r, case_y/2-case_r,0]) insert();
  translate([ case_x/2-case_r, case_y/2-case_r,0]) insert();
}

module base_plate() {
  hull() {
    translate([-case_x/2+case_r,-case_y/2+case_r])
      circle(r=pad_r,$fn=case_sm);
    translate([ case_x/2-case_r,-case_y/2+case_r])
      circle(r=pad_r,$fn=case_sm);
    translate([-case_x/2+case_r, case_y/2-case_r])
      circle(r=pad_r,$fn=case_sm);
    translate([ case_x/2-case_r, case_y/2-case_r])
      circle(r=pad_r,$fn=case_sm);
  }
}

ds_c = 0*bar_h/2;
ds_e = 4;
ds_x = case_x - case_r - bar_h/2 + ds_c;
ds_y = case_y - case_r - bar_h/2 + ds_c;
ds_r = 5;
ds_h1 = 1;
ds_h2 = 2;
ds_ex = (case_x - ruler_y)/2;
ds_ey = (case_y - ruler_x)/2;

ds_xx = 167 + 2;
ds_yy = 208 + 2;
ds_rr = 3;

module ds_plate() {
  hull() {
    translate([-ds_x/2+ds_r+ds_ex+ds_e,-ds_y/2+ds_r])
      circle(r=ds_r,$fn=case_sm);
    translate([-ds_x/2+ds_r,-ds_y/2+ds_r+ds_ey+ds_e])
      circle(r=ds_r,$fn=case_sm);
      
    translate([ ds_x/2-ds_r-ds_ex-ds_e,-ds_y/2+ds_r])
      circle(r=ds_r,$fn=case_sm);
    translate([ ds_x/2-ds_r,-ds_y/2+ds_r+ds_ey+ds_e])
      circle(r=ds_r,$fn=case_sm);
      
    translate([-ds_x/2+ds_r+ds_ex+ds_e, ds_y/2-ds_r])
      circle(r=ds_r,$fn=case_sm);
    translate([-ds_x/2+ds_r, ds_y/2-ds_r-ds_ey-ds_e])
      circle(r=ds_r,$fn=case_sm);
      
    translate([ ds_x/2-ds_r-ds_ex-ds_e, ds_y/2-ds_r])
      circle(r=ds_r,$fn=case_sm);
    translate([ ds_x/2-ds_r, ds_y/2-ds_r-ds_ey-ds_e])
      circle(r=ds_r,$fn=case_sm);
  }
}
module ds_shelf(h=ds_h2) {
    linear_extrude(h) ds_plate();
}
module display_plate_1() {
    difference() {
        ds_plate();
        translate([-ds_xx/2,-ds_yy/2]) square([ds_xx,ds_yy]);
        translate([-ds_xx/2,-ds_yy/2]) circle(r=ds_rr,$fn=5*sm_base);
        translate([ ds_xx/2,-ds_yy/2]) circle(r=ds_rr,$fn=5*sm_base);
        translate([-ds_xx/2, ds_yy/2]) circle(r=ds_rr,$fn=5*sm_base);
        translate([ ds_xx/2, ds_yy/2]) circle(r=ds_rr,$fn=5*sm_base);
    }
}
module display_shelf_1(h=ds_h1) {
    linear_extrude(h) display_plate_1();
}

module shelf_plate() {
  difference() {
    base_plate();
    // insert slot
    hull() {
      translate([-case_x/2+case_r,-case_y/2+case_r])
        circle(r=shelf_R+shelf_R_tol,$fn=case_sm);
      translate([-case_x/2+case_r,-case_y/2+case_r])
        rotate(45)
          translate([cos(45)*pad_x+pad_r,0,0])
            circle(r=shelf_R+shelf_R_tol,$fn=case_sm);
    }
    hull() {
      translate([ case_x/2-case_r,-case_y/2+case_r])
        circle(r=shelf_R+shelf_R_tol,$fn=case_sm);
      translate([ case_x/2-case_r,-case_y/2+case_r])
        rotate(90+45)
          translate([cos(45)*pad_x+pad_r,0,0])
            circle(r=shelf_R+shelf_R_tol,$fn=case_sm);
    }
    hull() {
      translate([-case_x/2+case_r, case_y/2-case_r])
        circle(r=shelf_R+shelf_R_tol,$fn=case_sm);
      translate([-case_x/2+case_r, case_y/2-case_r])
        rotate(-45)
          translate([cos(45)*pad_x+pad_r,0,0])
            circle(r=shelf_R+shelf_R_tol,$fn=case_sm);
    }
    hull() {
      translate([ case_x/2-case_r, case_y/2-case_r])
        circle(r=shelf_R+shelf_R_tol,$fn=case_sm);
      translate([ case_x/2-case_r, case_y/2-case_r])
        rotate(2*90+45)
          translate([cos(45)*pad_x+pad_r,0,0])
            circle(r=shelf_R+shelf_R_tol,$fn=case_sm);
    }
  }
}

module shelf() {
  linear_extrude(shelf_h) shelf_plate();
}

module bot_bolt_holes() {
  translate([pad_x+bolt_o,-bolt_q+bar_h])
    circle(r=bolt_m3_hole_r+tol,$fn=bolt_sm);
  translate([-bolt_q+bar_h,pad_y+bolt_o])
    circle(r=bolt_m3_hole_r+tol,$fn=bolt_sm);
  translate([pad_x+bolt_o+pad_xd,-bolt_q+bar_h])
    circle(r=bolt_m3_hole_r+tol,$fn=bolt_sm);
  translate([-bolt_q+bar_h,pad_y+bolt_o+pad_yd])
    circle(r=bolt_m3_hole_r+tol,$fn=bolt_sm);
  
  translate([pad_x+bolt_o,-bolt_q])
    circle(r=bolt_m3_hole_r+tol,$fn=bolt_sm);
  translate([-bolt_q,pad_y+bolt_o])
    circle(r=bolt_m3_hole_r+tol,$fn=bolt_sm);
  translate([pad_x+bolt_o+pad_xd,-bolt_q])
    circle(r=bolt_m3_hole_r+tol,$fn=bolt_sm);
  translate([-bolt_q,pad_y+bolt_o+pad_yd])
    circle(r=bolt_m3_hole_r+tol,$fn=bolt_sm);
}

module bot_shelf_plate() {
  difference() {
    base_plate();
    // wiring and rod holes
    {
      translate([-case_x/2+case_r,-case_y/2+case_r])
        circle(r=shelf_R+shelf_R_tol,$fn=case_sm);
      translate([-case_x/2+case_r,-case_y/2+case_r])
        rotate(45)
          translate([cos(45)*pad_x+pad_r,0,0])
            circle(r=shelf_R+shelf_R_tol,$fn=case_sm);
    }
    {
      translate([ case_x/2-case_r,-case_y/2+case_r])
        circle(r=shelf_R+shelf_R_tol,$fn=case_sm);
      translate([ case_x/2-case_r,-case_y/2+case_r])
        rotate(90+45)
          translate([cos(45)*pad_x+pad_r,0,0])
            circle(r=shelf_R+shelf_R_tol,$fn=case_sm);
    }
    {
      translate([-case_x/2+case_r, case_y/2-case_r])
        circle(r=shelf_R+shelf_R_tol,$fn=case_sm);
      translate([-case_x/2+case_r, case_y/2-case_r])
        rotate(-45)
          translate([cos(45)*pad_x+pad_r,0,0])
            circle(r=shelf_R+shelf_R_tol,$fn=case_sm);
    }
    {
      translate([ case_x/2-case_r, case_y/2-case_r])
        circle(r=shelf_R+shelf_R_tol,$fn=case_sm);
      translate([ case_x/2-case_r, case_y/2-case_r])
        rotate(2*90+45)
          translate([cos(45)*pad_x+pad_r,0,0])
            circle(r=shelf_R+shelf_R_tol,$fn=case_sm);
    }
    // bolt holes
    translate([-case_x/2+case_r,-case_y/2+case_r]) 
      bot_bolt_holes();
    translate([-case_x/2+case_r,case_y/2-case_r])
      rotate(-90) bot_bolt_holes();
    translate([case_x/2-case_r,-case_y/2+case_r,0])
      rotate(90) bot_bolt_holes(); 
    translate([case_x/2-case_r,case_y/2-case_r,0])
      rotate(180) bot_bolt_holes(); 
  }
}
 
module bot_shelf() {
  linear_extrude(shelf_h) bot_shelf_plate();
}

module assembly() {
    /*
  //color([0.1,0.1,0.1,1.0]) bars();
  color([0.1,0.1,0.1,0.8]) 
    ebars(tol);
  color([0.3,0.3,0.4,1.0])
    case();
  color([0.3,0.3,0.3,0.9]) 
    pad_assembly(shelf=false);
  //color([0.1,0.1,0.1,0.3])
  //  translate([0,0,-shelf_h-pad_h-tol])
  //    bot_shelf();
  
  color([0.9,0.9,0.9,0.9]) 
    rod_assembly();
  color([0.3,0.3,0.3,0.9]) 
    translate([0,0,insert_z-pad_h+shelf_h]) 
      insert_assembly();
    */
  color([0.0,1.0,0.0,1.0]) 
    translate([0,0,case_zo+case_h+shelf_z]) 
      ebars(tol);
      /*
  color([1.0,0.0,0.0,1.0]) 
    translate([0,0,case_zo+case_h+shelf_z]) 
      ruler();
      */
  color([0.3,0.3,0.3,1.0]) 
    translate([0,0,case_zo+case_h+shelf_z]) 
      pad_assembly(shelf=true);
  color([0.1,0.1,0.1,0.3])
    translate([0,0,case_zo+case_h+shelf_z+foot_h1+shelf_eh-tol])
      display_shelf_1();
      /*
  color([0.1,0.1,0.1,0.3])
    translate([0,0,case_zo+case_h+shelf_z+foot_h1+shelf_eh-tol])
      shelf();
  color([0.1,0.1,0.1,0.3])
    translate([0,0,case_zo+case_h+shelf_z-shelf_h-pad_h-tol])
      bot_shelf();
      */
}

//assembly();
//bars();
//ebars();

//color([0.3,0.3,0.3,0.9]) translate([-case_x/2+case_r,-case_y/2+case_r,insert_z-pad_h+shelf_h]) insert();

// 3d printing
//color([0.5,0.3,0.3,0.7]) pad(shelf=false); // base
//translate([0,0,case_zo+case_h+shelf_z]) pad(shelf=true); // shelf support

// laser cutting (export as DXF, then import to inkscape and convert to PDF)
//shelf_plate();
//bot_shelf_plate();
display_plate_1();

echo("bars: ",bar_x," and ",bar_y);
echo("extended bars: ",bar_x+2*bar_ex," and ",bar_y+2*bar_ey);