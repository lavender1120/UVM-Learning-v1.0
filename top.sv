///////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////
///////////  ////////////        //////////////////////////////////
//////////  ///////////////  //////////////////////////////////////
/////////  ///////////////  ///////////////////////////////////////
////////  ///////////////  ////////////////////////////////////////
///////  ///////////////  /////////////////////////////////////////
//////        //////     //////////////////////////////////////////
///////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////

`ifndef GUARD_TOP
`define GUARD_TOP

/////////////////////////////////////////////////////////////
// IMPORTING UVM Packages
/////////////////////////////////////////////////////////////

`include "uvm.svh"
import uvm_pkg::*;

module top();


/////////////////////////////////////////////////////////////
// clock declaration
/////////////////////////////////////////////////////////////
initial 
begin 
#20;
  fork
    forever #10 wr_lock = ~wr_lock; 
    forever #15 rd_lock = ~rd_lock; 
  join
end

/////////////////////////////////////////////////////////////
//????????
//
initial 
begin 
  reset = 0;
  #200;
  reset = 1;
end


/////////////////////////////////////////////////////////////
// interface instance
/////////////////////////////////////////////////////////////

fifo_interface.WR w_intf(wr_clock);

fifo_interface.RD r_intf(rd_clock);



/////////////////////////////////////////////////////////////
// DUT instance and connection
/////////////////////////////////////////////////////////////

async_fifo A_FIFO (
                    .rst_n(reset),
                    .wr_clk(wr_clock),
                    .rd_clk(rd_clock),
                    
                    .wen    (w_intf.wr_en),
                    .wdata  (w_intf.wr_data),
                    .ren    (r_intf.rd_en),
                    .rdata  (r_intf.rd_data),
                    
                    .full   (w_intf.full),
                    .afull  (w_intf.afull),
                    
                    .empty  (r_intf.empty),
                    .aempty (r_intf.aempty)
                  );


endmodule:top

`endif
