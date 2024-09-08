FROM steamcmd/steamcmd:ubuntu-noble

STOPSIGNAL SIGTERM

ENV HOME=/home/avserver \
  TERM=xterm \
  DEBIAN_FRONTEND=noninteractive

RUN dpkg --add-architecture i386 && \
  apt-get update && apt-get install -y --no-install-recommends \
  jq \
  curl \
  bc \
  binutils \
  bsdmainutils \
  bzip2 \
  cpio \
  distro-info \
  file \
  iproute2 \
  lib32gcc-s1 \
  lib32stdc++6 \
  libsdl2-2.0-0:i386 \
  netcat-openbsd \
  pigz \
  python3 \
  tmux \
  unzip \
  uuid-runtime \
  wget \
  xz-utils \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/*

# Install latest su-exec
RUN  set -ex; \
     \
     curl -o /usr/local/bin/su-exec.c https://raw.githubusercontent.com/ncopa/su-exec/master/su-exec.c; \
     \
     fetch_deps='gcc libc-dev'; \
     apt-get update; \
     apt-get install -y --no-install-recommends $fetch_deps; \
     rm -rf /var/lib/apt/lists/*; \
     gcc -Wall \
         /usr/local/bin/su-exec.c -o/usr/local/bin/su-exec; \
     chown root:root /usr/local/bin/su-exec; \
     chmod 0755 /usr/local/bin/su-exec; \
     rm /usr/local/bin/su-exec.c; \
     \
     apt-get purge -y --auto-remove $fetch_deps

RUN mkdir -p /home/avserver

WORKDIR /home/avserver

RUN useradd --home-dir /home/avserver --create-home --shell /bin/bash --system avserver

COPY --chmod=755 scripts/init.sh /home/avserver/init.sh
COPY --chmod=755 scripts/server.sh /home/avserver/server.sh

RUN chmod +x /home/avserver/server.sh

ENTRYPOINT ["/home/avserver/init.sh"]
