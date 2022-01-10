FROM ubuntu:18.04

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        git build-essential ca-certificates curl tcsh rsync

RUN curl -O https://afni.nimh.nih.gov/pub/dist/bin/linux_openmp_64/@update.afni.binaries && \
    tcsh @update.afni.binaries -package linux_openmp_64 -bindir /opt/afni -prog_list \
    3dDeconvolve 3dTstat 3dAutomask 3dcalc 3dNLfim 3dcalc \
    model_sinewave_ap.so \
    model_diffexp.so \
    model_conv_PRF_DOG.so \
    model_conv_diffgamma.so \
    model_gammavar.so \
    model_zero.so \
    model_expMEMRI.so \
    model_conv_PRF_6_BAD.so \
    model_squarewave_apf.so \
    model_expMEMRI3.so \
    model_conv_cosine4.so \
    model_conv_PRF_6.so \
    model_demri_3.so \
    model_linplusort.so \
    model_squarewave_ap.so \
    model_diffusion.so \
    model_constant.so \
    model_convgamma.so \
    model_trnglwave_apf.so \
    model_beta.so \
    model_trnglwave_ap.so \
    model_sinewave_apf.so \
    model_conv_PRF.so \
    model_convgamma2a.so \
    model_null.so \
    model_linear.so \
    model_expr2.so \
    model_exp.so \
    model_michaelis_menton.so \
    model_quadratic.so

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