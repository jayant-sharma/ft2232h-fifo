############################################################################
# Makefile for cocotb API
############################################################################

# Source Directory
HDL_DIR=../../hdl

# Defining Verilog Sources for cocotb Simulation
COCOTB=/home/jayant/devel/cocotb
VERILOG_SOURCES = $(HDL_DIR)/sp_sync_fifo.v $(HDL_DIR)/spram.v 
TOPLEVEL=sp_sync_fifo
MODULE=testFIFO

SIM_ARGS=-lxt2

include $(COCOTB)/makefiles/Makefile.inc
include $(COCOTB)/makefiles/Makefile.sim
