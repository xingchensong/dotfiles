# 运行 CUDA 应用程序：选择 runtime 或 cudnn8-runtime
#FROM nvidia/cuda:12.1.0-cudnn8-runtime-ubuntu22.04
FROM micr.cloud.mioffice.cn/base_model/nvidia/pytorch:25.04-py3
LABEL maintainer="songxingchen@xiaomi.com"

# 设置 Shell
SHELL ["/bin/bash", "-c"]

# 更新和安装软件包
RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
        openssh-server \
        sshpass \
        iproute2 \
        psmisc \
        libibverbs1 \
        ibverbs-utils \
        librdmacm1 \
        libibumad3 \
        ibverbs-providers \
        rdma-core \
        rdmacm-utils \
        zsh \
        shellcheck \
        ruby \
        gawk \
        exuberant-ctags \
        autojump \
        bat \
        cowsay \
        duf \
        eza \
        fortune-mod \
        fzf \
        ripgrep \
        neofetch \
        automake \
        btop \
        build-essential \
        bzip2 \
        ca-certificates \
        cmake \
        curl \
        dos2unix \
        ffmpeg \
        figlet \
        flac \
        g++ \
        gdb \
        git \
        git-lfs \
        htop \
        iftop \
        iotop \
        iputils-ping \
        jq \
        less \
        libffi-dev \
        libpam-runtime \
        libsndfile1 \
        libsndfile1-dev \
        libssl-dev \
        libtool \
        librados2 \
        librados-dev \
        locales \
        lsof \
        make \
        ncdu \
        neovim \
        net-tools \
        openssh-client \
        openssh-server \
        python3 \
        python3-dev \
        python3-pip \
        rsync \
        rsyslog \
        software-properties-common \
        sox \
        libsox-dev \
        sudo \
        sysstat \
        tmux \
        tree \
        tzdata \
        unzip \
        valgrind \
        vim \
        wget \
        zip \
        zlib1g-dev && \
    ln -sf /usr/bin/python3 /usr/bin/python && \
    locale-gen en_US.UTF-8 zh_CN.UTF-8 && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

# 设置语言和时区
ENV LANG=en_US.UTF-8
ENV LC_ALL=en_US.UTF-8
ENV TZ=Asia/Shanghai
RUN ln -sf /usr/share/zoneinfo/$TZ /etc/localtime && dpkg-reconfigure -f noninteractive tzdata

# 配置 SSH 服务
RUN mkdir -p /var/run/sshd && \
    echo 'root:Xiaomi2025' | chpasswd && \
    sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config && \
    sed -i 's/#PasswordAuthentication yes/PasswordAuthentication yes/' /etc/ssh/sshd_config && \
    sed -i 's/#Port 22/Port 22/' /etc/ssh/sshd_config && \
    sed -i 's/#PermitRootLogin.*/PermitRootLogin yes/' /etc/ssh/sshd_config && \
    sed -i 's/#PubkeyAuthentication.*/PubkeyAuthentication yes/' /etc/ssh/sshd_config && \
    sed -i 's/#PasswordAuthentication.*/PasswordAuthentication no/' /etc/ssh/sshd_config && \
    echo 'PubkeyAuthentication yes' >> /etc/ssh/sshd_config && \
    echo 'export VISIBLE=now' >> /etc/profile

# 初始化 root SSH 目录
RUN mkdir -p /root/.ssh && chmod 700 /root/.ssh && touch /root/.ssh/authorized_keys && chmod 600 /root/.ssh/authorized_keys

# 创建普通用户并配置密码和 sudo 权限
RUN useradd -g 0 -m -d /home/songxingchen -s /bin/bash songxingchen && \
    echo "songxingchen:songxingchen2025" | chpasswd && adduser songxingchen sudo

# 安装 Miniforge
#curl -fsSL https://github.com/conda-forge/miniforge/releases/latest/download/Miniforge3-Linux-x86_64.sh -o Miniforge3.sh
COPY Miniforge3.sh /tmp/Miniforge3.sh
RUN bash /tmp/Miniforge3.sh -b -p /opt/conda && \
    rm /tmp/Miniforge3.sh && \
    /opt/conda/bin/conda init bash && \
    echo 'export PATH="/opt/conda/bin:$PATH"' >> ~/.bashrc

# 安装较新的 Node.js 和 NPM
RUN curl -fsSL https://deb.nodesource.com/setup_20.x | bash - && \
    apt-get install -y nodejs && \
    npm install -g npm@latest

#curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim.appimage && \
# 安装较新的 Neovim
COPY nvim.appimage nvim.appimage
RUN chmod u+x nvim.appimage && \
    ./nvim.appimage --appimage-extract && \
    rm nvim.appimage && \
    mv squashfs-root /opt/nvim && \
    [ -e /usr/bin/nvim ] && rm /usr/bin/nvim || true && \
    ln -s /opt/nvim/AppRun /usr/bin/nvim

# 配置dotfiles
RUN /opt/conda/bin/pip install pynvim neovim jedi autopep8 cpplint pylint isort cmakelint cmake-format flake8 gpustat nvitop
RUN /usr/bin/pip install pynvim neovim jedi autopep8 cpplint pylint isort cmakelint cmake-format flake8 gpustat nvitop
WORKDIR /root
RUN git clone https://github.com/xingchensong/dotfiles.git && echo "hahah"
WORKDIR /root/dotfiles
RUN bash setup.sh
# hook需要bashrc，而hook 运行时用的宿主机的文件系统。软链映射不到容器里的文件。其他的rc不需要
RUN cp --remove-destination bash/bashrc /root/.bashrc
RUN cp --remove-destination bash/bashrc /root/.bash_profile
RUN cp --remove-destination bash/bashrc /root/.profile

