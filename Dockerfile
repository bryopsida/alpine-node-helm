FROM alpine:3.13 AS BUILD
RUN apk add --no-cache nodejs npm yarn openjdk11 curl bash openssl
RUN curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
RUN echo "9f74f2fa7ee32ad07e17211725992248470310ca1988214518806b39b1dad9f0  kubectl" > SUMS.txt && cat SUMS.txt && sha256sum kubectl && sha256sum -c SUMS.txt && rm SUMS.txt
RUN install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl
RUN kubectl version --client
RUN curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3 && chmod 700 get_helm.sh
RUN echo "2576ced018e35d016e6cf01434e123484350eb06844b0c778aae58df2394e090  get_helm.sh" > SUMS.txt && cat SUMS.txt && sha256sum -c SUMS.txt && rm SUMS.txt
RUN ./get_helm.sh
RUN helm version