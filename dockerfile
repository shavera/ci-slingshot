FROM alpine as builder

RUN apk add --update --no-cache \
    build-base \
    cmake \
    git \
    linux-headers \
    ninja 

 COPY cpp /usr/src/slingshot_cpp
 WORKDIR /usr/build/slingshot_cpp
 RUN cmake -G Ninja /usr/src/slingshot_cpp && \
     cmake --build . --target all 