FROM pytorch/pytorch:2.4.0-cuda12.4-cudnn9-runtime
# FROM python:3.10-slim-buster
# RUN pip install --no-cache-dir nvidia-tensorrt --index-url https://pypi.ngc.nvidia.com

# Arguments to build Docker Image using CUDA
# ARG USE_CUDA=0
# ARG TORCH_ARCH=

# ENV AM_I_DOCKER True
# ENV BUILD_WITH_CUDA "${USE_CUDA}"
# ENV TORCH_CUDA_ARCH_LIST "${TORCH_ARCH}"
# # ENV CUDA_HOME /usr/local/cuda-11.7/

# ENV DEBIAN_FRONTEND=noninteractive

# RUN /bin/bash -c 'conda init bash'

ENV APP_HOME /home/user/vstar

WORKDIR $APP_HOME

# 指定目录拥有者为root
RUN chown -R root:root $APP_HOME


# 将原镜像地址替换为腾讯云镜像地址
RUN sed -i 's/archive.ubuntu.com/mirrors.cloud.tencent.com/g' /etc/apt/sources.list
RUN sed -i 's/security.ubuntu.com/mirrors.cloud.tencent.com/g' /etc/apt/sources.list

RUN apt update \
    && apt install --no-install-recommends -y gcc git zip curl htop libgl1 \
    libglib2.0-0 libpython3-dev gnupg g++ libusb-1.0-0 libsm6 build-essential

# RUN apt clean && apt autoremove && rm -rf /var/lib/apt/lists/*

RUN apt upgrade --no-install-recommends -y openssl tar

COPY requirements.txt $APP_HOME

# 换源并更新pip
RUN pip config set global.index-url https://pypi.mirrors.ustc.edu.cn/simple/
RUN pip install --upgrade pip
RUN pip install --no-cache -r requirements.txt

COPY . $APP_HOME

# gradio设置
EXPOSE 7860
ENV GRADIO_SERVER_NAME="0.0.0.0"

CMD ["python", "app.py"]
