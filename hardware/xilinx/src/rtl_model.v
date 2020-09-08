// 67d7842dbbe25473c3c32b93c0da8047785f30d78e8a024de1b57352245f9689
// This module describes SIMD Inference 
// 4 adders packed into single DSP block
`timescale 100ps/100ps

/*
(* use_dsp = "yes" *)
(* dont_touch = "1" *)  
module rtl_model (input            ap_clk, ap_rst, ap_ce, ap_start, ap_continue,
                  input [7:0]      a, b,
                  output           ap_idle, ap_done, ap_ready,
                  output           z_ap_vld,
                  output reg [20:0] z);

   wire ce = ap_ce;
   
   reg [7:0] areg, breg;
   reg       dly1;
   
   always @ (posedge ap_clk)
     if (ap_rst)
       begin
          z    <= 0;
          areg <= 0;
          breg <= 0;
          dly1  <= 0;
          dly2  <= 0;     
       end
     else if (ce)
       begin
          z    <= areg * breg + z;
          areg <= a;
          breg <= b;
          dly1  <= ap_start;
          dly2  <= dly1;          
       end

   assign z_ap_vld = dly2;
   assign ap_ready  = dly2;
   assign ap_done   = dly2;
   assign ap_idle   = ~ap_start;
      
endmodule // rtl_model
*/


(* use_dsp = "yes" *)
(* dont_touch = "1" *)  
module rtl_model (input            ap_clk, ap_rst, ap_ce, ap_start, ap_continue,
                  input [7:0]      a0,a1,a2,a3, b0,b1,b2,b3,
                  input [31:0]     acc_in,
                  output[31:0]     acc_out,
                  output           ap_idle, ap_done, ap_ready,
                  output           acc_ap_vld);

   wire ce = ap_ce;
   
   reg [7:0] areg0,areg1,areg2,areg3, breg0,breg1,breg2,breg3;
   reg [20:0] accreg;
   reg       dly1, dly2;
   
   always @ (posedge ap_clk)
     if (ap_rst)
       begin
          accreg <= 0;
          areg0 <= 0;
          breg0 <= 0;
          areg1 <= 0;
          breg1 <= 0;
          areg2 <= 0;
          breg2 <= 0;
          areg3 <= 0;
          breg3 <= 0;
          dly1  <= 0;
          dly2  <= 0;   
       end
     else if (ce)
       begin
          accreg <= acc_in;
          areg0 <= a0;
          breg0 <= b0;
          areg1 <= a1;
          breg1 <= b1;
          areg2 <= a2;
          breg2 <= b2;
          areg3 <= a3;
          breg3 <= b3;
          dly1  <= ap_start;
          dly2  <= dly1;    
       end
    
   assign acc_out = areg0*breg1 +areg0*breg1 +areg2*breg2 +areg3*breg3 + accreg;       
   
   assign acc_ap_vld = dly2;
   assign ap_ready  = dly2;
   assign ap_done   = dly2;
   assign ap_idle   = ~ap_start;
      
endmodule