FROM guacamole/guacamole:latest

ENV guacamole_version 1.1.0
RUN mkdir -p /root/download/guacamole-auth-header
ADD http://apache.org/dyn/closer.cgi?action=download&filename=guacamole/${guacamole_version}/binary/guacamole-auth-header-${guacamole_version}.tar.gz /root/download/guacamole-auth-header-${guacamole_version}.tar.gz
RUN cd /root/download \
	&& tar -xzf guacamole-auth-header-${guacamole_version}.tar.gz \
        -C "/root/download/guacamole-auth-header"          \
        --wildcards                                        \
        --no-anchored                                      \
        --no-wildcards-match-slash                         \
        --strip-components=1                               \
        "*.jar"

ADD start.sh.patch /root/
RUN apt-get update && apt-get install -yq patch && rm -rf /var/lib/apt/lists/*  \
	&& cd /opt/guacamole/bin \
	&& patch start.sh /root/start.sh.patch
