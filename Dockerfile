FROM ubuntu as builder

RUN apt-get update
RUN DEBIAN_FRONTEND="noninteractve" apt-get -qqy install tzdata

RUN apt-get -qqy install \
    apt-utils \
    build-essential \
    gpg \
    wget

#install cmake from kitware apt repo
WORKDIR /tmp/kitware
RUN wget https://apt.kitware.com/kitware-archive.sh && \
    chmod +x kitware-archive.sh && \
    ./kitware-archive.sh && \
    apt-get -qqy install cmake

RUN apt-get -qqy install ninja-build
COPY cpp /usr/src/slingshot_cpp
WORKDIR /usr/src/slingshot_cpp/build
RUN cmake -G Ninja -DBUILD_CODE_COVERAGE=ON /usr/src/slingshot_cpp && \
    cmake --build . --target all

 # Explicitly going to make this about CI docker image below
FROM builder as ci
RUN apt-get -qqy install gcovr && \
    cd .. && \
    gcovr --sonarqube sonar.xml
