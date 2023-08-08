# Example iCEBreaker Makefile
# Learn more at https://projectf.io/posts/building-ice40-fpga-toolchain/

# configuration
SHELL = /bin/sh
FPGA_PKG = hx1k
FPGA_TYPE = hx1k
PCF = pcf/io.pcf

# included modules
ADD_SRC = ../src/ttrng.v ../src/sr_latch_network.v ../src/sr_latch.v ../src/d_flip_flop.v

#top_foo: top_foo.rpt top_foo.bin
#top_bar: top_bar.rpt top_bar.bin

top_trng: top_trng.rpt top_trng.bin

%.json: %.v $(ADD_SRC)
	yosys -ql $(basename $@)-yosys.log -p \
	    'synth_ice40 -top $(basename $@) -json $@' $< $(ADD_SRC)

%.asc: %.json
#	nextpnr-ice40 --${FPGA_TYPE} --package ${FPGA_PKG} --json $< --pcf ${PCF} --asc $@
# --ignore-loops for the combinational loop in sr_latch.v
	nextpnr-ice40 --ignore-loops --top top_trng --hx1k --package tq144 --json $< --pcf ${PCF} --asc $@

%.rpt: %.asc
	icetime -d ${FPGA_TYPE} -mtr $@ $<

%.bin: %.asc
	icepack $< $(subst top_,,$@)

all: top_trng

clean:
	rm -f top*.json top*.asc top*.rpt *.bin top*yosys.log

.PHONY: all clean