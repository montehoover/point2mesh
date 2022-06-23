python main.py \
    --input-pc ./data/ear_pointcloud.ply \
    --initial-mesh ./data/ear_sparse_hull.obj \
    --save-path ./checkpoints/ear_smp \
    --iterations 6000 \
    --export-interval 400 \
    --upsamp 500 \
    --manifold-always \
    # --beamgap-iterations 2000 \
    # --beamgap-modulo 10 \