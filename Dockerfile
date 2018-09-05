FROM jupyter/scipy-notebook:2c80cf3537ca

# Use sudo
USER root

# Install requirements.txt
COPY requirements.txt /root/requirements.txt
RUN pip install -r /root/requirements.txt

# Download the NLTK corpora
RUN python -m nltk.downloader all

# Login as $NB_UID
USER $NB_UID
