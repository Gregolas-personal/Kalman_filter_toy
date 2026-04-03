FROM condaforge/miniforge3:24.11.3-0

SHELL ["/bin/bash", "-lc"]

RUN conda install -y -c conda-forge \
    python=3.11 \
    root \
    pythia8 \
    make \
    cmake \
    compilers \
    git \
    wget \
    && conda clean -afy

WORKDIR /opt

ENV PYTHIA8=/opt/conda
ENV PYTHIA8DATA=/opt/conda/share/Pythia8/xmldoc
ENV CPATH=/opt/conda/aarch64-conda-linux-gnu/sysroot/usr/include

RUN git clone --depth 1 --branch 3.5.1 https://github.com/delphes/delphes.git && \
    cd delphes && \
    make HAS_PYTHIA8=true -j"$(nproc)"

ENV DELPHES_DIR=/opt/delphes
ENV PATH=/opt/delphes:$PATH

WORKDIR /workspace
