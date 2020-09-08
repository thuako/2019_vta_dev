// 67d7842dbbe25473c3c32b93c0da8047785f30d78e8a024de1b57352245f9689
#include "vta.h"
//--------------------------------------------------------
void rtl_model(inp_T  a, wgt_T  b, sum_T &rst)
{
#pragma HLS inline off
  mul_T tmp = a * b;
  rst += tmp;
}