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
        Giorgio Toscana (giorgio.toscana@polito.it)
*/



#include "penguin_wrist.hpp"
#include <math.h>
#include <vector>


PenguinWrist::~PenguinWrist()
{
}

Eigen::Vector3d PenguinWrist::get_solution()
{
  return _sols;
}

void PenguinWrist::set_rpy(double r, double p, double y)
{
  _RPY << r, p, y;
  _solve();
}

void PenguinWrist::set_rpy(Eigen::Vector3d RPY)
{
  _RPY = RPY;
  _solve();
}

void PenguinWrist::_solve()
{
  _init_constants();
  _sols(0) = _solve_up();
  _sols(1) = _solve_middle();
  _sols(2) = _solve_down();
}


double PenguinWrist::_deg2rad(double ang)
{
  return ang/180.0f*M_PI;
}

void PenguinWrist::_init_constants()
{

  _A = _centerXY(2) - _p4(2);
  _B = _rl2*sin(_RPY(1));
  _C = _rl2*cos(_RPY(1))*cos(_RPY(0));

  _D = _l1a-_l2a*cos(_psi);
  _E = _rl2*(cos(_RPY(2))*sin(_RPY(0)) - cos(_RPY(0))*sin(_RPY(1))*sin(_RPY(2)));
  _F = _rl2*cos(_RPY(1))*sin(_RPY(2));

  _H = _rl2*(sin(_RPY(0))*sin(_RPY(2)) + cos(_RPY(0))*cos(_RPY(2))*sin(_RPY(1)));
  _I = _rl2*cos(_RPY(1))*cos(_RPY(2));
  _L = _rl2*(sin(_RPY(1))/2 - (sqrt(3)*cos(_RPY(1))*sin(_RPY(0)))/2);

  _M = _rl2*((cos(_RPY(1))*sin(_RPY(2)))/2 + (sqrt(3)*(cos(_RPY(0))*cos(_RPY(2)) + sin(_RPY(1))*sin(_RPY(0))*sin(_RPY(2))))/2);
  _N = _rl2*((cos(_RPY(1))*cos(_RPY(2)))/2 - (sqrt(3)*(cos(_RPY(0))*sin(_RPY(2)) - cos(_RPY(2))*sin(_RPY(1))*sin(_RPY(0))))/2);
  _O = _rl2*(sin(_RPY(1))/2 + (sqrt(3)*cos(_RPY(1))*sin(_RPY(0)))/2);
  _P = _rl2*((cos(_RPY(1))*sin(_RPY(2)))/2 - (sqrt(3)*(cos(_RPY(0))*cos(_RPY(2)) + sin(_RPY(1))*sin(_RPY(0))*sin(_RPY(2))))/2);
  _R = _rl2*((cos(_RPY(1))*cos(_RPY(2)))/2 + (sqrt(3)*(cos(_RPY(0))*sin(_RPY(2)) - cos(_RPY(2))*sin(_RPY(1))*sin(_RPY(0))))/2);

}

PenguinWrist::PenguinWrist()
{
  _p4 << 0, 0, 36.57;
  _l1a = 19.33;
  _l2a = 22.01;
  _psi = _deg2rad(120);
  _centerXY << 0,0,19.06;
  _rl2 = 35.03;

  set_rpy(0,0,0);
}


double PenguinWrist::_solve_down()
{
  if (-_A*_A + _O*_O + _C*_C < 0.0f) {
    // TO DO: Generate Exception
    exit(EXIT_FAILURE);
  }
  std::vector< double > st3_down;
  double yplus = (_O + sqrt(- _A*_A + _O*_O + _C*_C));
  double yminus = (_O - sqrt(- _A*_A + _O*_O + _C*_C));
  double x = _A + _C;




  if (  ( yplus != 0) && (x != 0) ) {
    st3_down.push_back(2*atan2(yplus,x));
  }

  if (  (yminus != 0) && (x != 0) ) {
    st3_down.push_back(2*atan2(yminus,x));
  }

  /* Solve for t1 alto: eq 1 and 2: */
  /* eq2alto = E*cos(t3) + D*sin(t1) - F*sin(t3) */ 
  /* eq1alto = D*cos(t1) - H*cos(t3) - I*sin(t3) */
  /* Combination to avoid asin and acos but using atan2 */

  /*            -E*cos(t3) + F*sin(t3) */
  /*  tan(t1) = ---------------------- */
  /*            H*cos(t3) + I*sin(t3) */


  double y1 = -_E*cos(st3_down[0]) - _P*sin(st3_down[0]);
  double x1 = _H*cos(st3_down[0]) - _R*sin(st3_down[0]);

  double y2 = -_E*cos(st3_down[1]) - _P*sin(st3_down[1]);
  double x2 = _H*cos(st3_down[1]) - _R*sin(st3_down[1]);



  std::vector< double > st1_down_sols;


  if(st3_down.size() == 2) {

    if ( ( y1 !=0) || ( x1 != 0) ) {
      st1_down_sols.push_back(atan2( y1, x1 ));
    }

    if ( ( y2 !=0) || ( x2 != 0) ) {
      st1_down_sols.push_back(atan2( y2, x2 ));
    }

    if(st1_down_sols.size() == 0){
      // TO DO: Generate Exception
      exit(EXIT_FAILURE);

    }

  } else if(st3_down.size()==1) {
    if ( ( y1 !=0 ) || ( x1 != 0) ) {
      st1_down_sols.push_back(atan2( y1, x1 ));
    } else {
      /* %disp('atan2(0,0) Undefined...NO IK Available...Quit() !!! '); */
      // TO DO: Generate Exception
      exit(EXIT_FAILURE);
    }
  } else {
    /* %disp('found No solutions for t3 alto...quit!!') */
    // TO DO: Generate Exception
    exit(EXIT_FAILURE);
  }
  return ( fabs(st1_down_sols[0]-(2.0f/3)*M_PI) < fabs(st1_down_sols[1]-(2.0f/3)) ? st1_down_sols[0]: st1_down_sols[1]);

}

