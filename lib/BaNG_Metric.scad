// Bolt and Nut Generator (Metric)
// Copyright (c) 2023, Michael H. Phillips
// All rights reserved

/* [Global Options] */

// Part Type - Choose the type of part to make.
Part_Type = "Bolt"; // ["Bolt", "Nut", "Washer", "Threaded Rod", "Tap"]
// Metric Size - The metric thread size for the part.
Metric_Size = 8; //[ 2, 2.2, 2.3, 2.5, 2.6, 3, 3.5, 4, 4.5, 5, 5.5, 6, 7, 8, 9, 10, 11, 12, 14, 15, 16, 17, 18, 20, 22, 24, 25, 26, 27, 28, 30, 32, 33, 35, 36, 38, 39, 40, 42, 45, 48, 50, 52, 55, 56, 58, 60, 62, 63, 64, 65, 68, 70, 72, 75, 76, 78, 80, 82, 85, 90, 95, 100]
// Quality - The number of line segments in a circle. Higher values produce a smoother circle but take longer to preview and render.
Quality = 24;
// Tolerance - Thread diameters are a range in the spec. Loose uses the smallest external and largest internal in the spec. Tight uses the middle of the range for both.
Tolerance = "Loose"; // ["Loose", "Tight"]
// External Thread Adjustment - Fine tune external thread radius. Increase to make Threaded Rod, and Bolts bigger and decrease to make them smaller.
External_Thread_Adjustment = 0; // .01
// Internal Thread Adjustment - Fine tune internal thread radius. Increase to make nuts, taps, and washers bigger and decrease to make them smaller.
Internal_Thread_Adjustment = 0; // .01
Left_Hand_Thread = false;
// Bisect - Cut the model in half. Useful for checking hex key or Phillips depth and size for socket and button heads.
Bisect = false;

/* [Bolt Options] */
Thread_Length = 15; // .5
Shoulder_Length = 0; // .5
// Shoulder Diameter - The diameter of the smooth portion. Special values: Negative numbers set the diameter to the thread minimum diameter and zero sets it to the thread maximum diameter.
Shoulder_Diameter = 0; // .5
Head_Type = "Hex"; // ["Hex", "Socket", "Button", "Star"]
// Head Height - Special value: Zero for the default height.
Head_Height = 0; // .5
// Head Width - Special value: Zero for the default width.
Head_Width = 0; // .5
// Head Chamfer - Hex and star heads only.
Head_Chamfer = true;
// Driver Type - For socket and button heads only.
Driver_Type = "Phillips"; // ["Hex", "Phillips"]
Phillips_Size = "Ph2"; // ["Ph0", "Ph1", "Ph2", "Ph3"]
Hex_Key_Size = 5.2; // .01
// Hex Key Depth - Special value: Zero for the default depth.
Hex_Key_Depth = 0; // .5

/* [Nut Options] */
Nut_Type = "Hex"; // ["Hex", "Wing", "Star"]
// Width - Special value: Zero for the default width.
Width = 0; // .5
// Height - Special value: Zero for the default height.
Height = 0; // .5
// Chamfer - Hex and star nuts only.
Chamfer = true;

/* [Washer Options] */
Thickness = 1.0; // .5
// Outside Diameter - Special value: Zero for default O.D.
Outside_Diameter = 0; // .5

/* [Threaded Rod and Tap Options] */
Length = 10; // .5

/* [Star Options] */
// Number of Points - The number of points on the star.
Number_of_Points = 6;
// Inner Radius - The distance from the center to the inner most part of the star. Zero for default.
Inner_Radius = 0; // .1
// Inner Handle Length - Controls the shape of the inner curve. Zero for default.
Inner_Handle_Length = 0; // .1
// Outer Radius - The distance from the center to the outer most part of the star. Zero for default.
Outer_Radius = 0; // .1
// Outer Handle Length - Controls the shape of the outer curve. Zero for default.
Outer_Handle_Length = 0; // .1
// Segments - Number of line segments per curve of the star.
Segments = 12;
module __Customizer_Limit__() {}

difference() {
  if (Part_Type == "Bolt") {
    bolt(Metric_Size, Thread_Length, Shoulder_Length, Shoulder_Diameter, Head_Type, Driver_Type,
         Phillips_Size, Head_Height, Head_Width, Hex_Key_Size, Hex_Key_Depth, Tolerance,
         External_Thread_Adjustment, Left_Hand_Thread, Head_Chamfer, Number_of_Points, Inner_Radius,
         Inner_Handle_Length, Outer_Radius, Outer_Handle_Length, Segments, $fn=Quality);
  } else if (Part_Type == "Nut") {
    nut(Metric_Size, Width, Height, Nut_Type, Tolerance, Internal_Thread_Adjustment,
        Left_Hand_Thread, Chamfer, Number_of_Points, Inner_Radius, Inner_Handle_Length,
        Outer_Radius, Outer_Handle_Length, Segments, $fn=Quality);
  } else if (Part_Type == "Washer") {
    washer(Metric_Size, Thickness, Outside_Diameter, Tolerance, Internal_Thread_Adjustment, $fn=Quality);
  } else if (Part_Type == "Threaded Rod") {
    threaded_rod(Metric_Size, Length, Tolerance, External_Thread_Adjustment, Left_Hand_Thread, $fn=Quality);
  } else if (Part_Type == "Tap") {
    tap(Metric_Size, Length, Tolerance, Internal_Thread_Adjustment, Left_Hand_Thread, $fn=Quality);
  }
  if (Bisect) {
    translate([-100, -200, -0.01])cube(200);
  }
}

