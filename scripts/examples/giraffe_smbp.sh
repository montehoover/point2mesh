#!/bin/bash

python main.py --input-pc ./data/giraffe.ply \
--initial-mesh ./data/giraffe_sparse_hull.obj \
--save-path ./checkpoints/giraffe_smbp7 \
--iterations 9000 \
--export-interval 400 \
--upsamp 500 \
--beamgap-iterations 2000 \
--beamgap-modulo 10 \
--manifold-always