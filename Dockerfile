# syntax = docker/dockerfile:1.3-labs
From k8s.gcr.io/descheduler/descheduler:v0.24.1

FROM debian:stable-slim

COPY --from=0 /bin/descheduler /bin/descheduler

RUN apt-get update; apt-get install curl -y

COPY <<EOF /run.sh
#!/bin/sh
### made by rayman@rhems-japan.co.jp
/bin/descheduler --policy-config-file /policy-dir/policy.yaml --v 3
curl -fsS -m 10 --retry 5 \$BADGE_PING
EOF

RUN chmod +x /run.sh

USER 1000

CMD [ "/run.sh" ]
