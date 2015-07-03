FROM jboss/base-jdk:7

MAINTAINER iocanel@gmail.com

ENV MAVEN_MAJOR 3
ENV MAVEN_VERSION 3.2.5
ENV DEPLOY_DIR /opt/jboss/deploy
LABEL io.s2i.scripts-url https://raw.githubusercontent.com/fabric8io/base-sti/master/.sti/bin/
LABEL io.s2i.destination /tmp
USER root

RUN curl http://www.apache.org/dist/maven/maven-$MAVEN_MAJOR/$MAVEN_VERSION/binaries/apache-maven-$MAVEN_VERSION-bin.tar.gz | tar -xzf - -C /opt/jboss \
  && mv /opt/jboss/apache-maven-$MAVEN_VERSION /opt/jboss/maven \
  && mkdir -p /opt/jboss/deploy \
  && chown -R jboss:jboss /opt/jboss \
  && chmod -R 755 /opt/jboss/maven/ \
  && ln -sf /opt/jboss/maven/bin/mvn /usr/local/bin/mvn

# Configure Source-To-Image scripts
ADD ./bin /usr/bin/

USER jboss

CMD ["/usr/bin/usage"]
