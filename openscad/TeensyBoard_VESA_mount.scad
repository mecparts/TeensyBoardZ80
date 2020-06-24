$fn = 32;
eps = 0.04;
inch = 25.4;

kerf = 0.18;
inset = 0.5;

panel_l = 116;
panel_w = 116;
panel_h = 3.0;
panel_r = 2;

mount_l = 100;
mount_w = 100;
mount_d = 4;

standoff_h = inch/4;
standoff_od = inch/4;
standoff_id = 0.0890 * inch;
fillet_r = 1.5;

htab_l = 0.5 * inch;
htab_h = panel_h;

hslot_l = htab_l + kerf;
hslot_h = htab_h + kerf;

vtab_l = 0.25 * inch;
vtab_h = panel_h;

vslot_l = vtab_l + kerf;
vslot_h = vtab_h + kerf;

side_h = inch * 1.75;

rpi_l = 85;
rpi_w = 56;
rpi_h = 1.4;
rpi_d = 2.9;
rpi_backset = 12;
rpi_xy = [panel_l - rpi_backset - rpi_l - inset, inset, 0];
rpi_xy1 = [25.5, 18,0];
rpi_xy2 = [rpi_l - 5, rpi_w - 12.5, 0];
rpi_xy3 = [rpi_l - 5, 13/32 * inch, 0];

hdmi_xc = 36.8 + 15/2;
hdmi_yc = panel_h + standoff_h + rpi_h + 0.256/2*inch;
hdmi_l = 0.798 * inch + 2;
hdmi_h = 0.405 * inch + 2;

usb_l = 0.635*inch + 1;
usb_h = 0.670*inch + 1;
usb_xc = inset + 2 + 15.9 +6.1 + 13.1/2;
usb_yc = panel_h + standoff_h + rpi_h + 17/2;

sd_socket_l = 1.115 * inch;
sd_l = (0.060 * 2 + 0.943) * inch;
sd_h = 0.136 * inch + rpi_h / 2;
sd_x = panel_w - inset - 0.612*inch - sd_socket_l;
sd_y = panel_h + standoff_h + rpi_h / 2 - sd_h;

tb_l = 4.25 * inch;
tb_w = 2.25 * inch;
tb_xy = [inset, panel_w - inset, 0];
tb_xy1 = [27.635, -5.88, 0];
tb_xy2 = [44.145, -52.235, 0];
tb_xy3 = [109.55, -51.6, 0];
tb_xy4 = [109.55, -15.405, 0];
tb_d = 3.2;

barrel_w = 0.354*inch;
barrel_h = 0.428*inch;
barrel_xc = panel_w - inset -26.835;
barrel_yc = panel_h + standoff_h + inch/16 + barrel_h/2;

teensy_usb_l = 0.474 * inch + 1;
teensy_usb_h = 0.243 * inch + 1;
teensy_usb_xc = 42.71;
teensy_usb_yc = panel_h + standoff_h + inch/16 + 13.5;

