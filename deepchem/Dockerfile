FROM deepchemio/deepchem:2.4.0
# bashを指定
SHELL ["/bin/bash", "-c"]

# 仮想環境起動
RUN source activate deepchem &&\
    conda update -n base -c defaults conda &&\
    conda install -c conda-forge jupyterlab &&\
    ipython kernel install --user --name=deepchem --display-name=deepchem-env

WORKDIR /work
