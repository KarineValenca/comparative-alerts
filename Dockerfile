FROM labbsr0x/bb-promster:latest

ENV PILOT_VERSION ""
ADD alert-rules.yml.tmpl /etc/prometheus