double PenguinWrist::_solve_middle()
{
  if (-_A*_A + _L*_L + _C*_C < 0.0f) {
    // TO DO: Generate Exception
    exit(EXIT_FAILURE);
  }
  std::vector< double > st3_middle;
  double yplus = (_L + sqrt(- _A*_A + _L*_L + _C*_C));
  double yminus = (_L - sqrt(- _A*_A + _L*_L + _C*_C));
  double x = _A + _C;




  if (  ( yplus != 0) && (x != 0) ) {
    st3_middle.push_back(-2*atan2(yplus,x));
  }

  if (  (yminus != 0) && (x != 0) ) {
    st3_middle.push_back(-2*atan2(yminus,x));
  }

  double y1 = -_E*cos(st3_middle[0]) + _M*sin(st3_middle[0]);
  double x1 = _H*cos(st3_middle[0]) + _N*sin(st3_middle[0]);

  double y2 = -_E*cos(st3_middle[1]) + _M*sin(st3_middle[1]);
  double x2 = _H*cos(st3_middle[1]) + _N*sin(st3_middle[1]);



  std::vector< double > st1_middle_sols;


  if(st3_middle.size() == 2) {

    if ( ( y1 !=0) || ( x1 != 0) ) {
      st1_middle_sols.push_back(atan2( y1, x1 ));
    }

    if ( ( y2 !=0) || ( x2 != 0) ) {
      st1_middle_sols.push_back(atan2( y2, x2 ));
    }

    if(st1_middle_sols.size() == 0){
      // TO DO: Generate Exception
      exit(EXIT_FAILURE);

    }

  } else if(st3_middle.size()==1) {
    if ( ( y1 !=0 ) || ( x1 != 0) ) {
      st1_middle_sols.push_back(atan2( y1, x1 ));
    } else {
      /* %disp('atan2(0,0) Undefined...NO IK Available...Quit() !!! '); */
      // TO DO: Generate Exception
      exit(EXIT_FAILURE);
    }
  } else {
    /* %disp('found No solutions for t3 alto...quit!!') */
    // TO DO: Generate Exception
    exit(EXIT_FAILURE);
  }


  return ( (fabs(st1_middle_sols[0]-(-2.0f/3)*M_PI) < fabs(st1_middle_sols[1]-(-2.0f/3)*M_PI)) ? st1_middle_sols[0]: st1_middle_sols[1]);
}

  double PenguinWrist::_solve_up()
  {

    if (-_A*_A + _B*_B + _C*_C < 0.0f) {
      // TO DO: Generate Exception
      exit(EXIT_FAILURE);
    }

    std::vector< double > st3_up;
    double yplus = (_B + sqrt(- _A*_A + _B*_B + _C*_C));
    double yminus = (_B - sqrt(- _A*_A + _B*_B + _C*_C));
    double x = _A + _C;

    if (  ( yplus != 0) && (x != 0) ) {
      st3_up.push_back(-2*atan2(yplus,x));
    }

    if (  (yminus != 0) && (x != 0) ) {
      st3_up.push_back(-2*atan2(yminus,x));
    }

    double y1 = -_E*cos(st3_up[0]) + _F*sin(st3_up[0]);
    double x1 = _H*cos(st3_up[0]) + _I*sin(st3_up[0]);

    double y2 = -_E*cos(st3_up[1]) + _F*sin(st3_up[1]);
    double x2 = _H*cos(st3_up[1]) + _I*sin(st3_up[1]);



    std::vector< double > st1_up_sols;


    if(st3_up.size() == 2) {

      if ( ( y1 !=0) || ( x1 != 0) ) {
        st1_up_sols.push_back(atan2( y1, x1 ));
      }

      if ( ( y2 !=0) || ( x2 != 0) ) {
        st1_up_sols.push_back(atan2( y2, x2 ));
      }

      if(st1_up_sols.size() == 0){
        // TO DO: Generate Exception
        exit(EXIT_FAILURE);
      }

    } else if(st3_up.size()==1) {
      if ( ( y1 !=0 ) || ( x1 != 0) ) {
        st1_up_sols.push_back(atan2( y1, x1 ));
      } else {
        /* %disp('atan2(0,0) Undefined...NO IK Available...Quit() !!! '); */
        // TO DO: Generate Exception
        exit(EXIT_FAILURE);
      }
    } else {
      /* %disp('found No solutions for t3 alto...quit!!') */
      // TO DO: Generate Exception
      exit(EXIT_FAILURE);
    }


    return ( fabs(st1_up_sols[0]-0) < fabs(st1_up_sols[1]-0) ? st1_up_sols[0]: st1_up_sols[1]);
  }