module bolt(m_size, thread_length, shoulder_length, shoulder_diameter, head_type, drive_type,
            phillips_size, head_height_, head_width_, key_size, key_depth_, tolerance,
            thread_adjustment, left_hand_thread, chamfer, n_points, inner_radius, inner_handle_length,
            outer_radius, outer_handle_length, segments) {
  head_width = head_width_ == 0 ? hex_head_lookup(m_size) : head_width_;
  head_height = head_type == "Hex" || head_type == "Button" || head_type == "Star" ?
    head_height_ == 0 ? head_width * 0.3 : head_height_:
    head_height_ == 0 ? head_width * 0.5 : head_height_;
  head_radius = head_width / 2;
  key_depth = key_depth_ == 0 ? head_height * 0.70 : key_depth_;
  pitch = pitch_lookup(m_size);

  if (thread_length > 0) {
    translate([0, 0, shoulder_length])difference() {
      translate([0, 0, -pitch + head_height]) {
        threaded_rod(m_size, thread_length + pitch, tolerance, thread_adjustment, left_hand_thread);
      }
      translate([0, 0, -pitch])hexagon(head_width, head_height + pitch);
    }
  }

  if (shoulder_length > 0) {
    if (shoulder_diameter < 0) {
      d = d_min(rod_maj_lookup(m_size, tolerance)+thread_adjustment, pitch_lookup(m_size));
      translate([0, 0, head_height])cylinder(h=shoulder_length, d=d);
    } else if (shoulder_diameter == 0) {
      d = rod_maj_lookup(m_size, tolerance)+thread_adjustment;
      translate([0, 0, head_height])cylinder(h=shoulder_length, d=d);
    } else {
      translate([0, 0, head_height])cylinder(h=shoulder_length, d=shoulder_diameter);
    }
  }

  if (head_type == "Hex") {
    if (chamfer) {
      difference() {
        hexagon(head_width, head_height);
        chamfer_hexagon(head_width, head_height);
      }
    } else {
      hexagon(head_width, head_height);
    }
  } else if (head_type == "Socket") {
    difference() {
      cylinder(h=head_height, d=head_width);
      if (drive_type == "Hex") {
        translate([0, 0, -0.01])hexagon(key_size, key_depth);
      } else if (drive_type == "Phillips") {
        if (phillips_size == "Ph0") {
          ph0();
        } else if (phillips_size == "Ph1") {
          ph1();
        } else if (phillips_size == "Ph2") {
          ph2();
        } else if (phillips_size == "Ph3") {
          ph3();
        }
      }
    }
  } else if (head_type == "Button") {
    key_radius = key_size/2/cos(30);
    flat_radius = drive_type == "Hex" ? key_radius + (head_radius - key_radius)*0.3 :
      phillips_size == "Ph0" ? 1.6 + (head_radius - 1.6)*0.3 :
        phillips_size == "Ph1" ? 2.75 + (head_radius - 2.75)*0.3 :
          phillips_size == "Ph2" ? 3.0 + (head_radius - 3.0)*0.3 : 3.5 + (head_radius - 3.5)*0.3;
    difference() {
      translate([0, 0, head_height])rotate([180, 0, 0])
        rotate_extrude(angle=360)polygon(concat([[0, head_height]],
          quadratic_bezier([flat_radius, head_height], [head_radius, head_height], [head_radius, 0], 12),
          [[0, 0]]));
      if (drive_type == "Hex") {
        translate([0, 0, -0.01])hexagon(key_size, key_depth);
      } else if (drive_type == "Phillips") {
        if (phillips_size == "Ph0") {
          ph0();
        } else if (phillips_size == "Ph1") {
          ph1();
        } else if (phillips_size == "Ph2") {
          ph2();
        } else if (phillips_size == "Ph3") {
          ph3();
        }
      }
    }
  } else if (head_type == "Star") {
    or = outer_radius == 0 ? head_width/cos(30)/2 : outer_radius;
    ir = inner_radius == 0 ? or * 0.75 : inner_radius;
    ohl = outer_handle_length == 0 ? or * 0.2 : outer_handle_length;
    ihl = inner_handle_length == 0 ? or * 0.2 : inner_handle_length;
    bezier_star(n_points = n_points,
    inner_radius = ir,
    inner_handle_length = ihl,
    outer_radius = or,
    outer_handle_length = ohl,
    segments = segments,
    height = head_height,
    chamfer = chamfer);
  }
}

