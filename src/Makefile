SIM ?= icarus
TOPLEVEL_LANG ?= verilog

VERILOG_SOURCES += $(PWD)/tb.v $(PWD)/sr_latch_gated.v $(PWD)/sr_latch.v $(PWD)/clocked_sr_latch.v $(PWD)/sr_latch_network.v \
$(PWD)/d_flip_flop.v $(PWD)/ttrng.v $(PWD)/tt_um_ttrng.v

TOPLEVEL = tb

MODULE = test

COCOTB_RESOLVE_X = ZEROS

include $(shell cocotb-config --makefiles)/Makefile.sim

lint:
	iverilog -Wall $(VERILOG_SOURCES)
	verilator --timing --lint-only tb.v

# Matches what the GDS github task uses.
lint_strict:
	iverilog -Wall $(VERILOG_SOURCES)
	verilator --lint-only -Wall tb.v

waves: lint
	iverilog -o tb.vvp $(VERILOG_SOURCES)
	vvp -n -v tb.vvp

view:
	open -a GtkWave.app tb.vcd

test_tb: lint
	iverilog -o tb.vvp $(VERILOG_SOURCES) 
	vvp -n -v tb.vvp

test_dff: lint
	iverilog -o dff_tb.vvp d_flip_flop_tb.v
	vvp -n -v dff_tb.vvp

test_sr:
	iverilog -o sr_latch_tb.vvp sr_latch_tb.v
	vvp -n -v sr_latch_tb.vvp

test_latch_network:
	iverilog -o sr_latch_network_tb.vvp sr_latch_network_tb.v
	vvp -n -v sr_latch_network_tb.vvp


test_clocked_sr:
	iverilog -o clocked_sr_latch_tb.vvp clocked_sr_latch_tb.v
	vvp -n -v clocked_sr_latch_tb.vvp

test_gated_sr:
	iverilog -o sr_latch_gated_tb.vvp sr_latch_gated_tb.v
	vvp -n -v sr_latch_gated_tb.vvp

magic:
	magic -rcfile $(PDK_ROOT)/$(PDK)/libs.tech/magic/$(PDK).magicrc