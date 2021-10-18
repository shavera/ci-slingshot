FROM shavera/sonar-ci-base as ci-builder

COPY cpp /usr/src/slingshot_cpp
WORKDIR /usr/src/slingshot_cpp/build
COPY sonar-project.properties .
RUN mkdir -p ${BUILD_WRAPPER_OUT_DIR} && \
    cmake -G Ninja -DBUILD_CODE_COVERAGE=ON /usr/src/slingshot_cpp && \
    /usr/.sonar/build-wrapper-linux-x86/build-wrapper-linux-x86-64 --out-dir ${BUILD_WRAPPER_OUT_DIR} cmake --build . --target all

# Run gcovr???
# Also need env vars with github_token and sonar_token -> could work in Jenkins, less clear how it will work on dev machines, if at all

RUN /usr/.sonar/sonar-scanner-${SONAR_SCANNER_VERSION}-linux/bin/sonar-scanner --define sonar.host.url="${SONAR_SERVER_URL}" --define sonar.cfamily.build-wrapper-output="${BUILD_WRAPPER_OUT_DIR}"
