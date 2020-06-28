ARG GITIT_IMAGE=t13a/gitit:0.13.0.0

FROM ${GITIT_IMAGE}

ARG GITIT_BOOTSTRAP_THEME_BRANCH=v0.1.0
ARG GITIT_BOOTSTRAP_THEME_REPOSITORY=https://github.com/t13a/gitit-bootstrap-theme

ARG GITIT_PLUGINS_BRANCH=v0.2.0
ARG GITIT_PLUGINS_REPOSITORY=https://github.com/t13a/gitit-plugins

RUN apt-get update \
    && apt-get install -y --no-install-recommends \
        ca-certificates \
        curl \
        python-pip \
        python-setuptools \
        python-wheel \
        unzip \
    && rm -rf /var/lib/apt/lists/* \
    && pip --no-cache-dir install plantuml \
    && git clone \
        -b "${GITIT_PLUGINS_BRANCH}" \
        --depth 1 \
        "${GITIT_PLUGINS_REPOSITORY}" \
        /opt/gitit-plugins \
    && git clone \
        -b "${GITIT_BOOTSTRAP_THEME_BRANCH}" \
        --depth 1 \
        "${GITIT_BOOTSTRAP_THEME_REPOSITORY}" \
        /opt/gitit-bootstrap-theme \
    && /opt/gitit-bootstrap-theme/build.sh

COPY rootfs /

