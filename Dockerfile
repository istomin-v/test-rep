FROM nvidia/cuda:12.4.0-devel-ubuntu22.04

# Отключаем интерактив, чтобы не было зависаний при установках
ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get upgrade -y \
    && apt-get install -y software-properties-common \
    && add-apt-repository ppa:deadsnakes/ppa \
    && apt-get update \
    && apt-get install -y \
        curl \
        wget \
        ca-certificates \
        ninja-build \
        build-essential \
        xz-utils \
        libglu-dev \
        libxi6 \
        libfontconfig1 \
        libxrender1 \
        libxkbcommon-x11-0 \
        libsm6 \
        cmake \
        python3.11 \
        python3.11-dev \
        python3.11-distutils \
    && apt-get purge -y --auto-remove -o APT::AutoRemove::RecommendsImportant=false \
    && rm -rf /var/lib/apt/lists/*

RUN curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py \
    && python3.11 get-pip.py \
    && rm get-pip.py

RUN mkdir -p /usr/src/app

WORKDIR /usr/src/app

COPY ./Hunyuan3D-2/. ./.

COPY entrypoint.sh ./entrypoint.sh
ENTRYPOINT ["/bin/sh", "./entrypoint.sh"]