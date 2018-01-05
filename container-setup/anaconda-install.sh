#!/bin/bash
# From: https://github.com/fastai/courses/blob/master/setup/install-gpu.sh

mkdir -p /opt/anaconda
cd /opt/anaconda
wget "https://repo.continuum.io/archive/Anaconda2-5.0.1-Linux-x86_64.sh" -O "Anaconda2-5.0.1-Linux-x86_64.sh"
bash "Anaconda2-5.0.1-Linux-x86_64.sh" -b

echo "export PATH=\"$HOME/anaconda2/bin:\$PATH\"" >> ~/.bashrc
export PATH="$HOME/anaconda2/bin:$PATH"
conda config --add channels conda-forge