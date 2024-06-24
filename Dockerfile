# Use minimal base image
FROM jlesage/baseimage-gui:ubuntu-22.04-v4

# Define build arguments
ARG ARCH
ARG BUILD_DATE
ARG APP_VERSION
ARG APP_NAME="Portfolio Performance"
ARG APP_ICON_URL=https://www.portfolio-performance.info/images/logo.png
ARG APP_PACKAGE=PortfolioPerformance-${APP_VERSION}-linux.gtk.${ARCH}.tar.gz

# Set labels for the image
LABEL \
    maintainer="Community" \
    org.opencontainers.image.authors="github.com/meronx" \
    org.opencontainers.image.created=$BUILD_DATE \
    org.opencontainers.image.description="Financial asset & investment web tracking tool" \
    org.opencontainers.image.documentation="https://github.com/meronx/portfolio-performance" \
    org.opencontainers.image.source="https://github.com/meronx/portfolio-performance" \
    org.opencontainers.image.title="Portfolio Performance" \
    org.opencontainers.image.url="https://github.com/meronx/portfolio-performance" \
    org.opencontainers.image.vendor="Community"

# Install dependencies in one RUN command to reduce layers and clean up
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        curl \
        openjdk-21-jre \
        libwebkit2gtk-4.1-0 && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Download and extract the application
RUN set -e && \
    cd /opt && \
    if [ -z "$APP_VERSION" ]; then echo "APP_VERSION not set"; exit 1; fi && \
    if [ -z "$ARCH" ]; then echo "ARCH not set"; exit 1; fi && \
    curl -L -o $APP_PACKAGE https://github.com/buchen/portfolio/releases/download/${APP_VERSION}/${APP_PACKAGE} && \
    tar xvzf $APP_PACKAGE && \
    rm $APP_PACKAGE && \
    echo "-data\n/config/portfolio\n$(cat /opt/portfolio/PortfolioPerformance.ini)" > /opt/portfolio/PortfolioPerformance.ini && \
    chmod -R 777 /opt/portfolio && \
    curl -L -o /usr/share/icons/portfolio.png $APP_ICON_URL

# Copy run script
COPY rootfs/ /