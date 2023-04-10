export PYTHONPATH := $(PWD)/test:$(PYTHONPATH)
TOPLEVEL_LANG = verilog
VERILOG_SOURCES += $(PWD)/src/bfu_dif_top.v
VERILOG_SOURCES += $(PWD)/src/bfu_internal.v
VERILOG_SOURCES += $(PWD)/src/cmx_add.v
VERILOG_SOURCES += $(PWD)/src/cmx_mult.v
VERILOG_SOURCES += $(PWD)/src/cos_lut_wr.v
VERILOG_SOURCES += $(PWD)/src/cos_lut.v
VERILOG_SOURCES += $(PWD)/src/delay_buffer.v
VERILOG_SOURCES += $(PWD)/src/sine_lut_wr.v
VERILOG_SOURCES += $(PWD)/src/sin_lut.v
VERILOG_SOURCES += $(PWD)/src/rom_async.v
VERILOG_SOURCES += $(PWD)/src/tw_calc.v
VERILOG_SOURCES += $(PWD)/src/tw_rom.v
TOPLEVEL = bfu_dif_top
MODULE = test
SIM ?= icarus

include $(shell cocotb-config --makefiles)/Makefile.sim