#!/usr/bin/env python3
import sys, getopt
from fxpmath import Fxp
from math import log2, pi, cos, sin


def main(argv):

    opts, args = getopt.getopt(argv, "hp:w:q:")
    for opt, arg in opts:
        if opt == "-h":
            print("**twiddle factors rom generator for FPGA version 1.0\n")
            print("USAGE:-")
            print("     generate_tw.rom.py -p <fftPoints> -w <wordLength> -q <qFixedPointLoc>")
            sys.exit()
        elif opt in ("-p"):
            n_points = arg
        elif opt in ("-w"):
            word_len = arg
        elif opt in ("-q"):
            q_point = arg
                
    return n_points, word_len, q_point


# Writing a Function To Remove a Prefix in Python
def removeprefix(text, prefix):
    if text.startswith(prefix):
        return text[len(prefix) :]
    else:
        return text


def gen_twiddles(n_points=8, word_len=16, q_point=8):
    n_stages = int(log2(n_points))

    for i in range(0, n_stages):
        print(f"****stage: {i+1}")
        step = 1 << i
        cnt = 0
        file_name = f"tw_rom_p_{n_points}_st_{i+1}_q_{q_point}.mem"
        f = open(file_name, "+w")
        for j in range(0, n_points >> (i + 1)):

            omega = complex(cos(2 * pi * cnt / n_points), -sin(2 * pi * cnt / n_points))
            omega_fix_r = Fxp(omega.real, signed=True, n_word=word_len, n_frac=q_point)
            omega_fix_img = Fxp(
                omega.imag, signed=True, n_word=word_len, n_frac=q_point
            )
            f.write(
                f"{removeprefix(omega_fix_img.hex(),'0x')}{removeprefix(omega_fix_r.hex(),'0x')}\n"
            )
            print(
                f"twiddle: {cnt} --> {omega} --> {removeprefix(omega_fix_r.hex(),'0x')}  {removeprefix(omega_fix_img.hex(),'0x')}"
            )
            cnt = cnt + step
        f.close()


if __name__ == "__main__":
    [n_points, word_len, q_point] = main(sys.argv[1:])
    gen_twiddles(int(n_points), int(word_len), int(q_point))
