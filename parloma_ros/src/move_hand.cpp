/*
    Copyright (C) 2014 Politecnico di Torino


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


    This software is developed within the PARLOMA project, which aims
    at developing a communication system for deablinf people (www.parloma.com)
    The PARLOMA project is developed with the Turin node of AsTech laboraroies
    network of Italian CINI (Consorzio Interuniversitario Nazionale di Informatica)

    Contributors:
        Ludovico O. Russo (ludovico.russo@polito.it)
*/


#include "ros/ros.h"
#include <parloma_ros/parloma.h>
#include "penguin_wrist.hpp"
#include "math.h"

using namespace std;


int main(int argc, char **argv)
{
  PenguinWrist penguin;

  ros::init(argc, argv, "parloma_node");
  ros::NodeHandle n;
  ros::Publisher pub = n.advertise<parloma_ros::parloma>("parloma_msgs", 1000);

  ros::Rate loop_rate(30);


  float r = 0, p = 0, y = 0;
  int i = 0;
  while (ros::ok() ){

    parloma_ros::parloma msg;

    msg.thumb   =  atoi(argv[1]);
    msg.index   =  atoi(argv[2]);
    msg.middle  =  atoi(argv[3]);
    msg.ring    =  atoi(argv[4]);
    msg.pinky   =  atoi(argv[5]);


    penguin.set_rpy(atof(argv[7])*M_PI/180.0f, atof(argv[8])*M_PI/180.0f,atof(argv[9])*M_PI/180.0f );
    msg.up = penguin.get_solution()(0)*180/M_PI;
    msg.middle = penguin.get_solution()(1)*180/M_PI;
    msg.down = penguin.get_solution()(2)*180/M_PI;


    pub.publish(msg);
    ros::spinOnce();
    loop_rate.sleep();
  }
return 0;
}
