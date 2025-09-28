FROM syepes/network_exporter:latest

WORKDIR /app/cfg

COPY network_exporter.yml.template ./network_exporter.yml.template
COPY replace_hosts.sh ./replace_hosts.sh

RUN chmod +x ./replace_hosts.sh && apk add --no-cache bash bind-tools

CMD /app/cfg/replace_hosts.sh && /app/network_exporter --config.file=/app/cfg/network_exporter.yml