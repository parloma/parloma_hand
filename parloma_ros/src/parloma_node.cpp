#include "ros/ros.h"
#include <penguin_ros/penguin.h>
#include "penguin_wrist.hpp"
#include "math.h"
#include <fstream>
#include <sstream>

using namespace std;



int main(int argc, char **argv)
{
  if (argc != 2) {
    std::cout << "Usage: " << argv[0] << " roll pitch yaw" << std::endl;
    return 0;
  }

  ifstream poses;
  poses.open(argv[1], std::fstream::out);



  PenguinWrist penguin;

  ros::init(argc, argv, "penguin");
  ros::NodeHandle n;
  ros::Publisher pub = n.advertise<penguin_ros::penguin>("penguin_msgs", 1000);

  ros::Rate loop_rate(30);


  float r = 0, p = 0, y = 0;
  int i = 0;
  while (ros::ok() && !poses.eof()){

    string s;
    getline(poses, s);
    stringstream ss(s);

    double ts, r, p,t, thumb, index, middle, ring, pinky, t_ad, i_ad, m_ad;
    ss >> ts >> r >> p >>t >> thumb >> index >> middle >> ring >> pinky >> t_ad >> i_ad >> m_ad;
    std::cout << ss.str() << endl;
    std::cout << ts << endl << r<< endl  << p<< endl  << t << endl << thumb << endl << index << endl << middle << endl << ring << endl << pinky<< endl<< endl  ;

    penguin_ros::penguin msg;

    msg.thumb   = ( thumb   + 30) / (80.0f-(-30))*180;
    msg.index   = ( index   + 0*17.5) / (95.0f-(-2*17.5))*180;
    msg.middle  = msg.index; // ( middle  + 0*17.5) / (95.0f-(-2*17.5))*180;
    msg.ring    = 180 ;// ( ring    + 17.5) / (95.0f-(-17.5))*180;
    msg.pinky   = 180 ; //( pinky   + 17.5) / (95.0f-(-17.5))*180 + 50;






    y = 20*sin(0.1*i++)*M_PI/180;
    /* penguin.set_rpy(r,p,y); */
    /* std::cout << penguin.get_solution().transpose()*180/M_PI << std::endl; */
    /* msg.up = penguin.get_solution()(0)*180/M_PI; */
    /* msg.middle = penguin.get_solution()(1)*180/M_PI; */
    /* msg.down = penguin.get_solution()(2)*180/M_PI; */


    pub.publish(msg);
    ros::spinOnce();
    loop_rate.sleep();
  }
return 0;
}
