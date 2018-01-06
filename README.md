# Machine Learning with [fast.ai](https://fast.ai)

## Setup

I am running most of this locally on a workstation with an nVidia GPU (currently a GTX1080). We can use nvidia-docker to keep a clean environment but we will still need to ensure we have the proper setup on the host machine. These [instructions](https://github.com/fastai/courses/blob/master/setup/install-gpu.sh) are great to setup the environment and are required to get running before nvidia-docker. See `host-setup.sh`

## Running
Ensure `nvidia-docker` is setup and working. See `host-setup.sh` to install it.

GPU Test/Information:
```bash
docker run \
    --runtime=nvidia \
    --rm \
    nvidia/cuda nvidia-smi
```

Run our notebook service:
```bash
docker build -t ml-fast-ai .
docker run \
    --runtime=nvidia \
    --rm \
    --name ml-fast-ai \
    --network="host" \
    -v $(pwd)/course-content:/data \
    -p 8888:8888 \
    ml-fast-ai
```

Monitor GPU Usage:
```bash
docker run \
    -ti \
    --runtime=nvidia \
    --rm \
    nvidia/cuda:8.0-cudnn7-runtime-ubuntu16.04 \
    /bin/bash -c "watch -n 1 nvidia-smi"
```


## Practical Deep Learning for Coders - Part 1