module nut(m_size, width_=0, height_=0, type="Hex", tolerance="Loose", thread_adjustment=0, left_hand_thread=false, chamfer=true,
           n_points=6, inner_radius=0, inner_handle_length=0, outer_radius=0, outer_handle_length=0, segments=12) {
  width = width_ == 0 ? hex_head_lookup(m_size) : width_;
  pitch = pitch_lookup(m_size);
  height = height_ == 0 ? width * 0.3 : height_;

  difference() {
    if (type == "Hex") {
      if (chamfer) {
        difference() {
          hexagon(width, height);
          chamfer_hexagon(width, height);
        }
      } else {
        hexagon(width, height);
      }
    } else if (type == "Star") {
      or = outer_radius == 0 ? width/cos(30)/2 : outer_radius;
      ir = inner_radius == 0 ? or * 0.75 : inner_radius;
      ohl = outer_handle_length == 0 ? or * 0.2 : outer_handle_length;
      ihl = inner_handle_length == 0 ? or * 0.2 : inner_handle_length;
      bezier_star(n_points = n_points,
      inner_radius = ir,
      inner_handle_length = ihl,
      outer_radius = or,
      outer_handle_length = ohl,
      segments = segments,
      height = height,
      chamfer = chamfer);
    } else if (type == "Wing") {
      cylinder(h=height, d=width);
      mirror_copy([1, 0, 0])hull() {
        translate([width/2 + height*0.75, width/12, height*2.75])rotate([90, 0, 0])cylinder(h=width/6, d=height*1.5);
        translate([tap_maj_lookup(m_size, tolerance)/2, -width/12, 0])cube([0.01, width/6, height]);
      }
    }
    translate([0, 0, -pitch]) {
      tap(m_size, height + pitch * 2, tolerance, thread_adjustment, left_hand_thread);
    }
  }
}

module washer(m_size, thickness, od_, tolerance, thread_adjustment) {
  id = tap_maj_lookup(m_size, tolerance) + thread_adjustment;
  pitch = pitch_lookup(m_size);
  od = od_ == 0 ? hex_head_lookup(m_size) : od_;
  difference() {
    cylinder(h=thickness, d=od);
    translate([0, 0, -1])cylinder(h=thickness + 2, d=id);
  }
}

module threaded_rod(m_size, length, tolerance, thread_adjustment, left_hand_thread) {
  dmaj = rod_maj_lookup(m_size, tolerance) + thread_adjustment;
  pitch = pitch_lookup(m_size);

  threaded_cylinder(dmaj, pitch, length, left_hand_thread);
}

module tap(m_size, length, tolerance, thread_adjustment, left_hand_thread) {
  dmaj = tap_maj_lookup(m_size, tolerance) + thread_adjustment;
  pitch = pitch_lookup(m_size);

  difference() {
    translate([ 0, 0, -pitch ]) {
      threaded_cylinder(dmaj, pitch, length + pitch * 2, left_hand_thread);
    }
    translate([ 0, 0, -2 * pitch ]) {
      cylinder(h = 2 * pitch, d = dmaj + 2);
    }
    translate([ 0, 0, length ]) {
      cylinder(h = 2 * pitch, d = dmaj + 2);
    }
  }
}

//------------------------------------------------------------------------------

module threaded_cylinder(dmaj, pitch, length, left_hand_thread) {
  segments = $fn ? $fn : 24;
  dmin = d_min(dmaj, pitch);
  length1 = length - pitch;
  n_steps = floor(length1 / pitch * segments);
  z_step = length1 / n_steps;
  step_angle = 360 / segments;
  n_lower_taper_steps = floor(segments * 90 / 360);
  n_upper_taper_steps = floor(segments * 90 / 360);
  n_non_taper_steps = n_steps - n_lower_taper_steps - n_upper_taper_steps;

  middle_start = n_lower_taper_steps + 1;
  middle_end = n_steps - n_upper_taper_steps;
  upper_taper_start = middle_end + 1;

  thread_profile0 = [ dmin / 2, 0, 3 / 4 * pitch + 1 / 8 * pitch ];
  thread_profile1 = [ dmaj / 2, 0, 7 / 16 * pitch + 1 / 8 * pitch ];
  thread_profile2 = [ dmaj / 2, 0, 5 / 16 * pitch + 1 / 8 * pitch ];
  thread_profile3 = [ dmin / 2, 0, 0 + 1 / 8 * pitch ];

  lerp_profile1 = [ dmin / 2, 0, 7 / 16 * pitch ];
  lerp_profile2 = [ dmin / 2, 0, 5 / 16 * pitch ];

  lerp_start1 = lerp(lerp_profile1, thread_profile1, n_lower_taper_steps, 1);
  lerp_start2 = lerp(lerp_profile2, thread_profile2, n_lower_taper_steps, 1);

  lerp_end1 = lerp(lerp_profile1, thread_profile1, n_upper_taper_steps, 1);
  lerp_end2 = lerp(lerp_profile2, thread_profile2, n_upper_taper_steps, 1);

