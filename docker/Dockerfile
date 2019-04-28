FROM alpine:3.9

ARG HELM_VERSION=2.13.1

RUN apk add --no-cache ca-certificates openssh git python3 \
    && wget -q https://storage.googleapis.com/kubernetes-helm/helm-v$HELM_VERSION-linux-amd64.tar.gz -O - | tar -xzO linux-amd64/helm > /usr/local/bin/helm \
    && wget -q https://github.com/helm/chart-testing/releases/download/v2.0.1/chart-testing_2.0.1_linux_amd64.tar.gz -O - | tar -xzO ct > /usr/local/bin/ct
RUN pip3 install yamale yamllint
ADD files/helm-testing.sh /usr/local/bin/helm-testing.sh
ADD files/chart_schema.yaml /etc/ct/chart_schema.yaml
ADD files/lintconf.yaml /etc/ct/lintconf.yaml
RUN chmod +x /usr/local/bin/helm \
    && chmod +x /usr/local/bin/ct \
    && chmod +x /usr/local/bin/helm-testing.sh
