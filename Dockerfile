# Date:   2020-10-05
# Examples:
#         docker build -t terminal:latest -f Dockerfile .
#         docker run --rm -p 1313:1313 -e SITE_NAME=terminalGetApi terminal:latest
ARG FROM_IMAGE=fedora
ARG FROM_TAG=latest
FROM ${FROM_IMAGE}:${FROM_TAG}
LABEL maintainer="thesystemninjaneer@gmail.com"
ARG SITE_NAME=terminalGetApi
ENV HUGO_VERSION 0.69.0

RUN dnf install -y hugo-$HUGO_VERSION && \
    dnf clean all

COPY . /repo/
WORKDIR /repo

CMD echo 'Creating Hugo Site' && \
    { [[ ! -d $SITE_NAME ]] && hugo new site $SITE_NAME || true; } && \
    cd $SITE_NAME && \
    hugo serve --disableFastRender --bind 0.0.0.0

EXPOSE 1313
