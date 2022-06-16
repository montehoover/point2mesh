#!/bin/bash

python -m scripts.process_data.convex_hull \
    --i data/giraffe.ply \
    --o data/giraffe_blender_hull.obj \
    --faces 5000 \
    --blender \
    --blender-path /usr/bin \
    --blender-res 5 # octree depth; 4 gives ~400 faces, 5 gives ~2000 faces, 6 gives ~10000 faces
