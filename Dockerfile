FROM alpine:latest

ENV TERRAFORM_VERSION="0.12.20" \
    HELM_VERSION="v2.14.1"

WORKDIR /tmp

COPY --from=hashicorp/terraform:0.12.0 /bin/terraform /bin/
COPY . .

RUN apk add --no-cache curl && \
    #curl https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip > terraform_${TERRAFORM_VERSION}_linux_amd64.zip && \
    #unzip terraform_${TERRAFORM_VERSION}_linux_amd64.zip -d /bin && \
    wget -q https://storage.googleapis.com/kubernetes-helm/helm-${HELM_VERSION}-linux-amd64.tar.gz -O - | tar -xzO linux-amd64/helm > /usr/local/bin/helm && \
    chmod +x /usr/local/bin/helm && \
    #rm -f terraform_${TERRAFORM_VERSION}_linux_amd64.zip
    terraform init
