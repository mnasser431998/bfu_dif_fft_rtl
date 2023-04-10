# Autogenerated file
onerror {
	quit -f -code 1
}
vmap -c
if [file exists sim_build/work] {vdel -lib sim_build/work -all}
vlib sim_build/work
vmap work sim_build/work
vlog -work work +define+COCOTB_SIM -sv -timescale 1ns/1ps -mfcu +acc  /home/mnasser431998/Desktop/fft_pipeline/src/bfu_dif_top.v /home/mnasser431998/Desktop/fft_pipeline/src/bfu_internal.v /home/mnasser431998/Desktop/fft_pipeline/src/cmx_add.v /home/mnasser431998/Desktop/fft_pipeline/src/cmx_mult.v /home/mnasser431998/Desktop/fft_pipeline/src/cos_lut_wr.v /home/mnasser431998/Desktop/fft_pipeline/src/cos_lut.v /home/mnasser431998/Desktop/fft_pipeline/src/delay_buffer.v /home/mnasser431998/Desktop/fft_pipeline/src/sine_lut_wr.v /home/mnasser431998/Desktop/fft_pipeline/src/sin_lut.v /home/mnasser431998/Desktop/fft_pipeline/src/rom_async.v /home/mnasser431998/Desktop/fft_pipeline/src/tw_calc.v
vsim  -onfinish exit -pli /home/mnasser431998/.local/lib/python3.6/site-packages/cocotb/libs/libcocotbvpi_modelsim.so   sim_build/work.bfu_dif_top
onbreak resume
run -all
quit