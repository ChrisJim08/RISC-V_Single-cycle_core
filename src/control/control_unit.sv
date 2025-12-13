`timescale 1ns / 1ps
`include "risc_v.svh"
//////////////////////////////////////////////////////////////////////////////////
// Company: Self-employed
// Engineer: Chris Jimenez
// 
// Create Date: 12/12/2024
// Design Name: 
// Module Name: Control Unit
// Project Name: RISC-V Single-Cycle Processor
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

module control_unit(
  input  logic [6:0] op_code_i,
  input  logic [2:0] funct3_i,
  input  logic       fnc7_h20_i,
  output logic       jal_o,
  output logic       jalr_o,
  output logic       branch_o,
  output logic       auipc_o,
  output logic       regf_wr_en_o,
  output logic       mem_wr_en_o,
  output logic [1:0] regf_wd_src_o, 
  output logic       alu_src_o,
  output logic [3:0] alu_op_o,
  output logic       env_instr_o
);

  logic fnc7_valid;

  assign fnc7_valid   =    fnc7_h20_i
                        && (op_code_i == R_TYPE);

  assign regf_wr_en_o =    (op_code_i != S_TYPE)
                        && (op_code_i != B_TYPE)
                        && (op_code_i != ENV_I_TYPE);

  assign alu_src_o    =    (op_code_i == S_TYPE)
                        || (op_code_i == LD_I_TYPE)
                        || (op_code_i == IMM_I_TYPE);

  assign branch_o     =    (op_code_i == B_TYPE);
  assign jal_o        =    (op_code_i == JAL_J_TYPE);
  assign jalr_o       =    (op_code_i == JMP_I_TYPE);
  assign auipc_o      =    (op_code_i == AUIPC_U_TYPE);

  assign mem_wr_en_o  =    (op_code_i == S_TYPE)
                        && (op_code_i != ENV_I_TYPE);

  always_comb begin
    regf_wd_src_o = 2'b00;
    alu_op_o = '0;
    env_instr_o = 1'b0;
    unique casez (op_code_i) 
      ALU_R_I_TYPE: begin
        regf_wd_src_o = 2'b00;
        unique case (funct3_i)
          3'h0: begin
            alu_op_o = fnc7_valid ? 4'h1 : 4'h0; //SUB //ADD
          end
          3'h4: begin
            alu_op_o = 4'h2; //XOR 
          end
          3'h6: begin
            alu_op_o = 4'h3; //OR
          end
          3'h7: begin
            alu_op_o = 4'h4; //AND
          end
          3'h1: begin
            alu_op_o = 4'h5; //SLL
          end
          3'h5: begin
            alu_op_o = fnc7_h20_i ? 4'h7 : 4'h6; //SRA //SRL
          end
          3'h2: begin
            alu_op_o = 4'h8; //SLT
          end
          3'h3: begin
            alu_op_o = 4'h9; //SLTU
          end
        endcase
      end
      LD_I_S_TYPE: begin
        regf_wd_src_o = 2'b01;
        alu_op_o   = 4'h0; //ADD //rs1+imm
      end
      B_TYPE: begin
        unique case (funct3_i)
          3'h0: begin
            alu_op_o = 4'hA; //BEQ
          end
          3'h1: begin
            alu_op_o = 4'hB; //BNE
          end
          3'h4: begin
            alu_op_o = 4'hC; //BLT
          end
          3'h5: begin
            alu_op_o = 4'hD; //BGE
          end
          3'h6: begin
            alu_op_o = 4'hE; //BLTU
          end
          3'h7: begin
            alu_op_o = 4'hF; //BGEU
          end
          default: begin
          end
        endcase
      end
      JMP_I_J_TYPE: begin
        regf_wd_src_o = 2'b10;
      end
      U_TYPE: begin
        regf_wd_src_o = 2'b11;
      end
      ENV_I_TYPE: begin
        //TODO Implement differentiation of ecall and ebreak
        env_instr_o = 1'b1;
      end
      default: begin
      end
    endcase
  end
endmodule
