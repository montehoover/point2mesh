python main.py \
    --input-pc ./data/g.ply \
    --initial-mesh ./data/g_sparse_hull.obj \
    --save-path ./checkpoints/g_smb \
    --iterations 6000 \
    --export-interval 400 \
    --upsamp 500 \
    --manifold-always \
    --beamgap-iterations 1400 \
    --beamgap-modulo 20 \