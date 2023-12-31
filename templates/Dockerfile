FROM debian:bookworm-slim

RUN groupadd --gid 1000 noroot \
    && useradd \
    --create-home \
    --home-dir /home/noroot \
    --uid 1000 \
    --gid 1000 \
    # https://docs.docker.com/develop/develop-images/dockerfile_best-practices/#user
    --no-log-init noroot

RUN apt-get update && \
    apt-get install -y \
        git

USER noroot
WORKDIR /home/noroot
