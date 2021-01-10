FROM ubuntu:latest

# 必要なパッケージ取得
RUN apt-get update && apt-get install -y \
    sudo \
    wget \
    libsm6 \
    libxrender1 \
    libxext-dev

# 作業ディレクトリに移動
WORKDIR /opt
# ------------------------------------
# ■Anacondaインストール
# ①インストーラをwgetでダウンロード
# ②インストーラ起動（バッチモード, opt/anaconda3)
# ③インストーラを削除
# ④pathを通す
# ------------------------------------
RUN wget https://repo.anaconda.com/archive/Anaconda3-2020.07-Linux-x86_64.sh && \
    sh Anaconda3-2020.07-Linux-x86_64.sh -b -p /opt/anaconda3 && \
    rm -f Anaconda3-2020.07-Linux-x86_64.sh
ENV PATH /opt/anaconda3/bin:$PATH

# bashに変更
SHELL ["/bin/bash", "-c"]

# 仮想環境作成
RUN conda create -n rdkit-env python=3.6.0

# RDKit install
RUN	source activate rdkit-env && \
    conda update -n base -c defaults conda && \
    conda install -c rdkit rdkit=2018.09.1 && \
    conda install -y scikit-learn ipykernel && \
    python -m ipykernel install --user --name rdkit-env --display-name rdkit-env
