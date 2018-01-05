#!/usr/bin/env bash
# From: https://github.com/fastai/courses/blob/master/setup/install-gpu.sh

# Configure theano
echo "[global]
device = gpu
floatX = float32
[cuda]
root = /usr/local/cuda" > ~/.theanorc

# Configure keras
mkdir ~/.keras
echo '{
    "image_dim_ordering": "th",
    "epsilon": 1e-07,
    "floatx": "float32",
    "backend": "theano"
}' > ~/.keras/keras.json

jupyter notebook --generate-config --allow-root
echo "c.NotebookApp.ip = '127.0.0.1'
c.NotebookApp.port = 8888
c.NotebookApp.open_browser = False" >> $HOME/.jupyter/jupyter_notebook_config.py