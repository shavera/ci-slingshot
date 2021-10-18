FROM shavera/sonar-ci-base as ci-builder

COPY . /usr/src/ci-slingshot
WORKDIR /usr/src/ci-slingshot/build
COPY sonar-project.properties .
RUN mkdir -p ${BUILD_WRAPPER_OUT_DIR}/coverage && \
    cmake -G Ninja -DBUILD_CODE_COVERAGE=ON /usr/src/ci-slingshot/cpp && \
    build-wrapper-linux-x86-64 --out-dir ${BUILD_WRAPPER_OUT_DIR} cmake --build . --target all && \
    ctest && \
    cd ${BUILD_WRAPPER_OUT_DIR}/coverage && \
    gcov /usr/src/ci-slingshot/cpp/calculator/Dummy.cpp /usr/src/ci-slingshot/build/calculator/CMakeFiles/orbit_calculator.dir/Dummy.cpp.o
#    gcovr --sonarqube ${BUILD_WRAPPER_OUT_DIR}/coverage.xml

# Run ctest??? gcovr???

# Need to have SONAR_TOKEN env var
ARG SONAR_TOKEN
WORKDIR /usr/src/ci-slingshot
RUN bash scripts/sonarscan.sh
