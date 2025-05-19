# docker buildx bake --provenance=false --sbom=false

group "default" {
  targets = ["chrony-server"]
}

target "chrony-server" {
  context     = "."
  dockerfile  = "dockerfile"
  output      = ["type=registry"]
  tags        = ["ghcr.io/lazerbeakravage/chrony-server:latest"]
  platforms   = ["linux/amd64", "linux/arm64"]
  no-cache    = true
}