module base() {
   difference() {
      union() {
         linear_extrude(height=panel_h) {
            hull() {
               translate([panel_r,panel_r,0]) {
                  circle(r=panel_r);
               }
               translate([panel_l-panel_r,panel_r,0]) {
                  circle(r=panel_r);
               }
               translate([panel_l-panel_r,panel_w-panel_r,0]) {
                  circle(r=panel_r);
               }
               translate([panel_r,panel_w-panel_r,0]) {
                  circle(r=panel_r);
               }
            }
            
            translate([panel_l/3, -htab_h/2 + eps, 0]) {
               square([htab_l,htab_h+eps], center = true);
            }
            translate([2*panel_l/3,-htab_h/2 + eps,0]) {
               square([htab_l,htab_h+eps], center = true);
            }

            translate([panel_l/3, panel_w + htab_h/2 - eps, 0]) {
               square([htab_l, htab_h + eps], center = true);
            }
            translate([2*panel_l/3, panel_w + htab_h/2 - eps, 0]) {
               square([htab_l, htab_h + eps], center = true);
            }

            translate([-htab_h/2 + eps,panel_w/3, 0]) {
               square([htab_h + eps, htab_l], center = true);
            }
            translate([-htab_h/2 + eps, 2*panel_w/3, 0]) {
               square([htab_h+eps,htab_l], center = true);
            }
            
            translate([panel_l + htab_h/2 - eps, panel_w/3, 0]) {
               square([htab_h + eps, htab_l], center = true);
            }
            translate([panel_l + htab_h/2 - eps, 2*panel_w/3, 0]) {
               square([htab_h + eps, htab_l], center = true);
            }
         }
         translate([0, 0, panel_h - eps]) {
            translate(rpi_xy) {
               translate(rpi_xy1) {
                  cylinder(h=standoff_h,d2=standoff_od,d1=standoff_od+2*fillet_r);
               }
               translate(rpi_xy2) {
                  cylinder(h=standoff_h,d2=standoff_od,d1=standoff_od+2*fillet_r);
               }
               translate(rpi_xy3) {
                  cylinder(h=standoff_h,d2=standoff_od,d1=standoff_od+2*fillet_r);
               }
            }
            translate(tb_xy) {
               translate(tb_xy1) {
                  cylinder(h=standoff_h,d2=standoff_od,d1=standoff_od+2*fillet_r);
               }
               translate(tb_xy2) {
                  cylinder(h=standoff_h,d2=standoff_od,d1=standoff_od+2*fillet_r);
               }
               translate(tb_xy3) {
                  cylinder(h=standoff_h,d2=standoff_od,d1=standoff_od+2*fillet_r);
               }
               translate(tb_xy4) {
                  cylinder(h=standoff_h,d2=standoff_od,d1=standoff_od+2*fillet_r);
               }
            }
         }
      }
      translate([0, 0, -eps]) {
         translate([(panel_l-mount_l)/2, (panel_w-mount_w)/2, 0]) {
            cylinder(h=panel_h+2*eps,d=mount_d);
         }
         translate([(panel_l+mount_l)/2, (panel_w-mount_w)/2, 0]) {
            cylinder(h=panel_h+2*eps,d=mount_d);
         }
         translate([(panel_l-mount_l)/2, (panel_w+mount_w)/2, 0]) {
            cylinder(h=panel_h+2*eps,d=mount_d);
         }
         translate([(panel_l+mount_l)/2, (panel_w+mount_w)/2, 0]) {
            cylinder(h=panel_h+2*eps,d=mount_d);
         }
         translate(rpi_xy) {
            translate(rpi_xy1) {
               cylinder(h=(panel_h+standoff_h)+2*eps,d=standoff_id);
            }
            translate(rpi_xy2) {
               cylinder(h=(panel_h+standoff_h)+2*eps,d=standoff_id);
            }
         }
         translate(tb_xy) {
            translate(tb_xy1) {
               cylinder(h=(panel_h+standoff_h)+2*eps,d=standoff_id);
            }
            translate(tb_xy2) {
               cylinder(h=(panel_h+standoff_h)+2*eps,d=standoff_id);
            }
            translate(tb_xy3) {
               cylinder(h=(panel_h+standoff_h)+2*eps,d=standoff_id);
            }
            translate(tb_xy4) {
               cylinder(h=(panel_h+standoff_h)+2*eps,d=standoff_id);
            }
         }
      }
   }
}

module top() {
   difference() {
      linear_extrude(height=panel_h) {
         union() {
            hull() {
               translate([panel_r,panel_r,0]) {
                  circle(r=panel_r);
               }
               translate([panel_l-panel_r,panel_r,0]) {
                  circle(r=panel_r);
               }
               translate([panel_l-panel_r,panel_w-panel_r,0]) {
                  circle(r=panel_r);
               }
               translate([panel_r,panel_w-panel_r,0]) {
                  circle(r=panel_r);
               }
            }
            
            translate([panel_l/3, panel_w + htab_h/2 - eps, 0]) {
               square([htab_l,htab_h+eps], center = true);
            }
            translate([2*panel_l/3,panel_w + htab_h/2 - eps,0]) {
               square([htab_l,htab_h+eps], center = true);
            }

            translate([panel_l/2, -htab_h/2 + eps, 0]) {
               square([htab_l, htab_h + eps], center = true);
            }
         }
      }
      translate([panel_l/2, panel_w/2, panel_h/2] ) {
         linear_extrude(height=panel_h/2+eps) {
            text("TeensyBoard/Z80", font="OCR A Extended", halign="center", valign="center", size = 7);
         }
      }
      translate([0, 0, -eps]) {
         translate([inset+96.85, panel_w-inset-43.98, 0]) {
            cylinder(h=panel_h+2*eps,d=1);
         }
         translate([inset+96.85-2.5, panel_w-inset-43.98, 0]) {
            cylinder(h=panel_h+2*eps,d=1);
         }
         translate([inset+96.85+2.55, panel_w-inset-43.98, 0]) {
            cylinder(h=panel_h+2*eps,d=1);
         }
         translate([inset+96.85, panel_w-inset-43.98-2.5, 0]) {
            cylinder(h=panel_h+2*eps,d=1);
         }
         translate([inset+96.85, panel_w-inset-43.98+2.5, 0]) {
            cylinder(h=panel_h+2*eps,d=1);
         }
         translate([inset+96.85-5, panel_w-inset-43.98, 0]) {
            cylinder(h=panel_h+2*eps,d=1);
         }
         translate([inset+96.85+5, panel_w-inset-43.98, 0]) {
            cylinder(h=panel_h+2*eps,d=1);
         }
         translate([inset+96.85, panel_w-inset-43.98-5, 0]) {
            cylinder(h=panel_h+2*eps,d=1);
         }
         translate([inset+96.85, panel_w-inset-43.98+5, 0]) {
            cylinder(h=panel_h+2*eps,d=1);
         }

         translate([inset+96.85-5*0.707, panel_w-inset-43.98-5*0.707, 0]) {
            cylinder(h=panel_h+2*eps,d=1);
         }
         translate([inset+96.85+5*0.707, panel_w-inset-43.98-5*0.707, 0]) {
            cylinder(h=panel_h+2*eps,d=1);
         }
         translate([inset+96.85-5*0.707, panel_w-inset-43.98+5*0.707, 0]) {
            cylinder(h=panel_h+2*eps,d=1);
         }
         translate([inset+96.85+5*0.707, panel_w-inset-43.98+5*0.707, 0]) {
            cylinder(h=panel_h+2*eps,d=1);
         }
      }
   }
}

