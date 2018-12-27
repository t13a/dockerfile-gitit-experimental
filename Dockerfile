ARG GITIT_IMAGE=t13a/gitit

FROM ${GITIT_IMAGE}

ARG GITIT_BOOTSTRAP_THEME_BRANCH=master
ARG GITIT_BOOTSTRAP_THEME_REPOSITORY=https://github.com/t13a/gitit-bootstrap-theme

ARG GITIT_PLUGINS_BRANCH=master
ARG GITIT_PLUGINS_REPOSITORY=https://github.com/t13a/gitit-plugins

RUN apt-get update && \
    apt-get install -y --no-install-recommends python-pip python-setuptools python-wheel unzip && \
    rm -rf /var/lib/apt/lists/* && \
    pip --no-cache-dir install plantuml && \
    git clone -b "${GITIT_PLUGINS_BRANCH}" --depth 1 "${GITIT_PLUGINS_REPOSITORY}" /opt/gitit-plugins && \
    git clone -b "${GITIT_BOOTSTRAP_THEME_BRANCH}" --depth 1 "${GITIT_BOOTSTRAP_THEME_REPOSITORY}" /opt/gitit-bootstrap-theme && \
    /opt/gitit-bootstrap-theme/build.sh

COPY rootfs /

ENTRYPOINT [ "/entrypoint-experimental.sh" ]
