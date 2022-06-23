#!/bin/bash

python -m scripts.process_data.convex_hull \
    --i data/earcup_pointcloud.ply \
    --faces 2000 \
    --manifold-path ~/code/Manifold/build \
    --o data/earcup_sparse_hull.obj
    # --blender \
    # --blender-path /usr/bin \
    # --blender-res 5 # octree depth; 4 gives ~400 faces, 5 gives ~2000 faces, 6 gives ~10000 faces
    

