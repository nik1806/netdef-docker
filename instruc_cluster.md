## Instruction to work at cluster

0. The important repositories (netdef_models, netdef_slim) at `/` (root location) reached by `cd` command.
1. Set the variables using `/home/nipa00002/set_env.sh` file or refer to `run-network.sh`.
2. Execute command `source /netdef_slim/bashrc ` to use package `netdef_slim`.
3. Copy `netdef_models` directory to the base directory (same location we start the container) because
we don't have write access at root location.
4. Enter respective model directory `cd /netdef_models/FlowNet3/CSSR-ft-sd/`.
5. Create output folder : `mkdir output`
6. Run the model with command:
```
python3 controller.py eval /home/nipa00002/netdef-docker/data/0000001-imgL.png /home/nipa00002/netdef-docker/data/0000001-imgR.png output/.
```