import cocotb
from cocotb.clock import Clock
from cocotb.triggers import FallingEdge
from cocotb.triggers import RisingEdge
from cocotb.triggers import Timer
from cocotb.triggers import ClockCycles
from cocotb.triggers import Lock
import ctypes as ct
import bfu_model
from math import cos
from math import sin
from fxpmath import Fxp


# @cocotb.test()
# async def test_dff_simple(dut):
#     """ Test that d propagates to q """

#     clock = Clock(dut.clk, 10, units="us")  # Create a 10us period clock on port clk
#     cocotb.start_soon(clock.start())  # Start the clock

#     for i in range(10):

#         dut.d.value = val  # Assign the random value val to the input port d
#         await FallingEdge(dut.clk)
#         assert dut.q.value == val, "output q was incorrect on the {}th cycle".format(i)

# @cocotb.test()
# async def test_dec_1(dut):
#     """ Test BFU combinational """
#     test_vector = [91, 119, 111, 64, 94, 64, 48, 57]
#     await Timer(1, units='ns')

#     for i in range(0, 7):
#         dut.cnt_val.value = i
#         await Timer(1, units='ns')
#         result = dut.seg_val.value
#         assert result==test_vector[i], f"assertion failed at {i} expected: {test_vector[i]}, got: {result}"

# @cocotb.test()
# async def test_dec_1(dut):
#     """ Test BFU combinational """
#     A = complex(-23, -2)
#     B = complex(-7, -6)
#     a = (((int(A.imag)) << 16) | (int(A.real) & 0xFFFF))
#     b = (((int(B.imag)) << 16) | (int(B.real) & 0xFFFF))
#     [c1, c2] = bfu_model.bfu_internal(a, b)

#     dut.a.value = a
#     dut.b.value = b
#     await Timer(1, units='ns')
#     #cocotb.log(f"expected: {c1}   got: {dut.c_plus.value}\nexpected: {c2}   got: {dut.c_minus.value}")
#     # assert c1==dut.c_plus.value, f"expected: {c1}   got: {dut.c_plus.value}"
#     # assert c2==dut.c_minus.value, f"expected: {c2}   got: {dut.c_minus.value}"
#     dut_c1_real = ct.c_int16(dut.c_plus.value & 0xFFFF).value
#     dut_c1_img = ct.c_int16((dut.c_plus.value & 0xFFFF0000) >> 16).value
#     dut_c2_real = ct.c_int16(dut.c_minus.value & 0xFFFF).value
#     dut_c2_img = ct.c_int16((dut.c_minus.value & 0xFFFF0000) >> 16).value
#     assert int(c1.real)==dut_c1_real, f"expected: {c1.real}   got: {dut_c1_real}"
#     assert int(c1.imag)==dut_c1_img, f"expected: {c1.imag}   got: {dut_c1_img}"
#     assert int(c2.real)==dut_c2_real, f"expected: {c2.real}   got: {dut_c2_real}"
#     assert int(c2.imag)==dut_c2_img, f"expected: {c2.imag}   got: {dut_c2_img}"


# @cocotb.test()
# async def test_dec_1(dut):
#     """Test cmx mult"""
#     q_point = 8
#     kUp = 2
#     nDown = 8
#     deda = 2**q_point
#     A = complex(-12, 15)
#     B = complex(8, -10)
#     TW = complex(cos(2 * 3.14 * kUp / nDown), -sin(2 * 3.14 * kUp / nDown))
#     # TW = complex(0.452, 0.452);
#     # ar = ct.c_int16(int(A.real) & 0xFFFF).value
#     # ai = ct.c_int16(int(A.imag) & 0xFFFF).value
#     # br = ct.c_int16(int(B.real) & 0xFFFF).value
#     # bi = ct.c_int16(int(B.imag) & 0xFFFF).value
#     ar = Fxp(A.real, signed=True, n_word=16, n_frac=q_point)
#     ai = Fxp(A.imag, signed=True, n_word=16, n_frac=q_point)
#     br = Fxp(B.real, signed=True, n_word=16, n_frac=q_point)
#     bi = Fxp(B.imag, signed=True, n_word=16, n_frac=q_point)

#     cocotb.log.info(f"ar: {ar}")
#     cocotb.log.info(f"ai: {ai}")
#     cocotb.log.info(f"br: {br}")
#     cocotb.log.info(f"bi: {bi}")

#     C_PLUS = A + B
#     C_MIN = (A - B) * TW

#     # cocotb.log.info(f"CPLUS: {C_PLUS}")
#     # cocotb.log.info(f"CMIN: {C_MIN}")

#     clock = Clock(dut.clk, 10, units="ns")  # Create a 10us period clock on port clk
#     cocotb.start_soon(clock.start())  # Start the clock

#     dut.reset_n.value = 0

#     await ClockCycles(dut.clk, 5, True)

#     dut.reset_n.value = 1

#     # dut.a.value = ct.c_uint32(((ar*deda) & 0xFFFF) | ((ai*deda) << 16)).value
#     # dut.b.value = ct.c_uint32(((br*deda) & 0xFFFF) | ((bi*deda) << 16)).value
#     dut.a.value = (int(ai.val) << 16) | (int(ar.val) & 0xFFFF)
#     dut.b.value = (int(bi.val) << 16) | (int(br.val) & 0xFFFF)
#     await Timer(1, units="ns")
#     cocotb.log.info(f"aval: {dut.a.value}")
#     cocotb.log.info(f"bval: {dut.b.value}")
#     dut.tw_addr.value = kUp

#     await ClockCycles(dut.clk, 6, True)
#     await Timer(1, units="ns")

