############################################################################
# Makefile for two simulation modes
############################################################################

# Simulation Directories
SIM_DIR=../simulation
INC_DIR=../include
HDL_DIR=../hdl

# Simulator (Icarus Verilog)
SIMC=iverilog
SIM_OPTS=-o

vsim:
	@mkdir -p $(SIM_DIR)/versim/sim_build
# 	@find ../ -type f \( -iname "*.v" \) -fprint $(INC_DIR)/files.txt
	@$(SIMC) $(SIM_OPTS) \
	$(SIM_DIR)/versim/sim_build/vsim.vvp -c $(INC_DIR)/files.txt
	@vvp $(SIM_DIR)/versim/sim_build/vsim.vvp

psim:
	@cd $(SIM_DIR)/pysim
	@make
	@cd ../$(SIM_DIR)

clean:
	-@rm -rf $(SIM_DIR)/*/sim_build
	-@find . -name "*.vvp" | xargs rm -rf
	-@find . -name "*.pyc" | xargs rm -rf
	-@find . -name "*.vcd" | xargs rm -rf
	-@find . -name "*.xml" | xargs rm -rf
	-@find . -name "*.~" | xargs rm -rf
