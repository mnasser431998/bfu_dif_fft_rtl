import ctypes as ct


def bfu_internal(a, b):
    a_real = ct.c_int16(a & 0xFFFF).value
    a_img = ct.c_int16((a & 0xFFFF0000) >> 16).value
    b_real = ct.c_int16(b & 0xFFFF).value
    b_img = ct.c_int16((b & 0xFFFF0000) >> 16).value
    a_cmx = complex(int(a_real), int(a_img))
    b_cmx = complex(int(b_real), int(b_img))
    c_plus = a_cmx + b_cmx
    c_minus = a_cmx - b_cmx
    return c_plus, c_minus


def test_model():
    a = complex(-23, -5)
    b = complex(7, -6)
    cc1 = a + b
    cc2 = a - b
    [c1, c2] = bfu_internal(
        (((int(a.imag)) << 16) | (int(a.real) & 0xFFFF)),
        (((int(b.imag)) << 16) | (int(b.real) & 0xFFFF)),
    )
    assert (cc1 == c1) and (cc2 == c2), f"assertion failed!!! Errors found"
    print(f"{cc1} --> {c1}\n{cc2} --> {c2}")



