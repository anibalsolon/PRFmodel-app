FROM ubuntu:18.04

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        git build-essential ca-certificates curl tcsh rsync

RUN curl -O https://afni.nimh.nih.gov/pub/dist/bin/linux_openmp_64/@update.afni.binaries && \
    tcsh @update.afni.binaries -package linux_openmp_64 -bindir /opt/afni -prog_list \
    3dDeconvolve 3dTstat 3dAutomask 3dcalc 3dNLfim 3dcalc

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        libxext-dev libxpm-dev libxmu-dev libxt6 libxft2 

RUN curl -LO http://ftp.debian.org/debian/pool/main/libx/libxp/libxp6_1.0.2-2_amd64.deb && \
    curl -LO http://mirrors.kernel.org/ubuntu/pool/main/libp/libpng/libpng12-0_1.2.54-1ubuntu1_amd64.deb && \
    apt-get install ./libxp6_1.0.2-2_amd64.deb ./libpng12-0_1.2.54-1ubuntu1_amd64.deb && \
    rm ./libxp6_1.0.2-2_amd64.deb ./libpng12-0_1.2.54-1ubuntu1_amd64.deb

ENV PATH=$PATH:/opt/afni

# Run the command for validation
RUN 3dDeconvolve 2>&1 > /dev/null
RUN 3dTstat 2>&1 > /dev/null
RUN 3dAutomask 2>&1 > /dev/null
RUN 3dcalc 2>&1 > /dev/null
RUN 3dNLfim 2>&1 > /dev/null
RUN 3dcalc 2>&1 > /dev/null

RUN mkdir /scratch
WORKDIR /scratch