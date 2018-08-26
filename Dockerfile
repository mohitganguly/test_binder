#
# NEURON Dockerfile
#

# Pull base image.
FROM andrewosh/binder-base

MAINTAINER Alex Williams <alex.h.willia@gmail.com>

USER root

RUN \
  apt-get update && \
  apt-get install -y libncurses-dev

# Make ~/neuron directory to hold stuff.
WORKDIR neuron

# Fetch NEURON source files, extract them, delete .tar.gz file.
RUN \
  wget http://www.neuron.yale.edu/ftp/neuron/versions/v7.4/nrn-7.4.tar.gz && \
  tar -xzf nrn-7.4.tar.gz && \
  rm nrn-7.4.tar.gz

# Fetch Interviews.
# RUN \
#  wget http://www.neuron.yale.edu/ftp/neuron/versions/v7.4/iv-19.tar.gz  && \  
#  tar -xzf iv-19.tar.gz && \
#  rm iv-19.tar.gz

WORKDIR nrn-7.4

# Compile NEURON.
RUN \
  ./configure --prefix=`pwd` --without-iv --with-nrnpython=$HOME/anaconda/bin/python && \
  make && \
  make install \
  
RUN mkdir $HOME/env; mkdir $HOME/packages

		

ENV VENV=$HOME/env/neurosci

		

		

ENV NRN_VER=7.4

		

ENV NRN=nrn-$NRN_VER

		

ENV PATH=$PATH:$VENV/bin

		

		

WORKDIR $HOME/packages

		

RUN wget http://www.neuron.yale.edu/ftp/neuron/versions/v$NRN_VER/$NRN.tar.gz

		

RUN tar xzf $NRN.tar.gz; rm $NRN.tar.gz

		

		

USER root

		

		

RUN apt-get update; apt-get install -y automake libtool build-essential openmpi-bin libopenmpi-dev git vim  \

		

                       wget libncurses5-dev libreadline-dev libgsl0-dev cython3

		

		

USER $NB_USER

		

		

RUN mkdir -p $VENV; \

		

    cd $NRN; mkdir -p $VENV/bin; \

		

    $HOME/packages/$NRN/configure --with-paranrn --with-nrnpython=/usr/bin/python2 --disable-rx3d --without-iv --prefix=$VENV; \

		

    make; make install; \

		

    cd src/nrnpython; /usr/bin/python2 setup.py install; \

		

    cd $VENV/bin; ln -s ../x86_64/bin/nrnivmodl

		

		

USER main



# Switch back to non-root user privledges
WORKDIR $HOME
USER main
