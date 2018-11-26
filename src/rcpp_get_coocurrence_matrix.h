#ifndef GET_COOCURRENCE_MATRIX_H
#define GET_COOCURRENCE_MATRIX_H
#include <RcppArmadillo.h>
using namespace Rcpp;

// [[Rcpp::depends(RcppArmadillo)]]
// [[Rcpp::plugins(cpp11)]]

IntegerMatrix rcpp_get_coocurrence_matrix(const IntegerMatrix x,
                                          const arma::imat directions);

std::map<int, unsigned> get_patches_map(const std::vector<int> &classes);

#endif // GET_COOCURRENCE_MATRIX_H
