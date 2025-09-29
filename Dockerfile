# syntax = sberworks.ru/sbt_dev/ci90000011_run4c_dev/base/dockerfile:1.2 #

FROM sberworks.ru/sbt_dev/ci90000011_run4c_dev/base/maven:3.8.3-openjdk-17-cacerts as target_1

WORKDIR project/

COPY pom.xml .
COPY src/main/resources/sup2/* \
    ./src/main/resources/sup2/
RUN --mount=type=secret,id=settings,dst=/project/settings.xml \
    mvn dependency:copy-dependencies -Pcopy-deps-fix -DcopyDependencies -s /project/settings.xml && \
    touch du02.yml du01.yml

COPY . .
RUN --mount=type=secret,id=settings,dst=/project/settings.xml \
    mvn clean install -s settings.xml -U -P build-config,spring && \
    ls -la /project/target/

RUN --mount=type=secret,id=envParams,dst=/project/envs \
    --mount=type=secret,id=custom_envs,dst=/project/custom_envs \
    --mount=type=secret,id=settings,dst=/project/settings.xml \
    . ./envs && . ./custom_envs && \
    ls -la && printenv && pwd && \
    mvn sonar:sonar -s settings.xml \
        -Dsonar.projectKey=Nexus_PROD:CI02210881_AS_EFS_DEVOPS_PIPELINE \
        -Dsonar.host.url=$SONAR_HOST_URL \
        -Dsonar.login=$SONAR_TOKEN \
        -Dsonar.branch.name=develop || true

FROM scratch

WORKDIR /

COPY --from=target_1 /project/target/*.war /outputs/bh/
COPY --from=target_1 /project/du01.yml /outputs/docker/docker.du.01/
COPY --from=target_1 /project/du02.yml /outputs/docker/docker.du.02/
COPY --from=target_1 /project/target/sona[r]/* /sonar/

