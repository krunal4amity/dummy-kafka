FROM openjdk:11-jre
MAINTAINER Krunal Shimpi <krunal.shimpi@globant.com>
COPY kafka.rb /opt
RUN apt-get update && \
	apt-get install curl -y && \
	curl https://omnitruck.chef.io/install.sh | bash -s -- -P chefdk -c stable -v 2.5.3 && \
	apt-get clean all
EXPOSE 2181
EXPOSE 9092
CMD chef-client --local-mode /opt/kafka.rb && tail -f /dev/null