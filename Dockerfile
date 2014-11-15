FROM jboss/base-jdk:7

MAINTAINER iocanel@gmail.com

ENV MAVEN_MAJOR 3
ENV MAVEN_VERSION 3.2.3
ENV DEPLOY_DIR /opt/jboss/deploy
USER root

RUN yum -y install wget \
  && wget -q -O - http://www.us.apache.org/dist/maven/maven-$MAVEN_MAJOR/$MAVEN_VERSION/binaries/apache-maven-$MAVEN_VERSION-bin.tar.gz | tar -xzf - -C /opt/jboss \
  && mv /opt/jboss/apache-maven-$MAVEN_VERSION /opt/jboss/maven \
  && mkdir -p /opt/jboss/deploy \
  && chown -R jboss:jboss /opt/jboss \
  && chmod -R 775 /opt/jboss/maven/ \
  && ln -sf /opt/jboss/maven/bin/mvn /usr/local/bin/mvn

# Configure Source-To-Image scripts
ADD ./bin /usr/bin/

VOLUME ["/opt/maven/repository"]

USER jboss

CMD ["/usr/bin/sti-helper"]
