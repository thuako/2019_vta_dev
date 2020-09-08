// 67d7842dbbe25473c3c32b93c0da8047785f30d78e8a024de1b57352245f9689
#include "ap_int.h"

typedef ap_int<8> inp_T;

/* \typedef wgt_T Weight datatype*/
typedef ap_int<8> wgt_T;

/* \typedef acc_T Accumulator datatype*/
typedef ap_int<32> acc_T;

//--------------------------------------------------------
void rtl_model(inp_T  a0, inp_T  a1, inp_T  a2, inp_T  a3, 
                wgt_T  b0, wgt_T  b1, wgt_T  b2, wgt_T  b3,
                acc_T acc_in, acc_T & acc_out)
{
#pragma HLS inline off
  acc_out= a0*b0 + a1*b1 +a2*b2 +a3*b3 + acc_in;
}
