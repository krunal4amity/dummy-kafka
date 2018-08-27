FROM openjdk:8-jdk
COPY --chown=755 start.sh /tmp
COPY sample.xml /tmp
COPY sample2.xml /tmp
COPY mysec.xml /tmp
RUN apt-get update && \
	apt-get install dos2unix -y && \
	apt-get clean all
RUN wget -q -O - https://jenkins-ci.org/debian/jenkins-ci.org.key | apt-key add - && \
	sh -c 'echo deb http://pkg.jenkins-ci.org/debian binary/ > /etc/apt/sources.list.d/jenkins.list' && \
	apt-get update && \
	apt-get install jenkins -y && \
	apt-get clean all && \
	dos2unix /tmp/start.sh /tmp/mysec.xml /tmp/sample.xml /tmp/sample2.xml && \
	chmod 755 /tmp/start.sh
RUN curl -fsSL https://get.docker.com | sh && \
	curl -L https://github.com/docker/compose/releases/download/1.22.0-rc2/docker-compose-`uname -s`-`uname -m` -o /usr/bin/docker-compose && \
    chmod +x /usr/bin/docker-compose
CMD /tmp/start.sh
	