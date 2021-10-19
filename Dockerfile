FROM shavera/sonar-ci-base as ci-builder

COPY . /usr/src/ci-slingshot

# Need to have SONAR_TOKEN env var
ARG SONAR_TOKEN
RUN bash /usr/src/ci-slingshot/scripts/tokencheck.sh

WORKDIR /usr/src/ci-slingshot/build
COPY sonar-project.properties .
RUN mkdir -p ${BUILD_WRAPPER_OUT_DIR}/coverage && \
    cmake -G Ninja -DBUILD_CODE_COVERAGE=ON /usr/src/ci-slingshot/cpp && \
    build-wrapper-linux-x86-64 --out-dir ${BUILD_WRAPPER_OUT_DIR} cmake --build . --target all && \
    ctest && \
    cd .. && \
    gcovr --sonarqube ${BUILD_WRAPPER_OUT_DIR}/coverage.xml

WORKDIR /usr/src/ci-slingshot
RUN bash scripts/sonarscan.sh