module end(dsubs=false) {
   module dsub(c,e,a) {
      r=3.35;
      h=3.96;
      md=3.05;
      hull() {
         translate([-c/2,h/2,0])
            circle(r=r);
         translate([c/2,h/2,0])
            circle(r=r);
         translate([-e/2,-h/2,0])
            circle(r=r);
         translate([e/2,-h/2,0])
            circle(r=r);
      }
      translate([-a/2,0,0])
         circle(d=md);
      translate([a/2,0,0])
         circle(d=md);
   }

   module dsub9() {
      dsub(c=13.77,e=12.01,a=24.99);
   }
   
   module dsub25() {
      dsub(c=35.81,e=34.06,a=47.04);
   }

   x1 = (panel_l - 24.99 - 47.04) / 3 + 47.04 / 2;
   x2 = panel_l - (panel_l - 24.99 - 47.04) / 3 - 24.99 / 2;
   y = panel_h+inch/4+inch/16+0.525*inch+0.510/2*inch+inch/10;
   difference() {
      linear_extrude(height=panel_h) {
         difference() {
            union() {
               translate([-3*panel_h/2,-panel_h/2,0]) {  // main face
                  square([panel_l+3*panel_h, side_h+panel_h]);
               }
               if( !dsubs ) {
                  translate([panel_l/2, side_h+panel_h/2, 0]) {
                     hull() {
                        translate([-hslot_l*3/4, 0, 0]) {
                           circle(d=panel_h*2);
                        }
                        translate([hslot_l*3/4, 0, 0]) {
                           circle(d=panel_h*2);
                        }
                     }
                     square([hslot_l*3/2, panel_h], center=true);
                  }
               }
            }
            translate([panel_l/3, panel_h/2, 0]) {    // bottom slot 1
               square([hslot_l,hslot_h],center=true);
            }
            translate([2*panel_l/3, panel_h/2, 0]) {  // bottom slot 2
               square([hslot_l,hslot_h],center=true);
            }
            if( dsubs ) {
               translate([panel_l/3, side_h-panel_h/2,0]) { // top slot 1
                  square([hslot_l,hslot_h],center=true);
               }
               translate([2*panel_l/3,side_h-panel_h/2,0]) {   // top slot 2
                  square([hslot_l,hslot_h],center=true);
               }
               
               translate([-panel_h/2,side_h/4,0]) { // left slot bottom
                  square([vslot_h,vslot_l],center=true);
               }
               translate([-panel_h/2,3*side_h/4,0]) {  // left slot top
                  square([vslot_h,vslot_l],center=true);
               }
               translate([-panel_h/2,side_h/2,0]) {    // left hole
                  circle(d=rpi_d);
               }
               translate([panel_l+panel_h/2,side_h/4,0]) {  // right slot bottom
                  square([vslot_h,vslot_l],center=true);
               }
               translate([panel_l+panel_h/2,3*side_h/4,0]) { // right slot top
                  square([vslot_h,vslot_l],center=true);
               }
               translate([panel_l+panel_h/2,side_h/2,0]) {  // right hole
                  circle(d=rpi_d);
               }
               translate([x1,y,0]) {
                  dsub25();
               }
               translate([x2,y,0]) {
                  dsub9();
               }
            } else {
               translate([panel_l/2, side_h-panel_h/2,0]) { // top slot 1
                  square([hslot_l,hslot_h],center=true);
               }
               
               translate([-panel_h/2,side_h/4,0]) { // left slot
                  circle(d=rpi_d);
               }
               translate([-panel_h/2,3*side_h/4,0]) {  // left slot top
                  circle(d=rpi_d);
               }
               translate([-panel_h/2,side_h/2,0]) {    // left hole
                  square([vslot_h,vslot_l],center=true);
               }
               translate([panel_l+panel_h/2,side_h/4,0]) {  // right slot bottom
                  circle(d=rpi_d);
               }
               translate([panel_l+panel_h/2,3*side_h/4,0]) { // right slot top
                  circle(d=rpi_d);
               }
               translate([panel_l+panel_h/2,side_h/2,0]) {  // right hole
                  square([vslot_h,vslot_l],center=true);
               }
               translate([rpi_xy[0] + hdmi_xc, hdmi_yc, 0]) {
                  hull() {
                     translate([-hdmi_l/2 + 1, -hdmi_h/2 + 1, 0]) {
                        circle(r=1);
                     }
                     translate([hdmi_l/2 - 1, -hdmi_h/2 + 1, 0]) {
                        circle(r=1);
                     }
                     translate([hdmi_l/2 - 1, hdmi_h/2 - 1, 0]) {
                        circle(r=1);
                     }
                     translate([-hdmi_l/2 + 1, hdmi_h/2 - 1, 0]) {
                        circle(r=1);
                     }
                  }
               }
            }
         }
      }
      if( dsubs ) {
         translate([x1, y - 15, panel_h/2] ) {
            linear_extrude(height=panel_h/2+eps) {
               text("LPT", font="OCR A Extended", halign="center", valign="center", size = 6);
            }
         }
         translate([x1 - 47.04/2, y, panel_h/2] ) {
            cylinder(d=0.250*inch,h=panel_h/2+eps);
         }
         translate([x1 + 47.04/2, y, panel_h/2] ) {
            cylinder(d=0.250*inch,h=panel_h/2+eps);
         }
         translate([x2, y - 15, panel_h/2] ) {
            linear_extrude(height=panel_h/2+eps) {
               text("TTY", font="OCR A Extended", halign="center", valign="center", size = 6);
            }
         }
         translate([x2 - 24.99/2, y, panel_h/2] ) {
            cylinder(d=0.220*inch,h=panel_h/2+eps);
         }
         translate([x2 + 24.99/2, y, panel_h/2] ) {
            cylinder(d=0.220*inch,h=panel_h/2+eps);
         }
      } else {
         translate([rpi_xy[0] + hdmi_xc, hdmi_yc + 15, panel_h/2] ) {
            linear_extrude(height=panel_h/2+eps) {
               text("CRT", font="OCR A Extended", halign="center", valign="center", size = 6);
            }
         }
      }
   }
}

