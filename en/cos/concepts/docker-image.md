# Docker image

When creating a VM with a {{ coi }}, you can specify the [Docker image](../../container-registry/concepts/docker-image.md) to use to launch a Docker container.

This Docker image can be pulled from both the public Docker image registry and the {{ container-registry-full-name }}. If you access the Docker image via the {{ container-registry-name }}, the service account linked to the VM will be used.

Examples of Docker image names for different registries:
* Docker Hub: `ubuntu:16.04`.
* {{ container-registry-name }}: `cr.yandex/crpd50616s9a2t7gr8mi/ubuntu:16.04`.