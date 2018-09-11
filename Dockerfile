FROM jupyter/scipy-notebook:2c80cf3537ca

# Use sudo
USER root

# Download the NLTK corpora
RUN pip install nltk==3.3
RUN python -m nltk.downloader all

# Install requirements.txt
COPY requirements.txt /root/requirements.txt
RUN pip install -r /root/requirements.txt

# Update jupyter extensions
RUN jupyter labextension update @jupyterlab/hub-extension
RUN jupyter labextension update @jupyter-widgets/jupyterlab-manager

# Update taumahi library
RUN pip install git+http://github.com/TeHikuMedia/nga-kupu.git@206510e241495de25b6892467ca47416fc845a68#egg=taumahi

# Login as $NB_UID
USER $NB_UID
