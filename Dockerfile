FROM nvidia/cuda:8.0-cudnn5-devel-ubuntu16.04

# Install Packages
RUN apt-get update
RUN apt-get install -y wget bzip2 python2.7 build-essential

# Setup environment (copy separately so we can modify separately and use cahced layers
COPY [ "container-setup/anaconda-install.sh", "/opt/container-setup/anaconda-install.sh" ]
RUN [ "/opt/container-setup/anaconda-install.sh" ]
ENV PATH="/root/anaconda2/bin:$PATH"

RUN conda upgrade -y --all
RUN conda install -y bcolz
RUN conda install -y theano==0.8.2
RUN conda install -y keras==1.2.2
RUN conda install -y jupyter

COPY [ "container-setup/python-env-config.sh", "/opt/container-setup/python-env-config.sh" ]
RUN [ "/opt/container-setup/python-env-config.sh" ]

# Remove our apt caches after we're done installing stuff
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

VOLUME /data

WORKDIR /data

CMD ["/bin/bash", "-c", "jupyter notebook --allow-root "]