  lower_taper_points = [for (step = [0:floor(n_lower_taper_steps)]) each
      [[cos(step_angle * step) * (thread_profile0[0]),
        sin(step_angle * step) * (thread_profile0[0]),
        z_step * step + (thread_profile0[2])],
       [cos(step_angle * step) *
            (lerp(lerp_start1, thread_profile1, n_lower_taper_steps, step)) [0],
        sin(step_angle * step) *
            (lerp(lerp_start1, thread_profile1, n_lower_taper_steps, step)) [0],
        z_step * step + (thread_profile1[2])],
       [cos(step_angle * step) *
            (lerp(lerp_start2, thread_profile2, n_lower_taper_steps, step)) [0],
        sin(step_angle * step) *
            (lerp(lerp_start2, thread_profile2, n_lower_taper_steps, step)) [0],
        z_step * step + (thread_profile2[2])],
       [cos(step_angle * step) * (thread_profile3[0]),
        sin(step_angle * step) * (thread_profile3[0]),
        z_step * step + (thread_profile3[2])]]];
  lower_end_face = [[ 0, 1, 2, 3 ]];
  lower_taper_thread_faces = [for (step = [1:n_lower_taper_steps])
          [[step * 4 - 4, step * 4, step * 4 + 1, step * 4 - 3],
           [step * 4 - 3, step * 4 + 1, step * 4 + 2, step * 4 - 2],
           [step * 4 - 2, step * 4 + 2, step * 4 + 3, step * 4 - 1],
           [step * 4, step * 4 - 4, step * 4 - 1, step * 4 + 3]]];
  lower_taper_thread_faces1 = flatten(lower_taper_thread_faces);
  lower_taper_faces = concat(lower_end_face, lower_taper_thread_faces1);

  middle_points = [for (step = [middle_start:middle_end]) each
      [[cos(step_angle * step) * (thread_profile0[0]),
        sin(step_angle * step) * (thread_profile0[0]),
        z_step * step + (thread_profile0[2])],
       [cos(step_angle * step) * (thread_profile1[0]),
        sin(step_angle * step) * (thread_profile1[0]),
        z_step * step + (thread_profile1[2])],
       [cos(step_angle * step) * (thread_profile2[0]),
        sin(step_angle * step) * (thread_profile2[0]),
        z_step * step + (thread_profile2[2])],
       [cos(step_angle * step) * (thread_profile3[0]),
        sin(step_angle * step) * (thread_profile3[0]),
        z_step * step + (thread_profile3[2])],
  ]];
  middle_thread_faces = [for (step = [middle_start:middle_end])
          [[step * 4 - 4, step * 4, step * 4 + 1, step * 4 - 3],
           [step * 4 - 3, step * 4 + 1, step * 4 + 2, step * 4 - 2],
           [step * 4 - 2, step * 4 + 2, step * 4 + 3, step * 4 - 1],
           [step * 4, step * 4 - 4, step * 4 - 1, step * 4 + 3]]];
  middle_faces = flatten(middle_thread_faces);

  upper_taper_points = [for (step = [upper_taper_start:n_steps]) each
      [[cos(step_angle * step) * (thread_profile0[0]),
        sin(step_angle * step) * (thread_profile0[0]),
        z_step * step + (thread_profile0[2])],
       [cos(step_angle * step) *
            (lerp(thread_profile1, lerp_end1, n_upper_taper_steps,
                  step - n_lower_taper_steps - n_non_taper_steps)) [0],
        sin(step_angle * step) *
            (lerp(thread_profile1, lerp_end1, n_upper_taper_steps,
                  step - n_lower_taper_steps - n_non_taper_steps)) [0],
        z_step * step + (thread_profile1[2])],
       [cos(step_angle * step) *
            (lerp(thread_profile2, lerp_end2, n_upper_taper_steps,
                  step - n_lower_taper_steps - n_non_taper_steps)) [0],
        sin(step_angle * step) *
            (lerp(thread_profile2, lerp_end2, n_upper_taper_steps,
                  step - n_lower_taper_steps - n_non_taper_steps)) [0],
        z_step * step + (thread_profile2[2])],
       [cos(step_angle * step) * (thread_profile3[0]),
        sin(step_angle * step) * (thread_profile3[0]),
        z_step * step + (thread_profile3[2])]]];
  upper_taper_thread_faces = [for (step = [upper_taper_start:n_steps])
          [[step * 4 - 4, step * 4, step * 4 + 1, step * 4 - 3],
           [step * 4 - 3, step * 4 + 1, step * 4 + 2, step * 4 - 2],
           [step * 4 - 2, step * 4 + 2, step * 4 + 3, step * 4 - 1],
           [step * 4, step * 4 - 4, step * 4 - 1, step * 4 + 3]]];
  upper_taper_thread_faces1 = flatten(upper_taper_thread_faces);
  end_face = [[n_steps * 4, n_steps * 4 + 3, n_steps * 4 + 2, n_steps * 4 + 1]];
  upper_taper_faces = concat(upper_taper_thread_faces1, end_face);

  points = concat(lower_taper_points, middle_points, upper_taper_points);
  faces = concat(lower_taper_faces, middle_faces, upper_taper_faces);

  if (left_hand_thread) {
    mirror([ 1, 0, 0 ]) {
      union() {
        cylinder(h = length, d = dmin + 0.001, $fn = segments);
        polyhedron(points, faces, convexity = length / pitch + 2);
      }
    }
  } else {
    union() {
      cylinder(h = length, d = dmin + 0.001, $fn = segments);
      polyhedron(points, faces, convexity = length / pitch + 2);
    }
  }
}

module chamfer_hexagon(width, height) {
  radius = width / 2;
  points = [
    [radius, height + 0.001], [radius/cos(30) + height/2 + 1, height + 0.001],
    [radius/cos(30) + height/2 + 1, -0.001], [radius, -0.001], [radius + height/2, height/2]
  ];
  rotate_extrude(angle = 360, convexity = 4) {
    polygon(points);
  }
}