module side(usb=false) {

   module blank_side(reverse=false) {
      difference() {
         union() {
            translate([0,-panel_h/2,0]) {
               square([panel_w, side_h+panel_h]);
            }
            if( reverse ) {
               translate([-panel_h+eps,side_h/2-vtab_l/2,0]) {
                  square([panel_h+eps,vtab_l]);
               }
               translate([panel_l-eps,side_h/4-vtab_l/2,0]) {
                  square([panel_h+eps,vtab_l]);
               }
               translate([panel_l-eps,3*side_h/4-vtab_l/2,0]) {
                  square([panel_h+eps,vtab_l]);
               }
            } else {
               translate([-panel_h+eps,side_h/4-vtab_l/2,0]) {
                  square([panel_h+eps,vtab_l]);
               }
               translate([-panel_h+eps,3*side_h/4-vtab_l/2,0]) {
                  square([panel_h+eps,vtab_l]);
               }
               translate([panel_l-eps,side_h/2-vtab_l/2,0]) {
                  square([panel_h+eps,vtab_l]);
               }
            }
         }
         translate([panel_w/3, panel_h/2, 0]) {    // bottom slot 1
            square([hslot_l,hslot_h],center=true);
         }
         translate([2*panel_w/3, panel_h/2, 0]) {  // bottom slot 2
            square([hslot_l,hslot_h],center=true);
         }

         if( reverse ) {
            translate([panel_l-5/32*inch+eps,side_h/2,0]) {
               square([5/16*inch+eps,1/8*inch],center=true);
            }
            translate([panel_l-5/32*inch,side_h/2,0]) {
               square([1/8*inch,1/4*inch],center=true);
            }
      
            translate([5/32*inch-eps,side_h/4,0]) {
               square([5/16*inch+eps,1/8*inch],center=true);
            }
            translate([5/32*inch,side_h/4,0]) {
               square([1/8*inch,1/4*inch],center=true);
            }

            translate([5/32*inch-eps,3*side_h/4,0]) {
               square([5/16*inch+eps,1/8*inch],center=true);
            }
            translate([5/32*inch,3*side_h/4,0]) {
               square([1/8*inch,1/4*inch],center=true);
            }
         } else {
            translate([5/32*inch-eps,side_h/2,0]) {
               square([5/16*inch+eps,1/8*inch],center=true);
            }
            translate([5/32*inch,side_h/2,0]) {
               square([1/8*inch,1/4*inch],center=true);
            }

            translate([panel_l-5/32*inch+eps,side_h/4,0]) {
               square([5/16*inch+eps,1/8*inch],center=true);
            }
            translate([panel_l-5/32*inch,side_h/4,0]) {
               square([1/8*inch,1/4*inch],center=true);
            }
      
            translate([panel_l-5/32*inch+eps,3*side_h/4,0]) {
               square([5/16*inch+eps,1/8*inch],center=true);
            }
            translate([panel_l-5/32*inch,3*side_h/4,0]) {
               square([1/8*inch,1/4*inch],center=true);
            }
         }
      }
   }
   
