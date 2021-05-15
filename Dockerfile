FROM docker/compose:1.29.0

# Install Tools
RUN set -x && \
  # Install common tools
  apk add --no-cache libintl curl openssl bash net-tools iputils openssh-client make && \
  # Install yq
  apk add --no-cache yq --repository=http://dl-cdn.alpinelinux.org/alpine/edge/community && \
  # Install envsubst
  apk add --virtual envsubst_deps gettext && \
  cp /usr/bin/envsubst /usr/local/bin/envsubst && \
  apk del envsubst_deps

# Install Kubectl
RUN curl -LO "https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl" && \
  chmod +x ./kubectl && \
  mv ./kubectl /usr/local/bin/kubectl

# Install Helm
RUN curl https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3 | sh