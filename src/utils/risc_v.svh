`ifndef RISC_V_SVH
`define RISC_V_SVH

localparam logic [6:0] R_TYPE       = 7'b0110011;
localparam logic [6:0] IMM_I_TYPE   = 7'b0010011;
localparam logic [6:0] ALU_R_I_TYPE = 7'b0?10011;
localparam logic [6:0] LD_I_TYPE    = 7'b0000011;
localparam logic [6:0] IMM_LD_I_TYPE = 7'b00?0011;
localparam logic [6:0] S_TYPE       = 7'b0100011;
localparam logic [6:0] LD_I_S_TYPE  = 7'b0?00011;
localparam logic [6:0] B_TYPE       = 7'b1100011;
localparam logic [6:0] JAL_J_TYPE   = 7'b1101111;
localparam logic [6:0] JMP_I_TYPE   = 7'b1100111;
localparam logic [6:0] JMP_I_J_TYPE = 7'b110?111;
localparam logic [6:0] U_TYPE       = 7'b0?10111;
localparam logic [6:0] LUI_U_TYPE   = 7'b0110111;
localparam logic [6:0] AUIPC_U_TYPE = 7'b0010111;
localparam logic [6:0] ENV_I_TYPE   = 7'b1110011;


`endif // RISC_V_SVH
