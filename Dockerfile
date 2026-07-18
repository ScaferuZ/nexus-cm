ARG NEXUS_VERSION=3.94.0
FROM sonatype/nexus3:${NEXUS_VERSION}

LABEL org.opencontainers.image.title="Nexus Repository with GCS support"
LABEL org.opencontainers.image.description="Pinned Nexus image containing the bundled Google Cloud blob-store plugin"

USER root

RUN unzip -l /opt/sonatype/nexus/bin/sonatype-nexus-repository-*.jar \
| grep -q "BOOT-INF/lib/nexus-blobstore-google-cloud-"

USER nexus
