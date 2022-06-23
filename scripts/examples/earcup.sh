python main.py \
    --input-pc ./data/earcup_pointcloud.ply \
    --initial-mesh ./data/earcup_sparse_hull.obj \
    --save-path ./checkpoints/earcup_smp \
    --max-faces 30000 \
    --iterations 6000 \
    --export-interval 400 \
    --upsamp 500 \
    --manifold-always \
    # --beamgap-iterations 2000 \
    # --beamgap-modulo 10 \