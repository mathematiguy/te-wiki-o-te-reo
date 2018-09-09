FROM jupyter/scipy-notebook:2c80cf3537ca

# Use sudo
USER root

# Download the NLTK corpora
RUN pip install nltk==3.3
RUN python -m nltk.downloader all

# Install requirements.txt
COPY requirements.txt /root/requirements.txt
RUN pip install -r /root/requirements.txt

# Update taumahi library
RUN pip install git+http://github.com/TeHikuMedia/nga-kupu.git@11b465b426c4abc791ad86646c0fdd833a790dd6#egg=taumahi

# Login as $NB_UID
USER $NB_UID
