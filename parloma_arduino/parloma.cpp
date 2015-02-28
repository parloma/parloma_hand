/* Copyright (C) 2014 Politecnico di Torino


This program is free software; you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation; either version 2 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License along
with this program; if not, write to the Free Software Foundation, Inc.,
51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.

Contributors:
  Ludovico O. Russo (ludovico.russo@polito.it)
*/

// Includes required to servos
#include <Wire.h>
#include <Adafruit_PWMServoDriver.h>

// ROS
#include <ros.h>
#include <penguin_ros/penguin.h>

ros::NodeHandle node;
penguin_ros::penguin p_msg;

Adafruit_PWMServoDriver pwm = Adafruit_PWMServoDriver();


// Servo Positions
const int servo_up = 8, servo_down = 10, servo_middle = 9;
const int thumb_ad = 0, index_ad = 1, middle_ad = 2;
const int thumb = 4, index = 7, middle = 3, ring = 5, pinky = 6;

// Reimplement the function if you use a different way to control servos,
// such as Arduino Servo Library
void init_servo() {
  pwm.begin();
  pwm.setPWMFreq(60);  // Analog servos run at ~60 Hz updates
}

// Reimplement the function if you use a different way to control servos,
// such as Arduino Servo Library
void write_pose(int servo, int pos) {
  uint16_t val = map(pos, 0, 180, 150, 600);
  pwm.setPWM(servo, 0, val);
}


void penguin_cb(const penguin_ros::penguin & msg) {
  // wrist 
  int cmd_up =       (int)msg.up              * 2   + 90 ;
  int cmd_middle =  ((int)msg.mid + 120  ) * 2   + 90 ;
  int cmd_down =    ((int)msg.down   - 120  ) * 2   + 90 ;

  // fingers
  write_pose(servo_up, cmd_up);
  write_pose(servo_middle, cmd_middle);
  write_pose(servo_down, cmd_down);
  write_pose(thumb, (msg.thumb>150?150:msg.thumb)); // Thumb Protection
  write_pose(index, msg.index);
  write_pose(middle, msg.middle);
  write_pose(ring, msg.ring);
  write_pose(pinky, 180 - msg.pinky);
  write_pose(thumb_ad, msg.thumb_ad);
  write_pose(index_ad, msg.index_ad);
  write_pose(middle_ad, msg.middle_ad);
}

ros::Subscriber<penguin_ros::penguin> sub("penguin_msgs", &penguin_cb);

void setup () {
  init_servo();
  node.initNode();
  node.subscribe(sub);
}

void loop() {
  node.spinOnce();
  delay(1);
}
