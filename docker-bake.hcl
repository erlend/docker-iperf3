group "default" {
  targets = ["release"]
}

target "release" {
  tags = ["docker.io/erlend/iperf3:latest"]
  platforms = [
    "linux/386",
    "linux/amd64",
    "linux/arm/v5",
    "linux/arm/v7",
    "linux/arm64/v8",
    "linux/mips64le",
    "linux/ppc64le",
    "linux/s390x"
  ]
}