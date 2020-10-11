//
// Copyright: Copyright (c) MOSEK ApS, Denmark. All rights reserved.
//
//  File:     alan.cc
//
//  Purpose: This file contains an implementation of the alan.gms (as
//  found in the GAMS online model collection) using Fusion.
//
//  The model is a simple portfolio choice model. The objective is to
//  invest in a number of assets such that we minimize the risk, while
//  requiring a certain expected return.
//
//  We operate with 4 assets (hardware,software, show-biz and treasure
//  bill). The risk is defined by the covariance matrix
//    Q = [[  4.0, 3.0, -1.0, 0.0 ],
//         [  3.0, 6.0,  1.0, 0.0 ],
//         [ -1.0, 1.0, 10.0, 0.0 ],
//         [  0.0, 0.0,  0.0, 0.0 ]]
//
//
//  We use the form Q = U^T * U, where U is a Cholesky factor of Q.
//

#include <iostream>
#include "monty.h"
#include "fusion.h"

using namespace mosek::fusion;
using namespace monty;

// Security names
std::string securities[] =          { "hardware", "software", "show-biz", "t-bills" };
// Two examples of mean returns on securities
auto mean1 = new_array_ptr<double, 1>({       8.0,        9.0,       12.0,       7.0 });
auto mean2 = new_array_ptr<double, 1>({       9.0,        7.0,       11.0,       5.0 });  
// Target mean return
double target = 10.0;

int numsec = 4;

// Factor of covariance matrix.
auto U = new_array_ptr<double, 2>(
{ { 2.0       ,  1.5       , -0.5       , 0.0 },
  { 0.0       ,  1.93649167,  0.90369611, 0.0 },
  { 0.0       ,  0.0       ,  2.98886824, 0.0 },
  { 0.0       ,  0.0       ,  0.0       , 0.0 }
});

// Solve an instance with given expected return
void solve(Model::t M, 
           Parameter::t mean, 
           Variable::t x, 
           std::shared_ptr<ndarray<double,1>> meanVal) {
  
  std::cout << "Solve with mean = " << std::endl;
  for (int i = 0; i < numsec; ++i)
    std::cout << "  " << securities[i] << " : " << (*meanVal)[i] << std::endl;

  mean->setValue(meanVal);
  M->solve();

  auto solx = x->level();

  std::cout << "Solution = " << std::endl;
  for (int i = 0; i < numsec; ++i)
    std::cout << "  " << securities[i] << " : " << (*solx)[i] << std::endl;
}


int main(int argc, char ** argv)
{
  // Create a parametrized model
  Model::t M = new Model("alan"); auto _M = finally([&]() { M->dispose(); });
  //M->setLogHandler([](const std::string & msg) { std::cout << msg << std::flush; } );

  Variable::t x = M->variable("x", numsec, Domain::greaterThan(0.0));
  Variable::t t = M->variable("t", 1,      Domain::greaterThan(0.0));
  
  M->objective("minvar", ObjectiveSense::Minimize, t);

  // sum securities to 1.0
  M->constraint("wealth",  Expr::sum(x), Domain::equalsTo(1.0));
  // define target expected return
  Parameter::t mean = M->parameter(numsec);
  M->constraint("dmean", Expr::dot(mean, x), Domain::greaterThan(target));

  M->constraint("t > ||Ux||^2", Expr::vstack(0.5, t, Expr::mul(U, x)), Domain::inRotatedQCone());

  // Solve two instances of the problem
  solve(M, mean, x, mean1);
  solve(M, mean, x, mean2);

  return 0;
}