   if( usb ) {
      difference() {
         linear_extrude(height=panel_h) {
            difference() {
               blank_side(reverse = true);
               translate([usb_xc, usb_yc, 0]) {
                  square([usb_l, usb_h], center=true);
               }
               // power connector
               translate([barrel_xc, barrel_yc]) {
                  square([barrel_w + 1, barrel_h + 1], center=true);
               }
            }
         }
         translate([usb_xc, usb_yc + 15, panel_h/2] ) {
            linear_extrude(height=panel_h/2+eps) {
               text("KBD", font="OCR A Extended", halign="center", valign="center", size = 6);
            }
         }
         translate([barrel_xc, barrel_yc + 13, panel_h/2] ) {
            linear_extrude(height=panel_h/2+eps) {
               text("5V@1A", font="OCR A Extended", halign="center", valign="center", size = 6);
            }
         }
         translate([barrel_xc-17, barrel_yc-0.6, panel_h/2]) {
            linear_extrude(height=panel_h/2+eps) {
               text("+ ", font="OCR A Extended", halign="center", valign="center", size = 6);
               translate([0, 0.6, 0]) {
                  translate([5, 0, 0]) {
                     difference() {
                        circle(d=6);
                        circle(d=4.7);
                        translate([-2,0,0]) {
                           square(3, center=true);
                        }
                     }
                     circle(d=2);
                  }
                  translate([3, 0, 0]) {
                     square([5,0.65],center=true);
                  }
               }
            }
         }
      }
   } else {
      difference() {
         linear_extrude(height=panel_h) {
            difference() {
               blank_side(reverse = false);
               translate([sd_x, sd_y, 0]) {
                  square([sd_l, sd_h]);
               }
               translate([inset+tb_w+0.25*inch, side_h*2/3, 0]) {
                  circle(d=0.196*inch);
               }
               translate([teensy_usb_xc, teensy_usb_yc, 0]) {
                  square([teensy_usb_l, teensy_usb_h], center=true);
               }
            }
         }
         translate([sd_x-3, sd_y + sd_h/2, panel_h/2] ) {
            linear_extrude(height=panel_h/2+eps) {
               text("SD", font="OCR A Extended", halign="right", valign="center", size = 6);
            }
         }
         translate([inset+tb_w+0.25*inch, side_h*2/3, panel_h/2] ) {
            linear_extrude(height=panel_h/2+eps) {
               text(" DISK", font="OCR A Extended", halign="left", valign="center", size = 6);
            }
         }
         translate([teensy_usb_xc-teensy_usb_l/2-3, teensy_usb_yc, panel_h/2] ) {
            linear_extrude(height=panel_h/2+eps) {
               text("PRG", font="OCR A Extended", halign="right", valign="center", size = 6);
            }
         }
      }
   }
}

module dsub_end() {
   end(true);
}

module hdmi_end() {
   end(false);
}

module sdcard_side() {
   side(false);
}

module usb_side() {
   side(true);
}

//base();
//top();
//dsub_end();  // Dsub end
//hdmi_end(); // hdmi end
//usb_side(); // keyboard and power
sdcard_side(); // sd card
