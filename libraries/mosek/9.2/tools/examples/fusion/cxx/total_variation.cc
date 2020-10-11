//
// Copyright: Copyright (c) MOSEK ApS, Denmark. All rights reserved.
//
// File:      total_variation.cc
//
// Purpose:   Demonstrates how to solve a total
//            variation problem using the Fusion API.

#include <iostream>
#include <vector>
#include <random>

#include "monty.h"
#include "fusion.h"

using namespace mosek::fusion;
using namespace monty;

Model::t total_var(int n, int m) {
  Model::t M = new Model("TV");

  Variable::t u = M->variable("u", new_array_ptr<int, 1>({n + 1, m + 1}), Domain::inRange(0.0, 1.0));
  Variable::t t = M->variable("t", new_array_ptr<int, 1>({n, m}), Domain::unbounded());

  // In this example we define sigma and the input image f as parameters
  // to demonstrate how to solve the same model with many data variants.
  // Of course they could simply be passed as ordinary arrays if that is not needed.
  Parameter::t sigma = M->parameter("sigma");
  Parameter::t f = M->parameter("f", n, m);

  Variable::t ucore = u->slice(new_array_ptr<int, 1>({0, 0}), new_array_ptr<int, 1>({n, m}));

  Expression::t deltax = Expr::sub( u->slice( new_array_ptr<int, 1>({1, 0}), new_array_ptr<int, 1>({n + 1, m}) ), ucore );
  Expression::t deltay = Expr::sub( u->slice( new_array_ptr<int, 1>({0, 1}), new_array_ptr<int, 1>({n, m + 1}) ), ucore );

  M->constraint( Expr::stack(2, t, deltax, deltay), Domain::inQCone()->axis(2) );

  M->constraint( Expr::vstack(sigma, Expr::flatten( Expr::sub(f,  ucore) ) ),
                 Domain::inQCone() );

  M->objective( ObjectiveSense::Minimize, Expr::sum(t) );

  return M;
}

int main(int argc, char ** argv)
{
  std::normal_distribution<double>       ndistr(0., 1.);
  std::mt19937 engine(0);

  int n = 100;
  int m = 200;
  std::vector<double> sigmas({ 0.0004, 0.0005, 0.0006 });

  // Create a parametrized model with given shape
  Model::t M = total_var(n, m);
  Parameter::t sigma = M->getParameter("sigma");
  Parameter::t f     = M->getParameter("f");
  Variable::t  ucore = M->getVariable("u")->slice(new_array_ptr<int, 1>({0, 0}), new_array_ptr<int, 1>({n, m}));

  // Example: Linear signal with Gaussian noise    
  std::vector<std::vector<double>> signal(n, std::vector<double>(m));
  std::vector<std::vector<double>> noise(n, std::vector<double>(m));
  std::vector<std::vector<double>> fVal(n, std::vector<double>(m));
  std::vector<std::vector<double>> sol(n, std::vector<double>(m));

  for(int i=0; i<n; i++) for(int j=0; j<m; j++) {
    signal[i][j] = 1.0*(i+j)/(n+m);
    noise[i][j] = ndistr(engine) * 0.08;
    fVal[i][j] = std::max( std::min(1.0, signal[i][j] + noise[i][j]), .0 );
  }
 
  // Set value for f
  f->setValue(new_array_ptr(fVal));

  for(int iter=0; iter<3; iter++) {
    // Set new value for sigma and solve
    sigma->setValue(sigmas[iter]*n*m);

    M->solve();

    // Retrieve solution from ucore
    auto ucoreLev = *(ucore->level());
    for(int i=0; i<n; i++) for(int j=0; j<m; j++)
      sol[i][j] = ucoreLev[i*n+m];

    // Use the solution
    // ...

    std::cout << "rel_sigma = " << sigmas[iter] << " total_var = " << M->primalObjValue() << std::endl;
  }

  M->dispose();

  return 0;
}