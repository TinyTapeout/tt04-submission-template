SIM ?= icarus
TOPLEVEL_LANG ?= verilog

VERILOG_SOURCES += $(PWD)/tb.v $(PWD)/tt_um_ttrng.v $(PWD)/ttrng.v $(PWD)/sr_latch.v $(PWD)/d_flip_flop.v

TOPLEVEL = tb

MODULE = test

COCOTB_RESOLVE_X = ZEROS

include $(shell cocotb-config --makefiles)/Makefile.sim