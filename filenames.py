import argparse

parser = argparse.ArgumentParser()
parser.add_argument("--file", type=str, default="frankfurt_000058_000019_leftImg8bit.png")
args = parser.parse_args()

frame = args.file

# produce previous frame name for creating motion boundaries
if "lindau" in frame or "munster" in frame:
    prev_frame = frame.replace("_000019_leftImg8", "_000018_leftImg8")
elif "frankfurt" in frame:
    frame_no = frame.split('_')[-2]
    prev_no = int(frame_no)-1
    addn_zero = len(frame_no) - len(str(prev_no))
    prev_frame = frame.replace(frame_no, "0"*addn_zero + str(prev_no))

exit(prev_frame)