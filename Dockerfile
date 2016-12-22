FROM debian:jessie

ENV GRAFANA_VERSION 4.0.2-1481203731

RUN apt-get update && \
    apt-get -y --no-install-recommends install libfontconfig curl ca-certificates git && \
    apt-get clean && \
    curl https://grafanarel.s3.amazonaws.com/builds/grafana_${GRAFANA_VERSION}_amd64.deb > /tmp/grafana.deb
    
RUN dpkg -i /tmp/grafana.deb && \
    rm /tmp/grafana.deb && \
    curl -L https://github.com/tianon/gosu/releases/download/1.7/gosu-amd64 > /usr/sbin/gosu && \
    chmod +x /usr/sbin/gosu && \
    apt-get remove -y curl && \
    apt-get autoremove -y && \
    rm -rf /var/lib/apt/lists/*

VOLUME ["/var/lib/grafana", "/var/log/grafana", "/etc/grafana"]

EXPOSE 3000

COPY ./run.sh /run.sh   

RUN git clone https://github.com/cityzendata/grafana-warp10.git

ENTRYPOINT ["/run.sh"]
