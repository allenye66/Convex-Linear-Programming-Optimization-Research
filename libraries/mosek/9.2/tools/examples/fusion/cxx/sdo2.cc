/*
   Copyright : Copyright (c) MOSEK ApS, Denmark. All rights reserved.
 
   File :      sdo2.cc
 
   Purpose :   Solves the semidefinite problem with two symmetric variables:
 
                  min   <C1,X1> + <C2,X2>
                  st.   <A1,X1> + <A2,X2> = b
                              (X2)_{1,2} <= k
                 
                  where X1, X2 are symmetric positive semidefinite,
 
                  C1, C2, A1, A2 are assumed to be constant symmetric matrices,
                  and b, k are constants.
*/
#include <iostream>
#include "fusion.h"

using namespace mosek::fusion;
using namespace monty;

std::shared_ptr<ndarray<int,1>>    nint(const std::vector<int> &X)    { return new_array_ptr<int>(X); }
std::shared_ptr<ndarray<double,1>> ndou(const std::vector<double> &X) { return new_array_ptr<double>(X); }

int main(int argc, char ** argv)
{
    // Sample data in sparse, symmetric triplet format
    std::vector<int>    C1_k = {0, 2};
    std::vector<int>    C1_l = {0, 2};
    std::vector<double> C1_v = {1, 6};
    std::vector<int>    A1_k = {0, 2, 0, 2};
    std::vector<int>    A1_l = {0, 0, 2, 2};
    std::vector<double> A1_v = {1, 1, 1, 2};
    std::vector<int>    C2_k = {0, 1, 0, 1, 2};
    std::vector<int>    C2_l = {0, 0, 1, 1, 2};
    std::vector<double> C2_v = {1, -3, -3, 2, 1};
    std::vector<int>    A2_k = {1, 0, 1, 3};
    std::vector<int>    A2_l = {0, 1, 1, 3};
    std::vector<double> A2_v = {1, 1, -1, -3};
    double b = 23;
    double k = -3;

    // Convert input data into Fusion sparse matrices
    auto C1 = Matrix::sparse(3, 3, nint(C1_k), nint(C1_l), ndou(C1_v));
    auto C2 = Matrix::sparse(4, 4, nint(C2_k), nint(C2_l), ndou(C2_v));
    auto A1 = Matrix::sparse(3, 3, nint(A1_k), nint(A1_l), ndou(A1_v));
    auto A2 = Matrix::sparse(4, 4, nint(A2_k), nint(A2_l), ndou(A2_v));

    // Create model
    Model::t M = new Model("sdo2"); auto _M = finally([&]() { M->dispose(); });

    // Two semidefinite variables
    auto X1 = M->variable(Domain::inPSDCone(3));
    auto X2 = M->variable(Domain::inPSDCone(4));

    // Objective
    M->objective(ObjectiveSense::Minimize, Expr::add(Expr::dot(C1,X1), Expr::dot(C2,X2)));

    // Equality constraint
    M->constraint(Expr::add(Expr::dot(A1,X1), Expr::dot(A2,X2)), Domain::equalsTo(b));

    // Inequality constraint
    M->constraint(X2->index(nint({0,1})), Domain::lessThan(k));

    // Solve
    M->setLogHandler([ = ](const std::string & msg) { std::cout << msg << std::flush; } );
    M->solve();

    // Retrieve solution
    std::cout << "Solution (vectorized) : " << std::endl;
    std::cout << "  X1 = " << *(X1->level()) << std::endl;
    std::cout << "  X2 = " << *(X2->level()) << std::endl;

    return 0;
}