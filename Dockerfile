FROM jupyter/scipy-notebook:2c80cf3537ca

USER root

COPY requirements.txt /root/requirements.txt
RUN pip install -r /root/requirements.txt

RUN python -m nltk.downloader all

USER $NB_UID