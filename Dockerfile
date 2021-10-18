FROM shavera/sonar-ci-base as ci-builder

COPY cpp /usr/src/slingshot_cpp
WORKDIR /usr/src/slingshot_cpp/build
COPY sonar-project.properties .
RUN mkdir -p ${BUILD_WRAPPER_OUT_DIR} && \
    cmake -G Ninja -DBUILD_CODE_COVERAGE=ON /usr/src/slingshot_cpp && \
    build-wrapper-linux-x86-64 --out-dir ${BUILD_WRAPPER_OUT_DIR} cmake --build . --target all

# Run gcovr???
# Also need env vars with github_token and sonar_token -> could work in Jenkins, less clear how it will work on dev machines, if at all

# Need to have SONAR_TOKEN env var
ARG SONAR_TOKEN
#RUN sonar-scanner --define sonar.host.url="${SONAR_SERVER_URL}" --define sonar.cfamily.build-wrapper-output="${BUILD_WRAPPER_OUT_DIR}"
WORKDIR /usr/src/slingshot_cpp
COPY sonar-project.properties /usr/src/slingshot_cpp
COPY scripts/sonarscan.sh /usr/src/slingshot_cpp/
RUN bash sonarscan.sh