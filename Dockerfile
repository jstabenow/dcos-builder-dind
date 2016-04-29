FROM ubuntu:14.04.4

RUN apt-get -qq update && apt-get -y install \
  python3-dev \
  python3-pip \
  python3-setuptools \
  git \
  curl \
  apt-transport-https \
  ca-certificates \
  lxc \
  iptables \
  ipcalc
RUN pip3 install virtualenv

ENV DOCKER_VERSION=1.9.1
RUN curl -fLsS https://get.docker.com/ | sh
RUN wget -O docker.deb https://apt.dockerproject.org/repo/pool/main/d/docker-engine/docker-engine_${DOCKER_VERSION}-0~trusty_amd64.deb && \
    dpkg -i docker.deb

ENV WRAPPER_VERSION 0.2.4
ADD https://raw.githubusercontent.com/mesosphere/mesos-slave-dind/master/wrapdocker /usr/local/bin/
RUN chmod +x /usr/local/bin/wrapdocker
ENTRYPOINT ["/usr/local/bin/wrapdocker"]
ENV VAR_LIB_DOCKER_SIZE 16

ENV CONFIG_SHARED_PATH /root/dcos-release.config.yaml
ENV CONFIG_KIND local_path
ENV CONFIG_PREFERRED local

ENV RELEASE_ARTIFACTS_PATH /root/dcos-artifacts
ENV RELEASE_ACTION create
ENV RELEASE_CHANNEL first
ENV RELEASE_TAG build-demo

ADD ./builder /usr/local/bin/
CMD ["builder"]
