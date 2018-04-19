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
pad_rr = 30/2 + tol;
pad_hh = 3.4 - 1;

bar_w = pad_w + 2;
bar_y = 300;
bar_ey = (case_y/2 - (case_r + foot_ir + bar_w)) - bar_y/2;
bar_x = 150;
bar_ex = (case_x/2 - (case_r + foot_ir + bar_w)) - bar_x/2;
bar_tol = 0.4/2;
bar_h = 15;
ebar_h = bar_h + 2*bar_tol;


bolt_m3_hole_r = 3.2/2;
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
shelf_eh = 3;
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
        translate([pad_x+bolt_o,0,pad_h/2-foot_h1/2])
          rotate([-90,0,0]) {
            cylinder(r=bolt_m3_hole_r,h=pad_x,$fn=bolt_sm);
            translate([0,0,bolt_h])
              cylinder(r=bolt_m3_cap_r,h=pad_x,$fn=bolt_sm);
          }
        translate([0,pad_y+bolt_o,pad_h/2-foot_h1/2])
          rotate([0,90,0]) {
            cylinder(r=bolt_m3_hole_r,h=pad_x,$fn=bolt_sm);
            translate([0,0,bolt_h])
              cylinder(r=bolt_m3_cap_r,h=pad_x,$fn=bolt_sm);
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

module shelf_plate() {
  difference() {
    hull() {
      translate([-case_x/2+case_r,-case_y/2+case_r])
        circle(r=pad_r,h=case_h,$fn=case_sm);
      translate([ case_x/2-case_r,-case_y/2+case_r])
        circle(r=pad_r,h=case_h,$fn=case_sm);
      translate([-case_x/2+case_r, case_y/2-case_r])
        circle(r=pad_r,h=case_h,$fn=case_sm);
      translate([ case_x/2-case_r, case_y/2-case_r])
        circle(r=pad_r,h=case_h,$fn=case_sm);
    }
    hull() {
      translate([-case_x/2+case_r,-case_y/2+case_r])
        circle(r=shelf_R,h=case_h,$fn=case_sm);
      translate([-case_x/2+case_r,-case_y/2+case_r])
        rotate(45)
          translate([cos(45)*pad_x+pad_r,0,0])
            circle(r=shelf_R,h=case_h,$fn=case_sm);
    }
    hull() {
      translate([ case_x/2-case_r,-case_y/2+case_r])
        circle(r=shelf_R,h=case_h,$fn=case_sm);
      translate([ case_x/2-case_r,-case_y/2+case_r])
        rotate(90+45)
          translate([cos(45)*pad_x+pad_r,0,0])
            circle(r=shelf_R,h=case_h,$fn=case_sm);
    }
    hull() {
      translate([-case_x/2+case_r, case_y/2-case_r])
        circle(r=shelf_R,h=case_h,$fn=case_sm);
      translate([-case_x/2+case_r, case_y/2-case_r])
        rotate(-45)
          translate([cos(45)*pad_x+pad_r,0,0])
            circle(r=shelf_R,h=case_h,$fn=case_sm);
    }
    hull() {
      translate([ case_x/2-case_r, case_y/2-case_r])
        circle(r=shelf_R,h=case_h,$fn=case_sm);
      translate([ case_x/2-case_r, case_y/2-case_r])
        rotate(2*90+45)
          translate([cos(45)*pad_x+pad_r,0,0])
            circle(r=shelf_R,h=case_h,$fn=case_sm);
    }
  }
}

module shelf() {
  linear_extrude(shelf_h) shelf_plate();
}

module assembly() {
  /*
  bars();
  //color([0.5,0.5,0.0,0.2]) 
  // ebars(tol);
  case();
  color([0.5,0.3,0.3,0.9]) 
    pad_assembly(shelf=false);
  */
  rod_assembly();
  color([0.3,0.3,0.3,0.9]) 
    translate([0,0,insert_z-pad_h+shelf_h]) 
      insert_assembly();
  color([0.5,0.5,0.0,0.2]) 
    translate([0,0,case_zo+case_h+shelf_z]) 
      ebars(tol);
  color([0.5,0.3,0.3,0.9]) 
    translate([0,0,case_zo+case_h+shelf_z]) 
      pad_assembly(shelf=true);
  color([0.1,0.1,0.1,0.3])
    translate([0,0,case_zo+case_h+shelf_z+foot_h1+shelf_eh-tol])
      shelf();
}

assembly();
//bars();
//ebars();

//color([0.3,0.3,0.3,0.9]) translate([-case_x/2+case_r,-case_y/2+case_r,insert_z-pad_h+shelf_h]) insert();

// 3d printing
//color([0.5,0.3,0.3,0.7]) pad(shelf=false); // base
//translate([0,0,case_zo+case_h+shelf_z]) pad(shelf=true); // shelf support

// laser cutting (export as DXF, then import to inkscape and convert to PDF)
//shelf_plate();

echo("bars: ",bar_x," and ",bar_y);
echo("extended bars: ",bar_x+2*bar_ex," and ",bar_y+2*bar_ey);