# 生成 ctags 索引
RUN mkdir -p /root/.cache/tags
RUN /bin/bash -c "source /opt/conda/etc/profile.d/conda.sh && conda activate base && ctags -R -f /root/.cache/tags/conda_python_libs.tags --languages='python' --python-kinds='+cfmp' --exclude='*.pyc' --exclude='*.pyo' --exclude='__pycache__/*' /opt/conda/lib/python$(python -c 'import sys; print(f"{sys.version_info.major}.{sys.version_info.minor}")')/site-packages"

# 配置软连接
WORKDIR /root
RUN ln -sf /mnt/user-ssd/songxingchen/tools .
RUN ln -sf /mnt/user-ssd/songxingchen/workspace .
RUN ln -sf /mnt/user-ssd/songxingchen/share .

# 设置环境变量以便 Neovim 工作正常（可选）
ENV PATH="/usr/bin:$PATH"

# 安装 Whisperx Python 依赖
    #git+https://github.com/m-bain/whisperx.git \
#git clone https://github.com/m-bain/whisperx.git
#tar -czf whisperx.tar.gz whisperx/
#ADD whisperx.tar.gz /tmp/
#RUN /opt/conda/bin/pip config set global.timeout 300 && \
#    /opt/conda/bin/pip config set global.index-url https://mirrors.aliyun.com/pypi/simple/ && \
#    /opt/conda/bin/pip config set global.trusted-host mirrors.aliyun.com && \
#    /opt/conda/bin/pip install --no-cache-dir -i https://mirrors.aliyun.com/pypi/simple/ \
#    numpy==1.26.4 scipy && \
#    /opt/conda/bin/pip install --no-cache-dir /tmp/whisperx && \
#    /opt/conda/bin/pip install --no-cache-dir torch torchvision torchaudio --index-url https://download.pytorch.org/whl/cu121 && \
#    /opt/conda/bin/pip install --no-cache-dir pydub ffmpeg-python -i https://pypi.tuna.tsinghua.edu.cn/simple && \
#    /opt/conda/bin/pip install --no-cache-dir modelscope funasr funasr-onnx gpustat onnxconverter-common ray loguru addict datasets simplejson fastcluster umap-learn hdbscan panns-inference torchlibrosa \
#    onnxruntime-gpu --extra-index-url https://aiinfra.pkgs.visualstudio.com/PublicPackages/_packaging/onnxruntime-cuda-12/pypi/simple/
#    #/opt/conda/bin/pip install --no-cache-dir torch torchvision torchaudio --index-url https://mirror.sjtu.edu.cn/pytorch/whl/cu121 && \

# 暴露 SSH 端口
EXPOSE 22

# 启动容器时默认进入 Bash
CMD ["/bin/bash"]


## 安装配置 miniconda
#RUN wget -O /opt/Miniconda3-p310_24.3.0-Linux-x86_64.sh https://mirrors.bfsu.edu.cn/anaconda/miniconda/Miniconda3-p310_24.3.0-Linux-x86_64.sh \
#    && chmod +x /opt/Miniconda3-p310_24.3.0-Linux-x86_64.sh \
#    && /opt/Miniconda3-p310_24.3.0-Linux-x86_64.sh -b -p /opt/miniconda3
#
#RUN conda config --add channels https://mirrors.tuna.tsinghua.edu.cn/anaconda/pkgs/free/ \
#    && conda config --add channels https://mirrors.tuna.tsinghua.edu.cn/anaconda/pkgs/main/ \
#    && conda config --add channels https://mirrors.tuna.tsinghua.edu.cn/anaconda/cloud/conda-forge/ \
#    && conda config --set show_channel_urls yes \
#    && conda config --set auto_activate_base no
#
#SHELL ["conda", "run", "-n", "cv", "/bin/bash", "-c"]
#
#SHELL ["/bin/bash", "--login", "-c"]
#RUN export PATH=/opt/miniconda3/bin:$PATH \
#    && conda update --name base conda \
#    && source init bash \
#    && conda activate \
#    && conda activate cv \
#    && conda install -y --quiet numpy pyyaml mkl mkl-include setuptools cmake cffi typing \
#    && conda install -y --quiet -c mingfeima mkldnn \
#    && python -m pip install --upgrade pip -i https://pypi.tuna.tsinghua.edu.cn/simple \
#    && pip config set global.index-url https://pypi.tuna.tsinghua.edu.cn/simple \
#    && pip install torch==2.3.1 torchvision==0.18.1 torchaudio==2.3.1 --index-url https://download.pytorch.org/whl/cu118 \
#    && pip install pandas pillow matplotlib comet_ml openpyxl opencv-python torchmetrics lightning scikit-learn scikit-image albumentations segmentation-models-pytorch tensorboard easydict packaging timm einops yarl typing_extensions \
#    && pip install causal_conv1d==1.1.1 mamba-ssm==1.2.0.post1
#
#RUN mkdir -p /gemini/{code,output,logs}

