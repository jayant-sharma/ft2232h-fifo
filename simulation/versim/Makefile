############################################################################
# Makefile for Icarus Verilog Simulation
############################################################################

# Simulation Directories
SIM_DIR=../../simulation
INC_DIR=../../include
HDL_DIR=../../hdl

# Simulator (Icarus Verilog)
SIMC=iverilog
SIM_OPTS=-o
SIM_ARGS=-lxt2
EXTRA_ARGS=-I $(INC_DIR) -I $(HDL_DIR)

all:
	@mkdir -p $(SIM_DIR)/versim/sim_build
	@$(SIMC) $(SIM_OPTS) \
	 $(SIM_DIR)/versim/sim_build/vsim.vvp -c \
	 $(INC_DIR)/files.txt
	@vvp $(SIM_DIR)/versim/sim_build/vsim.vvp $(SIM_ARGS) $(EXTRA_ARGS)
