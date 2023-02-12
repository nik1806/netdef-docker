#!/bin/bash

# set variables
export LMBSPECIALOPS_LIB="/lmbspecialops/build/lib/lmbspecialops.so"
export PYTHONPATH="/usr/local/lib/python3.6/dist-packages:/lmbspecialops/python"
export CUDA_VISIBLE_DEVICES="0"
export PATH="/netdef_slim/tools:$PATH"

# source package
source /netdef_slim/bashrc

# download models
git clone https://github.com/lmb-freiburg/netdef_models && \
cd netdef_models                                        && \
git checkout 7d3311579cf712b31d05ec29f3dc63df067aa07b   && \
cd FlowNet3  && bash download_snapshots.sh && cd ..     

# chose model
cd FlowNet3/CSSR-ft-sd/

mkdir output/

# run model
python3 controller.py eval \
 /share_chairilg/data/cityscapes/leftImg8bit_sequence/val/frankfurt/frankfurt_000000_000275_leftImg8bit.png \
 /share_chairilg/data/cityscapes/leftImg8bit_sequence/val/frankfurt/frankfurt_000000_000276_leftImg8bit.png \
 output/