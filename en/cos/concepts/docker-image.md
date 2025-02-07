# Docker image

When creating a VM with a {{ coi }}, you can specify the [Docker image](../../container-registry/concepts/docker-image.md) to use to launch a Docker container.

This Docker image can be pulled from both the public Docker image registry and the {{ container-registry-full-name }}. If you access the Docker image via the {{ container-registry-name }}, the [service account](../../iam/concepts/index.md#sa) linked to the VM will be used. A {{ coi }} in a {{ container-registry-name }} registry may be updated and changed with new [releases](../release-notes.md). This will not automatically update the VM image to the latest version.

Examples of Docker image names for different registries:
* Docker Hub: `ubuntu:16.04`.
* {{ container-registry-name }}: `{{ registry }}/<registry_ID>/ubuntu:16.04`.