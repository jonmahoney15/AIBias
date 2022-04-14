FROM nvidia/cuda:11.6.0-runtime-ubuntu20.04

RUN apt-get -y update \
    && apt-get install -y software-properties-common \
    && apt-get -y update \
    && add-apt-repository universe
RUN apt-get -y update
RUN apt-get -y install python3
RUN apt-get -y install python3-pip
RUN pip3 install torch torchvision torchaudio --extra-index-url https://download.pytorch.org/whl/cu113
RUN pip3 install notebook

ENV TINI_VERSION v0.6.0
ADD https://github.com/krallin/tini/releases/download/${TINI_VERSION}/tini /usr/bin/tini
RUN chmod +x /usr/bin/tini
ENTRYPOINT ["/usr/bin/tini", "--"]
CMD ["jupyter", "notebook", "--port=8888", "--no-browser", "--ip=0.0.0.0", "--allow-root", "/home/jovyan/work/model.ipynb"]