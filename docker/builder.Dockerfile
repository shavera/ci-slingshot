FROM local/project-base

RUN apt-get -qqy install \
    build-essential \
    gpg \
    ninja-build \
    wget

#install cmake from kitware apt repo
WORKDIR /tmp/kitware
RUN wget https://apt.kitware.com/kitware-archive.sh && \
    chmod +x kitware-archive.sh && \
    ./kitware-archive.sh && \
    apt-get -qqy install cmake

WORKDIR /usr/bin/ci-slingshot
COPY scripts/build-project.sh .
RUN chmod +x build-project.sh

ENTRYPOINT ./build-project.sh