FROM pytorch/pytorch:1.13.1-cuda11.6-cudnn8-runtime

# set working directory
WORKDIR /root

# clone repo
RUN apt-get update && apt-get install -y git
RUN git clone https://github.com/jjkim0807/CodeS.git

# install conda
RUN apt-get install -y wget
RUN wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O ~/miniconda.sh
RUN bash ~/miniconda.sh -b -u -p ~/miniconda
RUN rm -rf ~/miniconda.sh
ENV PATH="/root/miniconda/bin:${PATH}"
RUN conda init bash

# cd to CodeS
WORKDIR /root/CodeS

# create conda environment
RUN . ~/.bashrc && conda create -n CodeS python=3.8.5
RUN . ~/.bashrc && conda activate CodeS && conda install pytorch==1.13.1 torchvision==0.14.1 torchaudio==0.13.1 pytorch-cuda=11.6 -c pytorch -c nvidia
RUN apt update && apt install -y gcc clang clang-tools cmake
RUN . ~/.bashrc && conda activate CodeS && pip install -r requirements.txt
RUN git clone https://github.com/lihaoyang-ruc/SimCSE.git
RUN . ~/.bashrc && conda activate CodeS && cd SimCSE && python setup.py install && cd ..
