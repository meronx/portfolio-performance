# Use base image
FROM jlesage/baseimage-gui:ubuntu-26.04-v4

# Set labels
LABEL \
    maintainer="Community" \
    org.opencontainers.image.authors="github.com/meronx" \
    org.opencontainers.image.description="Financial asset & investment web tracking tool" \
    org.opencontainers.image.documentation="https://github.com/meronx/portfolio-performance" \
    org.opencontainers.image.source="https://github.com/meronx/portfolio-performance" \
    org.opencontainers.image.title="Portfolio Performance" \
    org.opencontainers.image.url="https://github.com/meronx/portfolio-performance" \
    org.opencontainers.image.vendor="Community"

# Define build arguments
ARG ARCH
ARG APP_VERSION

# Set environment variables
ENV APP_NAME="Portfolio Performance" \
    APP_VERSION=$APP_VERSION \
    DOCKER_IMAGE_VERSION=$APP_VERSION

# Install dependencies and application icon
RUN add-pkg \
        curl \
        openjdk-25-jre \
        libwebkit2gtk-4.1-0 && \
    install_app_icon.sh "https://www.portfolio-performance.info/images/logo.png"

# Download, extract, and configure the application
RUN set -e && \
    if [ -z "$APP_VERSION" ]; then echo "APP_VERSION not set"; exit 1; fi && \
    if [ -z "$ARCH" ]; then echo "ARCH not set"; exit 1; fi && \
    curl -L -o "/opt/PortfolioPerformance-${APP_VERSION}-linux.gtk.${ARCH}.tar.gz" "https://github.com/buchen/portfolio/releases/download/${APP_VERSION}/PortfolioPerformance-${APP_VERSION}-linux.gtk.${ARCH}.tar.gz" && \
    tar xvzf "/opt/PortfolioPerformance-${APP_VERSION}-linux.gtk.${ARCH}.tar.gz" -C /opt && \
    rm "/opt/PortfolioPerformance-${APP_VERSION}-linux.gtk.${ARCH}.tar.gz" && \
    chmod -R 777 /opt/portfolio && \
    echo "-data\n/config/portfolio\n$(cat /opt/portfolio/PortfolioPerformance.ini)" > /opt/portfolio/PortfolioPerformance.ini

# Copy run script
COPY rootfs/ /
