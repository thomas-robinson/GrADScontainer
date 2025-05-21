FROM spack/centos7
RUN sed -i -e '/^mirrorlist/d;/^#baseurl=/{s,^#,,;s,/mirror,/vault,;}' /etc/yum.repos.d/CentOS*.repo

RUN yum update -y && yum install -y libpng wget git python3 gcc \
 && yum clean all

ENV SPACK_PYTHON /bin/python3
RUN yum install -y which
# Setup environment
RUN yum install -y libpciaccess hwloc libgeotiff cairo python libX11 libXmu
RUN yum install -y bzip2 curl cmake perl zstd libaec netcdf shapelib libtiff

WORKDIR /grads
RUN wget http://cola.gmu.edu/grads/2.1/grads-2.1.0-bin-CentOS5.11-x86_64.tar.gz \
 && tar xf grads-2.1.0-bin-CentOS5.11-x86_64.tar.gz

RUN cd /usr/lib64/ \
 && ln -sf /usr/lib64/libssl.so.10 libssl.so.6 \
 && ln -sf /usr/lib64/libcrypto.so.10 libcrypto.so.6 \
 && ln -sf libtiff.so.5 libtiff.so.3 \
 && ln -sf libgeotiff.so.1.2.5 libgeotiff.so
# && mkdir -p /usr/local/lib/grads \
# && touch /usr/local/lib/grads/udpt \
# && echo 'gxdisplay  Cairo    /usr/lib64/libcairo.so.2' >> /usr/local/lib/grads/udpt \
# && echo 'gxprint    Cairo    /usr/lib64/libcairo.so.2' >> /usr/local/lib/grads/udpt

WORKDIR /usr/local/lib/grads/ 
RUN wget http://cola.gmu.edu/grads/data2.tar.gz \ 
 && tar xvfz data2.tar.gz  

#double check and ensure GrADS knows where to find files
ENV GADDIR /usr/local/lib/grads

#Set PATH to include grads bin
ENV PATH {$PATH}:/grads/grads-2.1.0/bin

#Copy over test directory 
WORKDIR /grads
COPY run_this.sh .
COPY ./testdir testdir/

ENTRYPOINT [ "/bin/bash" ]

#ENTRYPOINT [ "/grads/grads-2.2.1/bin/grads" ]
# grads-2.1.0/bin/grads -bcl help
