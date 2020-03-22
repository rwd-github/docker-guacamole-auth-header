FROM guacamole/guacamole:latest

RUN mkdir -p /root/download/guacamole-auth-header
RUN myGuacVer=$(ls /opt/guacamole/postgresql/guacamole-auth-jdbc-postgresql-*.jar|sed 's/.*-\([0-9\.]*\)\.jar/\1/') \
	&& echo "Guacamole-Version: ${myGuacVer}" \
	&& curl -sL "http://apache.org/dyn/closer.cgi?action=download&filename=guacamole/${myGuacVer}/binary/guacamole-auth-header-${myGuacVer}.tar.gz" --output /root/download/guacamole-auth-header-${myGuacVer}.tar.gz \
	&& cd /root/download \
	&& tar -xzf guacamole-auth-header-${myGuacVer}.tar.gz \
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
