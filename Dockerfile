FROM openjdk:8u181-jdk-stretch

RUN set -x && \
    apt-get update && \
    apt-get install -y \
        apt-transport-https \
        ca-certificates \
        curl \
        gnupg2 \
        software-properties-common && \
    curl -fsSL https://download.docker.com/linux/debian/gpg | apt-key add - && \
    apt-key fingerprint 0EBFCD88 && \
    add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/debian $(lsb_release -cs) stable" && \
    apt-get update && \
    apt-get install -y \
        docker-ce && \
    curl -sL https://github.com/jpm4j/jpm4j.installers/raw/master/dist/biz.aQute.jpm.run.jar > tmp.jar && \
    export JPM_BIN_DIR=`java -jar tmp.jar -g init | grep -e "Bin[ \t]*dir" | awk '{print $3}'` && \
    rm -f tmp.jar && \
    ${JPM_BIN_DIR}/jpm install -f https://releases.liferay.com/tools/blade-cli/2.3.1.201711201552/blade.jar && \
    echo "blade installed successfully into ${JPM_BIN_DIR}/blade"

CMD ["/bin/bash"]