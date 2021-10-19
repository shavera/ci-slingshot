FROM shavera/sonar-ci-base as ci-builder

COPY . /usr/src/ci-slingshot

WORKDIR /usr/src/ci-slingshot/build
COPY sonar-project.properties .
RUN mkdir -p ${BUILD_WRAPPER_OUT_DIR}/coverage && \
    cmake -G Ninja -DBUILD_CODE_COVERAGE=ON /usr/src/ci-slingshot/cpp && \
    build-wrapper-linux-x86-64 --out-dir ${BUILD_WRAPPER_OUT_DIR} cmake --build . --target all && \
    ctest && \
    cd .. && \
    gcovr --sonarqube ${BUILD_WRAPPER_OUT_DIR}/coverage.xml

# Need to have SONAR_TOKEN env var
ARG SONAR_TOKEN
WORKDIR /usr/src/ci-slingshot
RUN bash scripts/sonarscan.sh
