FROM guacamole/guacamole:latest

ENV guacamole_version 1.1.0
RUN mkdir -p /root/download
ADD http://apache.org/dyn/closer.cgi?action=download&filename=guacamole/${guacamole_version}/binary/guacamole-auth-header-${guacamole_version}.tar.gz /root/download/guacamole-auth-header-${guacamole_version}.tar.gz
RUN cd /root/download && tar xfz guacamole-auth-header-${guacamole_version}.tar.gz

RUN mkdir -p /root/.guacamole/extensions \
	&& ln -s /root/download/guacamole-auth-header-${guacamole_version}/guacamole-auth-header-${guacamole_version}.jar /root/.guacamole/extensions/1-guacamole-auth-header-${guacamole_version}.jar
	
