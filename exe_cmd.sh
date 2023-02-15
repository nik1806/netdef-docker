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
mkdir output/frankfurt
mkdir output/lindau
mkdir output/munster

# run model over list of images
input="/home/paliwal/netdef-docker/CityscapesSeq_list.txt"
base_path="/share_chairilg/data/cityscapes/leftImg8bit_sequence/val/"
while IFS= read -r line
do
    prev=$(python3 /home/paliwal/netdef-docker/filenames.py --file $line 2>&1)

    echo $prev
    
    python3 controller.py eval "$base_path$prev" "$base_path$line" output/

    mv "output/mb_soft[0].fwd.float3" "output/${line}mb_soft[0].fwd.float3"
    mv "output/mb[0].fwd.float3" "output/${line}mb[0].fwd.float3"

done < "$input"


# python3 controller.py eval \
#  /share_chairilg/data/cityscapes/leftImg8bit_sequence/val/frankfurt/frankfurt_000000_000275_leftImg8bit.png \
#  /share_chairilg/data/cityscapes/leftImg8bit_sequence/val/frankfurt/frankfurt_000000_000276_leftImg8bit.png \
#  output/