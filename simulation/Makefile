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

vsim: $(SIM_DIR) $(INC_DIR) $(HDL_DIR)
	@$(MAKE) -C $(SIM_DIR)/versim

psim: $(SIM_DIR) $(INC_DIR) $(HDL_DIR)
	@$(MAKE) -C $(SIM_DIR)/pysim

inc:
# 	@find ../ -type f \( -iname "*.v" \) -fprint $(INC_DIR)/files.txt
	@python $(INC_DIR)/geninc.py "$(HDL_DIR)/"

clean:
	-@rm -rf $(SIM_DIR)/*/sim_build
	-@find . -name "*.vvp" | xargs rm -rf
	-@find . -name "*.pyc" | xargs rm -rf
	-@find . -name "*.vcd" | xargs rm -rf
	-@find . -name "*.lxt" | xargs rm -rf
	-@find . -name "*.xml" | xargs rm -rf
	-@find . -name "*.~" | xargs rm -rf
