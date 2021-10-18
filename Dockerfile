FROM ubuntu

RUN apt-get update
ENV DEBIAN_FRONTEND="noninteractive"
RUN apt-get -qqy install tzdata

RUN apt-get -qqy install \
    apt-utils \
    build-essential \
    curl \
    gcovr \
    gpg \
    openjdk-11-jre \
    ninja-build \
    unzip \
    wget

#install cmake from kitware apt repo
WORKDIR /tmp/kitware
RUN wget https://apt.kitware.com/kitware-archive.sh && \
    chmod +x kitware-archive.sh && \
    ./kitware-archive.sh && \
    apt-get -qqy install cmake

#    cd .. && \
#    gcovr --sonarqube sonar.xml

# Install SonarScanner & Build Wrapper
ENV SONAR_SERVER_URL="https://sonarcloud.io"
ENV SONAR_SCANNER_VERSION=4.6.1.2450
ENV SONAR_SCANNER_DOWNLOAD_URL=https://binaries.sonarsource.com/Distribution/sonar-scanner-cli/sonar-scanner-cli-${SONAR_SCANNER_VERSION}-linux.zip
ENV BUILD_WRAPPER_DOWNLOAD_URL=${SONAR_SERVER_URL}/static/cpp/build-wrapper-linux-x86.zip
ENV BUILD_WRAPPER_OUT_DIR=/usr/build/build_wrapper_output
WORKDIR /usr/.sonar
RUN curl -sSLo /usr/.sonar/sonar-scanner.zip ${SONAR_SCANNER_DOWNLOAD_URL} && \
    unzip -o /usr/.sonar/sonar-scanner.zip -d /usr/.sonar && \
    curl -sSLo /usr/.sonar/build-wrapper-linux-x86.zip ${BUILD_WRAPPER_DOWNLOAD_URL} && \
    unzip -o /usr/.sonar/build-wrapper-linux-x86.zip -d /usr/.sonar


COPY cpp /usr/src/slingshot_cpp
WORKDIR /usr/src/slingshot_cpp/build
COPY sonar-project.properties .
RUN mkdir -p ${BUILD_WRAPPER_OUT_DIR} && \
    cmake -G Ninja -DBUILD_CODE_COVERAGE=ON /usr/src/slingshot_cpp && \
    /usr/.sonar/build-wrapper-linux-x86/build-wrapper-linux-x86-64 --out-dir ${BUILD_WRAPPER_OUT_DIR} cmake --build . --target all

# Run gcovr???
# Also need env vars with github_token and sonar_token -> could work in Jenkins, less clear how it will work on dev machines, if at all

RUN /usr/.sonar/sonar-scanner-${SONAR_SCANNER_VERSION}-linux/bin/sonar-scanner --define sonar.host.url="${SONAR_SERVER_URL}" --define sonar.cfamily.build-wrapper-output="${BUILD_WRAPPER_OUT_DIR}"
