FROM nvcr.io/nvidia/pytorch:23.12-py3

# Install dependencies for tiny bert
WORKDIR /workspace

RUN apt-get update && apt-get install -y --no-install-recommends \
    vim \
    openssh-server

RUN service ssh start

RUN useradd -ms /bin/bash xiachunwei
RUN echo "xiachunwei ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers
RUN usermod -aG sudo xiachunwei
RUN echo "root:123456" | chpasswd


RUN echo "xiachunwei:123456" | chpasswd
USER xiachunwei
WORKDIR /home/xiachunwei

RUN mkdir -p /home/xiachunwei/.ssh
RUN ssh-keygen -t rsa -b 4096 -f /home/xiachunwei/.ssh/id_rsa -N ""

# Append my public key to authorized_keys
COPY id_rsa.pub /home/xiachunwei/
RUN cat id_rsa.pub >> /home/xiachunwei/.ssh/authorized_keys

