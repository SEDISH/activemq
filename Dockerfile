FROM uwitech/ohie-base

# Install JDK 8
RUN apt-get update
RUN apt-get install -y build-essential wget software-properties-common

RUN \
  echo oracle-java8-installer shared/accepted-oracle-license-v1-1 select true | debconf-set-selections && \
  add-apt-repository -y ppa:webupd8team/java && \
  apt-get update && \
  apt-get install -y oracle-java8-installer && \
  rm -rf /var/lib/apt/lists/* && \
  rm -rf /var/cache/oracle-jdk8-installer

RUN wget http://archive.apache.org/dist/activemq/5.10.0/apache-activemq-5.10.0-bin.tar.gz -O activemq.tar.gz
RUN tar zxvf activemq.tar.gz
RUN mv apache-activemq** activemq

COPY activemq.xml /activemq/conf/activemq.xml

EXPOSE 61616
EXPOSE 8161

VOLUME /activemq/data
VOLUME /activemq/conf

COPY cmd.sh /cmd.sh
RUN chmod +x /cmd.sh

# Launch Activemq
CMD /cmd.sh