module hexagon(width, height) {
  radius = width / 2 / cos(30);

  cylinder(h = height, r = radius, $fn = 6);
}

module mirror_copy(normal) {
  children();
  mirror(normal)children();
}

module rounded_square(v, r) {
  hull() {
    translate([r, r])circle(r);
    translate([v.x-r, r])circle(r);
    translate([r, v.y-r])circle(r);
    translate([v.x-r, v.y-r])circle(r);
  }
}

module phillet(r1, r2) {
  rotate([0,11,0])rotate([0,0,-45])linear_extrude(r1*4)rounded_square([r1*2, r1*2], r2);
}

module ph(r1, r2, tip_cut) {
  h=r1/tan(30);
  rotate([0,180,45])translate([0,0,-h])difference() {
    cylinder(h = 20, r = r1);
    rotate_extrude(angle=360)polygon([[0, 0], [r1, h], [r1+1, h], [r1+1, -1], [0,-1]]);
    phillet(r1, r2);
    rotate([0,0,90])phillet(r1, r2);
    rotate([0,0,180])phillet(r1, r2);
    rotate([0,0,270])phillet(r1, r2);
    translate([0,0,-r1+tip_cut])cylinder(h=r1, r=r1);
  }
}

module ph0() {
  ph(1.6, 0.25, 0.44);
}

module ph1() {
  ph(2.75, 0.5, 0.66);
}

module ph2() {
  ph(3.0, 0.75, 1.0);
}

module ph3() {
  ph(3.5, 1.25, 2.25);
}

module bezier_star (
  n_points,
  inner_radius,
  inner_handle_length,
  outer_radius,
  outer_handle_length,
  segments,
  height,
  chamfer,
) {
  chamfer_size=0.2*height;
  module cutter() {
    li = translate_list(list_2d_to_3d(bezier_star_pts(n_points,inner_radius-chamfer_size,
         inner_handle_length*(inner_handle_length/(inner_handle_length+chamfer_size)),
         outer_radius-chamfer_size,
         outer_handle_length*(outer_handle_length/(outer_handle_length+chamfer_size)),
         segments)), [0,0,-0.01]);
    lo = translate_list(list_2d_to_3d(bezier_star_pts(n_points,inner_radius+0.1,
         inner_handle_length*((inner_handle_length+0.1)/inner_handle_length),
         outer_radius+0.1,
         outer_handle_length*((outer_handle_length+0.1)/outer_handle_length),
         segments)), [0,0,-0.01]);
    ui = translate_list(list_2d_to_3d(bezier_star_pts(n_points,inner_radius+0.1,
         inner_handle_length*((inner_handle_length+0.1)/inner_handle_length),
         outer_radius+0.1,
         outer_handle_length*((outer_handle_length+0.1)/outer_handle_length),
         segments)), [0,0,chamfer_size]);
    uo = translate_list(list_2d_to_3d(bezier_star_pts(n_points,inner_radius+1,
         inner_handle_length*((inner_handle_length+1)/inner_handle_length),
         outer_radius+1,
         outer_handle_length*((outer_handle_length+1)/outer_handle_length),
         segments)), [0,0,chamfer_size]);
    pts = concat(li,lo,ui,uo);
    faces = [for (i=[0:len(li)-1]) [
                                   [len(li)+i, len(li)+(i+1)%len(li), 3*len(li)+(i+1)%len(li), 3*len(li)+i],
                                   [3*len(li)+i, 3*len(li)+(i+1)%len(li), 2*len(li)+(i+1)%len(li), 2*len(li)+i],
                                   [2*len(li)+i, 2*len(li)+(i+1)%len(li), (i+1)%len(li), i],
                                   [i, (i+1)%len(li), len(li)+(i+1)%len(li), len(li)+i]]
    ];
    polyhedron(pts,flatten(faces),convexity=30);
  }
  if (chamfer) {
    difference() {
      linear_extrude(height, convexity=30)polygon(bezier_star_pts(n_points,inner_radius,inner_handle_length,outer_radius,outer_handle_length,segments),convexity=30);
      cutter();
      translate([0,0,height+0.01])rotate([180,0,0])cutter();
    }
  } else {
    linear_extrude(height, convexity=30)polygon(bezier_star_pts(n_points,inner_radius,inner_handle_length,outer_radius,outer_handle_length,segments));
  }
}

//------------------------------------------------------------------------------
function translate_list(l, v) = [for (i=[0:len(l)-1]) l[i]+v];

function rod_maj_lookup(m, tolerance) = tolerance == "Loose" ? rod_maj_lookup_min(m) : (rod_maj_lookup_min(m) + rod_maj_lookup_max(m))/2;

function tap_maj_lookup(m, tolerance) = tolerance == "Loose" ? tap_maj_lookup_max(m) : (tap_maj_lookup_min(m) + tap_maj_lookup_max(m))/2;

function flatten(l) = [for (a = l) for (b = a) b];

function thread_height(pitch) = sqrt(3) / 2 * pitch;

function d_min(dMaj, pitch) = dMaj - 2 * 5 / 8 * thread_height(pitch);

function lerp(start, end, nSteps, step) = start + ((end - start) / nSteps * step);

