FROM jupyter/scipy-notebook:2c80cf3537ca

# Use sudo
USER root

# Download the NLTK corpora
RUN pip install nltk==3.3
RUN python -m nltk.downloader all

# Install requirements.txt
COPY requirements.txt /root/requirements.txt
RUN pip install -r /root/requirements.txt

# Login as $NB_UID
USER $NB_UID