#     #cp_result_r = ct.c_int16(dut.c_plus.value & 0xFFFF).value
#     # cp_result_i = ct.c_int16((dut.c_plus.value & 0xFFFF0000) >> 16).value
#     # cm_result_r = ct.c_int16(dut.c_minus.value & 0xFFFF).value
#     # cm_result_i = ct.c_int16((dut.c_minus.value & 0xFFFF0000) >> 16).value
#     # cp_result_r = Fxp(ct.c_uint16(dut.c_plus.value & 0xFFFF).value/256, signed=True, n_word=16, n_frac=q_point)
#     # cp_result_i = Fxp(ct.c_uint16((dut.c_plus.value & 0xFFFF0000) >> 16).value, signed=True, n_word=16, n_frac=q_point)
#     # cm_result_r = Fxp(ct.c_uint16(dut.c_minus.value & 0xFFFF).value, signed=True, n_word=16, n_frac=q_point)
#     # cm_result_i = Fxp(ct.c_uint16((dut.c_minus.value & 0xFFFF0000) >> 16).value, signed=True, n_word=16, n_frac=q_point)
#     cp_result_r = Fxp(None, signed=True, n_word=16, n_frac=q_point)
#     cp_result_i = Fxp(None, signed=True, n_word=16, n_frac=q_point)
#     cm_result_r = Fxp(None, signed=True, n_word=16, n_frac=q_point)
#     cm_result_i = Fxp(None, signed=True, n_word=16, n_frac=q_point)

#     cp_result_r.set_val(ct.c_int16(dut.c_plus.value).value, raw=True)
#     cp_result_i.set_val(ct.c_int16(dut.c_plus.value>>16).value, raw=True)
#     cm_result_r.set_val(ct.c_int16(dut.c_minus.value).value, raw=True)
#     cm_result_i.set_val(ct.c_int16(dut.c_minus.value>>16).value, raw=True)

#     # cocotb.log.info(f"cpr: {cp_result_r/deda}, cpi: {cp_result_i/deda}")
#     # cocotb.log.info(f"cmr: {cm_result_r/deda}, cmi: {cm_result_i/deda}")
#     cocotb.log.info(f"cpr: {cp_result_r}, cpi: {cp_result_i}")
#     cocotb.log.info(f"cmr: {cm_result_r}, cmi: {cm_result_i}")

#     cocotb.log.info(f"CPLUS: {C_PLUS}")
#     cocotb.log.info(f"CMIN: {C_MIN}")

#     # pReal = ct.c_int16(dut.pr.value).value
#     # pImag = ct.c_int16(dut.pi.value).value
#     # cocotb.log.info("expected:{%d}  got:{%d}", C.real, pReal)
#     # cocotb.log.info("expected:{%d}  got:{%d}", C.imag, pImag)
#     # assert int(C.real)==(pReal), f"failed!!! expected:{C.real}  got:{pReal}"
#     # assert int(C.imag)==(pImag), f"failed!!! expected:{C.imag}  got:{pImag}"

#     # await ClockCycles(dut.clk, 6, True)

@cocotb.test()
async def test_bfu_fft(dut):
    """Testing the BFU of FFT (fixed point Q8) (pipelined mutliplier 6 cycles) (DIF FFT)"""
    q_point = 8
    kUp = 2
    nDown = 8

    A = complex(5.8965, -2.69875)
    B = complex(15.4698, -77)
    TW = complex(cos(2 * 3.14 * kUp / nDown), -sin(2 * 3.14 * kUp / nDown))

    ar = Fxp(A.real, signed=True, n_word=16, n_frac=q_point)
    ai = Fxp(A.imag, signed=True, n_word=16, n_frac=q_point)
    br = Fxp(B.real, signed=True, n_word=16, n_frac=q_point)
    bi = Fxp(B.imag, signed=True, n_word=16, n_frac=q_point)

    C_PLUS = A + B
    C_MIN = (A - B) * TW


    clock = Clock(dut.clk, 10, units="ns")  # Create a 10us period clock on port clk
    cocotb.start_soon(clock.start())  # Start the clock

    dut.reset_n.value = 0

    await ClockCycles(dut.clk, 5, True)

    dut.reset_n.value = 1

    dut.a.value = (int(ai.val) << 16) | (int(ar.val) & 0xFFFF)
    dut.b.value = (int(bi.val) << 16) | (int(br.val) & 0xFFFF)
    dut.tw_addr.value = kUp

    await ClockCycles(dut.clk, 6, True)
    await Timer(1, units="ns")

    cp_result_r = Fxp(None, signed=True, n_word=16, n_frac=q_point)
    cp_result_i = Fxp(None, signed=True, n_word=16, n_frac=q_point)
    cm_result_r = Fxp(None, signed=True, n_word=16, n_frac=q_point)
    cm_result_i = Fxp(None, signed=True, n_word=16, n_frac=q_point)

    cp_result_r.set_val(ct.c_int16(dut.c_plus.value).value, raw=True)
    cp_result_i.set_val(ct.c_int16(dut.c_plus.value>>16).value, raw=True)
    cm_result_r.set_val(ct.c_int16(dut.c_minus.value).value, raw=True)
    cm_result_i.set_val(ct.c_int16(dut.c_minus.value>>16).value, raw=True)

    cocotb.log.info(f"C_PLUS_real Expected: {C_PLUS.real}  HW: {cp_result_r}")
    cocotb.log.info(f"C_PLUS_img Expected: {C_PLUS.imag}  HW: {cp_result_i}")
    cocotb.log.info(f"C_MINUS_real Expected: {C_MIN.real}  HW: {cm_result_r}")
    cocotb.log.info(f"C_MINUS_img Expected: {C_MIN.imag}  HW: {cm_result_i}")