function quadratic_bezier(start, control, end, segments) = [for (i = [0:segments], t=i*1/segments)
  start * (1-t)*(1-t) + control*t*(1-t)*2 + end*t*t];

function cubic_bezier(start, control1, control2, end, segments) = [for (i=[0:segments], t=i*1/segments)
            start * (1.0 - t) * (1.0 - t) * (1.0 - t)
                + control1 * t * (1.0 - t) * (1.0 - t) * 3.0
                + control2 * t * t * (1.0 - t) * 3.0
                + end * t * t * t ];

function norm2(v) = [v.x/sqrt(v.x*v.x+v.y*v.y), v.y/sqrt(v.x*v.x+v.y*v.y)];

function reverse_list(l) = [for (i=[0:len(l)-1])l[len(l)-1-i]];

function rotate_cw_2d(p, a) = [p.x*cos(-a)-p.y*sin(-a),p.x*sin(-a)+p.y*cos(-a)];

function list_2d_to_3d(l) = [for (i=[0:len(l)-1]) [l[i].x, l[i].y, 0]];

function bezier_star_pts(
  n_points,
  inner_radius,
  inner_handle_length,
  outer_radius,
  outer_handle_length,
  segments,
) = let (
  a = 360/(n_points),
  a2 = a/2,
  n = n_points,
  ir = inner_radius,
  ihl = inner_handle_length,
  or = outer_radius,
  ohl = outer_handle_length,

  start = [or,0],
  control1 = [or,-ohl],
  end = [cos(a2)*ir, -sin(a2)*ir],
  control2 = end + norm2([or,0] - [cos(a)*or, -sin(a)*or])*ihl,

  first_half = cubic_bezier(start,control1,control2,end,segments),
  reversed = reverse_list(l = first_half),
  second_half1 = [for (a=reversed)[a.x,-a.y]],
  second_half = [ for (i=[0:len(second_half1)-1]) rotate_cw_2d(second_half1[i], a)],

  section_pts = concat(first_half,second_half))

  flatten([for (i=[0:n-1])[for (j=[0:len(section_pts)-1]) rotate_cw_2d(section_pts[j], a*i)]]);

// lookup tables derived from
// http://www.apollointernational.in/iso-metric-thread-chart.php
function pitch_lookup(m) = lookup(m, [
  [ 2,   0.4 ],
  [ 2.2, 0.45 ],
  [ 2.3, 0.45 ],
  [ 2.5, 0.45 ],
  [ 2.6, 0.45 ],
  [ 3,   0.5 ],
  [ 3.5, 0.6 ],
  [ 4,   0.7 ],
  [ 4.5, 0.75 ],
  [ 5,   0.8 ],
  [ 5.5, 0.5 ],
  [ 6,   1 ],
  [ 7,   1 ],
  [ 8,   1.25 ],
  [ 9,   1.25 ],
  [ 10,  1.5 ],
  [ 11,  1.5 ],
  [ 12,  1.75 ],
  [ 14,  2 ],
  [ 15,  1.5 ],
  [ 16,  2 ],
  [ 17,  1.5 ],
  [ 18,  2.5 ],
  [ 20,  2.5 ],
  [ 22,  3 ],
  [ 24,  3 ],
  [ 25,  2 ],
  [ 26,  1.5 ],
  [ 27,  3 ],
  [ 28,  2 ],
  [ 30,  3.5 ],
  [ 32,  2 ],
  [ 33,  3.5 ],
  [ 35,  1.5 ],
  [ 36,  4 ],
  [ 38,  1.5 ],
  [ 39,  4 ],
  [ 40,  3 ],
  [ 42,  4.5 ],
  [ 45,  4.5 ],
  [ 48,  5 ],
  [ 50,  4 ],
  [ 52,  5 ],
  [ 55,  4 ],
  [ 56,  5.5 ],
  [ 58,  4 ],
  [ 60,  5.5 ],
  [ 62,  4 ],
  [ 63,  1.5 ],
  [ 64,  6 ],
  [ 65,  4 ],
  [ 68,  6 ],
  [ 70,  6 ],
  [ 72,  6 ],
  [ 75,  6 ],
  [ 76,  6 ],
  [ 78,  2 ],
  [ 80,  6 ],
  [ 82,  2 ],
  [ 85,  6 ],
  [ 90,  6 ],
  [ 95,  6 ],
  [ 100, 6 ],
]);

