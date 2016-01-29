FROM java:8-jdk
MAINTAINER Jacob Marshall <jacob@manage.net.nz>

ENV INTELLIJ_IDEA_VERSION 15.0.3
ENV INTELLIJ_IDEA_URL https://d1opms6zj7jotq.cloudfront.net/idea
ENV INTELLIJ_IDEA_HOME .IdeaIC15

RUN useradd -m -s /bin/bash developer && \
    mkdir -p "/home/developer/${INTELLIJ_IDEA_HOME}" && \
    chown -R developer:developer /home/developer

WORKDIR /opt

RUN apt-get update && apt-get install -y --no-install-recommends ca-certificates curl git && \
    rm -rf /var/lib/apt/lists/*

RUN curl -SLO "${INTELLIJ_IDEA_URL}/ideaIC-${INTELLIJ_IDEA_VERSION}.tar.gz" && \
    tar -xzf "ideaIC-${INTELLIJ_IDEA_VERSION}.tar.gz" && \
    mv idea-IC-*/ intellij-idea-community/ && \
    rm "ideaIC-${INTELLIJ_IDEA_VERSION}.tar.gz"

USER developer

ENTRYPOINT ["intellij-idea-community/bin/idea.sh"]
