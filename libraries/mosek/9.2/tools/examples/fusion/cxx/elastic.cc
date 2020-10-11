// Copyright: Copyright (c) MOSEK ApS, Denmark. All rights reserved.
//
// File:      elastic.cc
//
// Purpose: Demonstrates model parametrization on the example of an elastic net linear regression:
//
//          min_x  |Ax-b|_2 + lambda1*|x|_1 + lambda2*|x|_2

#include <iostream>
#include "fusion.h"

using namespace mosek::fusion;
using namespace monty;

// Construct the model with parameters b, lambda1, lambda2
// and with prescribed matrix A
Model::t initializeModel(int m, int n, std::shared_ptr<ndarray<double,2>> A) {
  Model::t M = new Model(); 
  auto x = M->variable("x", n);

  // t >= |Ax-b|_2 where b is a parameter
  auto b = M->parameter("b", m);
  auto t = M->variable();
  M->constraint(Expr::vstack(t, Expr::sub(Expr::mul(A, x), b)), Domain::inQCone());

  // p_i >= |x_i|, i=1..n
  auto p = M->variable(n);
  M->constraint(Expr::hstack(p, x), Domain::inQCone());

  // q >= |x|_2
  auto q = M->variable();
  M->constraint(Expr::vstack(q, x), Domain::inQCone());

  // Objective, parametrized with lambda1, lambda2
  // t + lambda1*sum(p) + lambda2*q
  auto lambda1 = M->parameter("lambda1");
  auto lambda2 = M->parameter("lambda2");
  auto obj = Expr::add(new_array_ptr<Expression::t, 1>({t, Expr::mul(lambda1, Expr::sum(p)), Expr::mul(lambda2, q)}));
  M->objective(ObjectiveSense::Minimize, obj);

  // Return the ready model
  return M;
}

int smallExample() {
  //Create a small example
  int m = 4;
  int n = 2;
  auto A = new_array_ptr<double, 2>(
                { {1.0,   2.0},
                  {3.0,   4.0},
                  {-2.0, -1.0},
                  {-4.0, -3.0} });

  auto M = initializeModel(m, n, A);

  // For convenience retrieve some elements of the model
  auto b = M->getParameter("b");
  auto lambda1 = M->getParameter("lambda1");
  auto lambda2 = M->getParameter("lambda2");
  auto x = M->getVariable("x");

  // First solve
  b->setValue(new_array_ptr<double, 1>({0.1, 1.2, -1.1, 3.0}));
  lambda1->setValue(0.1);
  lambda2->setValue(0.01);

  M->solve();
  auto sol = x->level();
  std::cout << "Objective " << M->primalObjValue() << ", solution " << (*sol)[0] << ", " << (*sol)[1] << "\n";

  // Increase lambda1
  lambda1->setValue(0.5);
  
  M->solve();
  sol = x->level();
  std::cout << "Objective " << M->primalObjValue() << ", solution " << (*sol)[0] << ", " << (*sol)[1] << "\n";

  // Now change the data completely
  b->setValue(new_array_ptr<double, 1>({1.0, 1.0, 1.0, 1.0}));
  lambda1->setValue(0.0);
  lambda2->setValue(0.0);
  
  M->solve();
  sol = x->level();
  std::cout << "Objective " << M->primalObjValue() << ", solution " << (*sol)[0] << ", " << (*sol)[1] << "\n";

  // And increase lamda2
  lambda2->setValue(1.4145);
  
  M->solve();
  sol = x->level();
  std::cout << "Objective " << M->primalObjValue() << ", solution " << (*sol)[0] << ", " << (*sol)[1] << "\n";

  M->dispose();
  return 0;
}

int main() {
  return smallExample();
}