// minimum diameter of dMaj range used for threaded rods
function rod_maj_lookup_min(m) = lookup(m, [
  [ 2,   1.886 ],
  [ 2.2, 2.08  ],
  [ 2.3, 2.18  ],
  [ 2.5, 2.38  ],
  [ 2.6, 2.48  ],
  [ 3,   2.874 ],
  [ 3.5, 3.354 ],
  [ 4,   3.838 ],
  [ 4.5, 4.338 ],
  [ 5,   4.826 ],
  [ 5.5, 5.374 ],
  [ 6,   5.794 ],
  [ 7,   6.794 ],
  [ 8,   7.76  ],
  [ 9,   8.76  ],
  [ 10,  9.732 ],
  [ 11,  10.73 ],
  [ 12,  11.7  ],
  [ 14,  13.68 ],
  [ 15,  14.73 ],
  [ 16,  15.68 ],
  [ 17,  16.73 ],
  [ 18,  17.62 ],
  [ 20,  19.62 ],
  [ 22,  21.58 ],
  [ 24,  23.58 ],
  [ 25,  24.68 ],
  [ 26,  25.73 ],
  [ 27,  26.58 ],
  [ 28,  27.68 ],
  [ 30,  29.52 ],
  [ 32,  31.68 ],
  [ 33,  32.54 ],
  [ 35,  34.73 ],
  [ 36,  35.47 ],
  [ 38,  37.73 ],
  [ 39,  38.47 ],
  [ 40,  39.58 ],
  [ 42,  41.44 ],
  [ 45,  44.44 ],
  [ 48,  47.4  ],
  [ 50,  49.47 ],
  [ 52,  51.4, ],
  [ 55,  54.47 ],
  [ 56,  55.37 ],
  [ 58,  57.47 ],
  [ 60,  59.37 ],
  [ 62,  61.47 ],
  [ 63,  62.73 ],
  [ 64,  63.32 ],
  [ 65,  64.47 ],
  [ 68,  67.32 ],
  [ 70,  69.32 ],
  [ 72,  71.32 ],
  [ 75,  74.32 ],
  [ 76,  75.32 ],
  [ 78,  77.68 ],
  [ 80,  79.32 ],
  [ 82,  81.68 ],
  [ 85,  84.32 ],
  [ 90,  89.32 ],
  [ 95,  94.32 ],
  [ 100, 99.32 ],
]);

// maximum diameter of dMaj range used for threaded rods
function rod_maj_lookup_max(m) = lookup(m, [
  [ 2,   1.981 ],
  [ 2.2, 2.18  ],
  [ 2.3, 2.28  ],
  [ 2.5, 2.48  ],
  [ 2.6, 2.58  ],
  [ 3,   2.98  ],
  [ 3.5, 3.479 ],
  [ 4,   3.978 ],
  [ 4.5, 4.478 ],
  [ 5,   4.976 ],
  [ 5.5, 5.48  ],
  [ 6,   5.974 ],
  [ 7,   6.974 ],
  [ 8,   7.972 ],
  [ 9,   8.972 ],
  [ 10,  9.968 ],
  [ 11,  10.97 ],
  [ 12,  11.97 ],
  [ 14,  13.96 ],
  [ 15,  14.97 ],
  [ 16,  15.96 ],
  [ 17,  16.97 ],
  [ 18,  17.96 ],
  [ 20,  19.96 ],
  [ 22,  21.95 ],
  [ 24,  23.95 ],
  [ 25,  24.96 ],
  [ 26,  25.97 ],
  [ 27,  26.95 ],
  [ 28,  27.96 ],
  [ 30,  29.95 ],
  [ 32,  31.96 ],
  [ 33,  32.97 ],
  [ 35,  34.97 ],
  [ 36,  35.94 ],
  [ 38,  37.97 ],
  [ 39,  38.94 ],
  [ 40,  39.95 ],
  [ 42,  41.94 ],
  [ 45,  44.94 ],
  [ 48,  47.93 ],
  [ 50,  49.94 ],
  [ 52,  51.93 ],
  [ 55,  54.94 ],
  [ 56,  55.93 ],
  [ 58,  57.94 ],
  [ 60,  59.93 ],
  [ 62,  61.94 ],
  [ 63,  62.97 ],
  [ 64,  63.92 ],
  [ 65,  64.94 ],
  [ 68,  67.92 ],
  [ 70,  69.92 ],
  [ 72,  71.92 ],
  [ 75,  74.92 ],
  [ 76,  75.92 ],
  [ 78,  77.96 ],
  [ 80,  79.92 ],
  [ 82,  81.96 ],
  [ 85,  84.92 ],
  [ 90,  89.92 ],
  [ 95,  94.92 ],
  [ 100, 99.92 ],
]);

// minimum diameter of dMaj range used for taps
function tap_maj_lookup_min(m) = lookup(m, [
  [ 2,   2   ],
  [ 2.2, 2.2 ],
  [ 2.3, 2.3 ],
  [ 2.5, 2.5 ],
  [ 2.6, 2.6 ],
  [ 3,   3   ],
  [ 3.5, 3.5 ],
  [ 4,   4   ],
  [ 4.5, 4.5 ],
  [ 5,   5   ],
  [ 5.5, 5.5 ],
  [ 6,   6   ],
  [ 7,   7   ],
  [ 8,   8   ],
  [ 9,   9   ],
  [ 10,  10  ],
  [ 11,  11  ],
  [ 12,  12  ],
  [ 14,  14  ],
  [ 15,  15  ],
  [ 16,  16  ],
  [ 17,  17  ],
  [ 18,  18  ],
  [ 20,  20  ],
  [ 22,  22  ],
  [ 24,  24  ],
  [ 25,  25  ],
  [ 26,  26  ],
  [ 27,  27  ],
  [ 28,  28  ],
  [ 30,  30  ],
  [ 32,  32  ],
  [ 33,  33  ],
  [ 35,  35  ],
  [ 36,  36  ],
  [ 38,  38  ],
  [ 39,  39  ],
  [ 40,  40  ],
  [ 42,  42  ],
  [ 45,  45  ],
  [ 48,  48  ],
  [ 50,  50  ],
  [ 52,  52  ],
  [ 55,  55  ],
  [ 56,  56  ],
  [ 58,  58  ],
  [ 60,  60  ],
  [ 62,  62  ],
  [ 63,  63  ],
  [ 64,  64  ],
  [ 65,  65  ],
  [ 68,  68  ],
  [ 70,  70  ],
  [ 72,  72  ],
  [ 75,  75  ],
  [ 76,  76  ],
  [ 78,  78  ],
  [ 80,  80  ],
  [ 82,  82  ],
  [ 85,  85  ],
  [ 90,  90  ],
  [ 95,  95  ],
  [ 100, 100 ],
]);

