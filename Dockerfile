FROM jupyter/scipy-notebook:bde52ed89463

		

		

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
