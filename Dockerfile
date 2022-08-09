FROM debian:latest AS build

# Install build dependencies
RUN apt-get update && \
    apt-get install --yes --no-install-recommends \
      build-essential \
      ca-certificates \
      curl \
      && \
    rm -rf /var/lib/apt/lists/*

# Download and extract source code
ARG VERSION=3.11
RUN curl -L https://github.com/esnet/iperf/archive/refs/tags/$VERSION.tar.gz \
    | tar zx

# Compile the application
RUN cd iperf-$VERSION && ./configure --prefix=/usr && make install

# Copy iperf and required libraries to /out
RUN iperf=$(which iperf3) && \
    for file in $(ldd $iperf | egrep -o '/\S*'); do \
      out="/out$file" && \
      mkdir --parents "$(dirname $out)" && \
      cp "$file" "$out"; \
    done && \
    cp "$iperf" /out/ && \
    mkdir --parents --mode=777 /out/tmp

# Create release image
FROM scratch
COPY --from=build /out /

# Expose server port
EXPOSE 5201

# Start the server by default
ENTRYPOINT ["/iperf3"]
CMD ["--server"]
