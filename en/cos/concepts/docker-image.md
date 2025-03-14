# Docker image

When creating a {{ coi }} VM, you can specify the [Docker image](../../container-registry/concepts/docker-image.md) for launching a Docker container.

You can pull this Docker image from the public Docker image registry or {{ container-registry-full-name }}. Accessing the Docker image through the {{ container-registry-name }} involves the [service account](../../iam/concepts/index.md#sa) linked to the VM. A {{ coi }} in the {{ container-registry-name }} may get updates and changes along with new [releases](../release-notes.md). However, such releases will not automatically update the VM image to the latest version.

Examples of Docker image names for various registries:
* Docker Hub: `ubuntu:16.04`.
* {{ container-registry-name }}: `{{ registry }}/<registry_ID>/ubuntu:16.04`.