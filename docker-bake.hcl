variable "VERSION" { default = "3.1.3" }
variable "LATEST" { default = false }

group "default" {
  targets = ["release"]
}

target "release" {
  args = { VERSION = "${VERSION}" }

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

  tags = [
    "docker.io/erlend/iperf3:${VERSION}",
    LATEST ? "docker.io/erlend/iperf3:latest" : ""
  ]

  output = ["type=registry"]
}
