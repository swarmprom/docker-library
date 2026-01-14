FROM docker.io/grafana/grafana:11.6.1 AS grafana

FROM base
ADD rootfs /

# https://github.com/grafana/grafana/blob/main/Dockerfile
ARG GF_UID="472"
ARG GF_GID="0"

ENV PATH="/usr/share/grafana/bin:$PATH" \
    GF_PATHS_CONFIG="/etc/grafana/grafana.ini" \
    GF_PATHS_DATA="/var/lib/grafana" \
    GF_PATHS_HOME="/usr/share/grafana" \
    GF_PATHS_LOGS="/var/log/grafana" \
    GF_PATHS_PLUGINS="/var/lib/grafana/plugins" \
    GF_PATHS_PROVISIONING="/etc/grafana/provisioning"

WORKDIR $GF_PATHS_HOME

# Install dependencies
RUN if grep -i -q alpine /etc/issue; then \
    apk add --no-cache ca-certificates bash curl tzdata musl-utils && \
    apk info -vv | sort; \
    elif grep -i -q ubuntu /etc/issue; then \
    DEBIAN_FRONTEND=noninteractive && \
    apt-get update && \
    apt-get install -y ca-certificates curl tzdata musl && \
    apt-get autoremove -y && \
    rm -rf /var/lib/apt/lists/*; \
    else \
    echo 'ERROR: Unsupported base image' && /bin/false; \
    fi

# glibc support for alpine x86_64 only
# docker run --rm --env STDOUT=1 sgerrand/glibc-builder 2.40 /usr/glibc-compat > glibc-bin-2.40.tar.gz
ARG GLIBC_VERSION=2.40

RUN if grep -i -q alpine /etc/issue && [ `arch` = "x86_64" ]; then \
    wget -qO- "https://dl.grafana.com/glibc/glibc-bin-$GLIBC_VERSION.tar.gz" | tar zxf - -C / \
    usr/glibc-compat/lib/ld-linux-x86-64.so.2 \
    usr/glibc-compat/lib/libc.so.6 \
    usr/glibc-compat/lib/libdl.so.2 \
    usr/glibc-compat/lib/libm.so.6 \
    usr/glibc-compat/lib/libpthread.so.0 \
    usr/glibc-compat/lib/librt.so.1 \
    usr/glibc-compat/lib/libresolv.so.2 && \
    mkdir /lib64 && \
    ln -s /usr/glibc-compat/lib/ld-linux-x86-64.so.2 /lib64; \
    fi

COPY --from=grafana /usr/share/grafana /usr/share/grafana

RUN if [ ! $(getent group "$GF_GID") ]; then \
    if grep -i -q alpine /etc/issue; then \
    addgroup -S -g $GF_GID grafana; \
    else \
    addgroup --system --gid $GF_GID grafana; \
    fi; \
    fi && \
    GF_GID_NAME=$(getent group $GF_GID | cut -d':' -f1) && \
    mkdir -p "$GF_PATHS_HOME/.aws" && \
    if grep -i -q alpine /etc/issue; then \
    adduser -S -u $GF_UID -G "$GF_GID_NAME" grafana; \
    else \
    adduser --system --uid $GF_UID --ingroup "$GF_GID_NAME" grafana; \
    fi && \
    mkdir -p "$GF_PATHS_PROVISIONING/datasources" \
    "$GF_PATHS_PROVISIONING/dashboards" \
    "$GF_PATHS_PROVISIONING/notifiers" \
    "$GF_PATHS_PROVISIONING/plugins" \
    "$GF_PATHS_PROVISIONING/access-control" \
    "$GF_PATHS_PROVISIONING/alerting" \
    "$GF_PATHS_LOGS" \
    "$GF_PATHS_PLUGINS" \
    "$GF_PATHS_DATA" && \
    cp conf/sample.ini "$GF_PATHS_CONFIG" && \
    cp conf/ldap.toml /etc/grafana/ldap.toml && \
    chown -R "grafana:$GF_GID_NAME" "$GF_PATHS_DATA" "$GF_PATHS_HOME/.aws" "$GF_PATHS_LOGS" "$GF_PATHS_PLUGINS" "$GF_PATHS_PROVISIONING" && \
    chmod -R 777 "$GF_PATHS_DATA" "$GF_PATHS_HOME/.aws" "$GF_PATHS_LOGS" "$GF_PATHS_PLUGINS" "$GF_PATHS_PROVISIONING"

COPY --from=grafana /run.sh /etc/s6-overlay/s6-rc.d/grafana/run

RUN mkdir -p /etc/grafana/dashboards
