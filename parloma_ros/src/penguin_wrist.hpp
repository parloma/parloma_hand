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

// This is the class to perform invese kinematics of the Wrist
// used in the parloma hand


#ifndef PENGUIN_WRIST_HPP
#define PENGUIN_WRIST_HPP

#include <Eigen/Core>

class PenguinWrist {
  private:
    double _solve_up();
    double _solve_middle();
    double _solve_down();
    void _init_constants();
    double _deg2rad(double ang);
    void _solve();

  public:
    PenguinWrist();
    ~PenguinWrist();

    void set_rpy(double r, double p, double y);
    void set_rpy(Eigen::Vector3d);
    Eigen::Vector3d get_solution();

  private:
    /* Variables */

    double _A, _B, _C, _D, _E, _F, _H, _I, _L, _M, _N, _O, _P, _R;
    double _l1a, _l2a, _psi, _rl2;
    Eigen::Vector3d _centerXY, _p4;
    Eigen::Vector3d _RPY;
    Eigen::Vector3d _sols;
};

#endif
