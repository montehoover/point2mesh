# The 'devel' version of nvidia/cuda contains nvcc but the 'runtime' version does not so we use 'devel'
FROM nvcr.io/nvidia/cuda:11.3.1-devel-ubuntu20.04

# Avoid interactive questions that come from some apt package installs
ARG DEBIAN_FRONTEND="noninteractive"

# Install system basics
RUN apt-get update && apt-get install -y \
        cmake \
        git \
        wget \
    && rm -rf /var/lib/apt/lists/*

# Install minicondapython
RUN wget --quiet https://repo.anaconda.com/miniconda/Miniconda3-py38_4.12.0-Linux-x86_64.sh -O miniconda.sh \
    && /bin/bash miniconda.sh -b -p /opt/conda \
    && rm miniconda.sh
ENV PATH=/opt/conda/bin:$PATH

# Clone and build Manifold which is a dependency of Point2Mesh
ARG MANIFOLD_DIR=~/code/Manifold
RUN git clone https://github.com/hjwdzh/Manifold.git $MANIFOLD_DIR \
    && mkdir $MANIFOLD_DIR/build && cd $MANIFOLD_DIR/build \
    && cmake .. -DCMAKE_BUILD_TYPE=Release \
    && make

# Install python modules from conda environment file.
# If you were installing this locally just leave off "-n base" and it will create a new environment for you.
COPY ./environment.yml .
RUN conda env update -n base -f environment.yml \
    && rm environment.yml