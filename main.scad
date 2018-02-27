// Goal Zero Lithium 1400 Base
// Developed by: Michael McCool
// Copyright 2018 Michael McCpp;
// License: CC BY 3.0.  See LICENSE.md
include <tols.scad>
include <smooth_model.scad>
//include <smooth_make.scad>
include <bolt_params.scad>
use <bolts.scad>
use <beam.scad>

foot_h = 5;
foot_h1 = 4;
foot_h2 = 4;
foot_r = 31.3/2;
foot_ir = 8/2;

case_x = 254;
case_y = 358;
case_r = 17;
case_h = 240;
case_fh = 5;
case_sm = 50;
case_zo = foot_h;

pad_w = 4;
pad_h = 2*pad_w + 15 + foot_h1;
pad_x = 40;
pad_y = 40;
pad_r = case_r+2;

bar_y = 300;
bar_ey = (case_y/2 - (case_r + foot_ir + pad_w)) - bar_y/2;
bar_x = 150;
bar_ex = (case_x/2 - (case_r + foot_ir + pad_w)) - bar_x/2;
bar_h = 15;

washer_r = 11;
washer_h = 1.5;

nut_r = 20/2;
nut_h = 8;

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
module ebars() {
  translate([-bar_x/2-bar_ex,-case_y/2+bar_h/2+pad_w,-pad_w]) 
    translate([0,-15/2,-15])
      cube([bar_x+2*bar_ex,15,15]);
  translate([-bar_x/2-bar_ex, case_y/2-bar_h/2-pad_w,-pad_w])
    translate([0,-15/2,-15])
      cube([bar_x+2*bar_ex,15,15]);
  translate([-case_x/2+bar_h/2+pad_w, -bar_y/2-bar_ey,-pad_w])
    rotate(90) 
      translate([0,-15/2,-15])
        cube([bar_y + 2*bar_ey,15,15]);
  translate([ case_x/2-bar_h/2-pad_w, -bar_y/2-bar_ey,-pad_w])
    rotate(90) 
      translate([0,-15/2,-15])
        cube([bar_y + 2*bar_ey,15,15]);
}
bolt_m3_hole_r = 3.2/2;
bolt_m3_cap_r = 6/2;
bolt_h = 4;
bolt_o = 5;
bolt_sm = 20;
module pad() {
  difference() {
    translate([-case_x/2+case_r,-case_y/2+case_r,-pad_h+foot_h1]) {
      difference() {
        hull() {
          translate([0,0,-foot_h2])
            cylinder(r=pad_r,h=pad_h+foot_h2,$fn=case_sm);
          translate([pad_x,0,-foot_h2])
            cylinder(r=pad_r,h=pad_h+foot_h2,$fn=case_sm);
          translate([0,pad_y,-foot_h2])
            cylinder(r=pad_r,h=pad_h+foot_h2,$fn=case_sm);
        }
        translate([0,0,-pad_h/2])
          cylinder(r=foot_ir,h=2*pad_h,$fn=case_sm);
        translate([0,0,pad_h-foot_h])
          cylinder(r=foot_r+tol,h=2*foot_h,$fn=case_sm);
        translate([0,0,-washer_h-foot_h2])
          cylinder(r=washer_r+tol,h=2*washer_h+foot_h2,$fn=case_sm);
        translate([0,0,pad_h-foot_h-nut_h])
          rotate(-15)
            cylinder(r=nut_r+tol,h=2*nut_h,$fn=6);
        // M3 retaining bolts for extrusions
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
      }
    }
    ebars();
  }
}

module assembly() {
  bars();
  //color([0.5,0.5,0.0,0.2]) ebars();
  case();
  color([0.5,0.3,0.3,0.9]) {
    pad();
///*
    translate([-case_x/2+case_r,case_y/2-case_r,0])
      rotate(-90) 
        translate([case_x/2-case_r,case_y/2-case_r,0])
          pad();
    translate([case_x/2-case_r,-case_y/2+case_r,0])
      rotate(90) 
        translate([case_x/2-case_r,case_y/2-case_r,0])
          pad();
    translate([case_x/2-case_r,case_y/2-case_r,0])
      rotate(180) 
        translate([case_x/2-case_r,case_y/2-case_r,0])
          pad();
//*/
  }
}

assembly();