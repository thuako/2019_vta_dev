// 67d7842dbbe25473c3c32b93c0da8047785f30d78e8a024de1b57352245f9689
// This module describes SIMD Inference 
// 4 adders packed into single DSP block
`timescale 100ps/100ps

(* use_dsp = "yes" *)
(* dont_touch = "1" *)  
module mul (input            ap_clk, ap_rst, ap_ce, ap_start, ap_continue,
                  input [7:0]      aaaa, bbbb,
                  output           ap_idle, ap_done, ap_ready,
                  output           rst_ap_vld,
                  output reg [20:0] rst);

   wire ce = ap_ce;
   
   reg [7:0] areg, breg;
   reg       dly1, dly2;
   
   always @ (posedge ap_clk)
     if (ap_rst)
       begin
          areg  <= 0;
          breg  <= 0;
          rst   <= 0;
          dly1  <= 0;
          dly2  <= 0;     
       end
     else if (ce)
       begin
          rst   <= areg * breg + rst;
          areg  <= aaaa;
          breg  <= bbbb;
          dly1  <= ap_start;
          dly2  <= dly1;          
       end

   assign rst_ap_vld = dly2;
   assign ap_ready  = dly2;
   assign ap_done   = dly2;
   assign ap_idle   = ~ap_start;
      
endmodule // rtl_model
