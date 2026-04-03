FROM python:3.11-slim

WORKDIR /workspace

RUN pip install --no-cache-dir \
    numpy \
    pandas \
    pyarrow \
    scikit-learn \
    matplotlib \
    awkward \
    uproot \
    vector \
    jupyterlab \
    ipykernel \
    notebook

COPY test_kalman.ipynb /workspace/test_kalman.ipynb
COPY kalman_filter.ipynb /workspace/kalman_filter.ipynb