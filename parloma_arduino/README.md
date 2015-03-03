PARLOMA ARDUINO
===

This is the Arduino file to control the hand.
This software is based on the Adafruti 16 channel Servo Driver,
available at https://www.adafruit.com/product/815.

Moveover, it relies on the Rosserial ROS package http://wiki.ros.org/rosserial

Makefile
==

To use the attached Makefile to program the Arduino, please refer to 
https://github.com/WeAreLeka/Arduino-Makefile

You need also to edit the makefile in order to match your platform.
The makefile here attached has been test with Mac OS X (Mavericks).

Usage
==

- Install Rosserial
- copy/link parloma_hand/parloma_ros to <your ros workspace>/src
- run catkin_make
- follow the Arduino Setup (http://wiki.ros.org/rosserial_arduino/Tutorials/Arduino%20IDE%20Setup) to install export ros libs