// maximum diameter of dMaj range used for taps
function tap_maj_lookup_max(m) = lookup(m, [
  [ 2,   2.148  ],
  [ 2.2, 2.36   ],
  [ 2.3, 2.46   ],
  [ 2.5, 2.66   ],
  [ 2.6, 2.75   ],
  [ 3,   3.172  ],
  [ 3.5, 3.699  ],
  [ 4,   4.219  ],
  [ 4.5, 4.726  ],
  [ 5,   5.24   ],
  [ 5.5, 5.692  ],
  [ 6,   6.294  ],
  [ 7,   7.294  ],
  [ 8,   8.34   ],
  [ 9,   9.34   ],
  [ 10,  10.396 ],
  [ 11,  11.387 ],
  [ 12,  12.453 ],
  [ 14,  14.501 ],
  [ 15,  15.407 ],
  [ 16,  16.501 ],
  [ 17,  17.407 ],
  [ 18,  18.585 ],
  [ 20,  20.585 ],
  [ 22,  22.677 ],
  [ 24,  24.698 ],
  [ 25,  25.513 ],
  [ 26,  26.417 ],
  [ 27,  27.698 ],
  [ 28,  28.513 ],
  [ 30,  30.785 ],
  [ 32,  32.513 ],
  [ 33,  33.785 ],
  [ 35,  35.416 ],
  [ 36,  36.877 ],
  [ 38,  38.417 ],
  [ 39,  39.877 ],
  [ 40,  40.698 ],
  [ 42,  42.965 ],
  [ 45,  45.965 ],
  [ 48,  49.057 ],
  [ 50,  50.892 ],
  [ 52,  53.037 ],
  [ 55,  55.892 ],
  [ 56,  57.149 ],
  [ 58,  58.892 ],
  [ 60,  61.149 ],
  [ 62,  62.892 ],
  [ 63,  63.429 ],
  [ 64,  65.421 ],
  [ 65,  65.892 ],
  [ 68,  69.241 ],
  [ 70,  71.241 ],
  [ 72,  73.241 ],
  [ 75,  76.241 ],
  [ 76,  77.241 ],
  [ 78,  78.525 ],
  [ 80,  81.241 ],
  [ 82,  82.525 ],
  [ 85,  86.241 ],
  [ 90,  91.241 ],
  [ 95,  96.266 ],
  [ 100, 101.27 ],
]);

// https://amesweb.info/Fasteners/Nut/Metric-Hex-Nut-Sizes-Dimensions-Chart.aspx
// missing made up by me to match next biggest known
function hex_head_lookup(m) = lookup(m, [
  [ 2,   4 ],
  [ 2.2, 4 ],
  [ 2.3, 4 ],
  [ 2.5, 5 ],
  [ 2.6, 5 ],
  [ 3,   5.5 ],
  [ 3.5, 6 ],
  [ 4,   7 ],
  [ 4.5, 7 ],
  [ 5,   8 ],
  [ 5.5, 8 ],
  [ 6,   10 ],
  [ 7,   12 ],
  [ 8,   13 ],
  [ 9,   14 ],
  [ 10,  16 ],
  [ 11,  16 ],
  [ 12,  18 ],
  [ 14,  21 ],
  [ 15,  22 ],
  [ 16,  24 ],
  [ 17,  24 ],
  [ 18,  27 ],
  [ 20,  30 ],
  [ 22,  34 ],
  [ 24,  36 ],
  [ 25,  40 ],
  [ 26,  40 ],
  [ 27,  41 ],
  [ 28,  46 ],
  [ 30,  46 ],
  [ 32,  50 ],
  [ 33,  50 ],
  [ 35,  55 ],
  [ 36,  55 ],
  [ 38,  60 ],
  [ 39,  60 ],
  [ 40,  65 ],
  [ 42,  65 ],
  [ 45,  70 ],
  [ 48,  75 ],
  [ 50,  80 ],
  [ 52,  80 ],
  [ 55,  85 ],
  [ 56,  85 ],
  [ 58,  90 ],
  [ 60,  90 ],
  [ 62,  95 ],
  [ 63,  95 ],
  [ 64,  95 ],
  [ 65,  100 ],
  [ 68,  100 ],
  [ 70,  100 ],
  [ 72,  110 ],
  [ 75,  110 ],
  [ 76,  110 ],
  [ 78,  120 ],
  [ 80,  120 ],
  [ 82,  120 ],
  [ 85,  130 ],
  [ 90,  130 ],
  [ 95,  130 ],
  [ 100, 140 ],
]);
