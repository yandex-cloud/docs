# Docker image

When creating a VM from a {{ coi }}, you can specify the [Docker image](../../container-registry/concepts/docker-image.md) to use to run a Docker container.

This Docker image can be pulled from both the public Docker image registry and the {{ container-registry-full-name }}. If you access the Docker image via the {{ container-registry-name }}, the [service account](../../iam/concepts/index.md#sa) linked to the VM will be used. An image in the {{ coi }} registry {{ container-registry-name }} can be updated and changed according to [releases](../release-notes.md). In this case, the image on a VM isn't updated to the latest version automatically.

Examples of Docker image names for different registries:
* Docker Hub: `ubuntu:16.04`.
* {{ container-registry-name }}: `cr.yandex/crpd50616s9a2t7gr8mi/ubuntu:16.04`.