############################################################################
# Makefile for cocotb API
############################################################################

# Source Directory
HDL_DIR=../../hdl
INC_DIR=../../include
COCOTB=/home/jayant/devel/cocotb

# Defining Verilog Sources for cocotb Simulation
VERILOG_SOURCES = $(HDL_DIR)/sp_sync_fifo.v \
                  $(HDL_DIR)/spram.v \
                  $(INC_DIR)/dump.v
                  
TOPLEVEL=sp_sync_fifo
MODULE=testFIFO
EXTRA_ARGS=-I $(HDL_DIR) -I $(INC_DIR)
SIM_ARGS=-lxt2

include $(COCOTB)/makefiles/Makefile.inc
include $(COCOTB)/makefiles/Makefile.sim
