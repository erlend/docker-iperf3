FROM debian:latest AS install

# Install iperf3
RUN apt-get update && \
    apt-get install --yes --no-install-recommends iperf3 && \
    rm -rf /var/lib/apt/lists/*

FROM install AS prepare

# Copy iperf and required libraries to /out
RUN iperf=$(which iperf3) && \
    for file in $(ldd $iperf | egrep -o '/\S*'); do \
      out="/out$file" && \
      mkdir --parents "$(dirname $out)" && \
      cp "$file" "$out"; \
    done && \
    cp "$iperf" /out/ && \
    mkdir --parents --mode=777 /out/tmp

FROM scratch
COPY --from=prepare /out /

# Expose server port
EXPOSE 5201

# Start the server by default
ENTRYPOINT ["/iperf3"]
CMD ["--server"]
