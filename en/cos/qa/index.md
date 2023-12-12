---
title: "Questions and answers about {{ cos-full-name }}"
description: "This page provides answers to questions about {{ cos-name }}."
---

# Questions and answers about {{ cos-name }}

#### How do I perform auto updates based on immutable tags? {#auto-update}

Updating a Docker container will not work with [tags](../../container-registry/concepts/docker-image.md#version) that persist from version to version. We recommend using a new tag for each [Docker image](../../cos/concepts/docker-image.md).

## Getting started {#before-you-begin}

There is a number of disadvantages of using tags that persist from version to version:
* When a problem occurs, it is difficult to find its source if multiple identical [VMs](../../compute/concepts/vm.md) have the same tag but different code.
* A cluster of multiple VMs can be heterogeneous, for example, if one VM restarts and updates a Docker image.
* It is difficult to distinguish between Docker image versions on a VM.

#### I cannot create a Docker container. Why is that? {#create-container}

{% note warning %}

The [Docker Compose specification](../../cos/concepts/coi-specifications.md#compose-spec) does not support `build` instructions, so make sure to build a Docker image in advance. In addition, the Docker Compose specification should not contain any links to other files: they are not delivered to the VM.

{% endnote %}

* Check that the Docker image name is correct.
* Make sure the [service account](../../iam/concepts/users/service-accounts.md) linked to the VM has the `{{ roles-cr-puller }}` rights to the appropriate Docker image.
* Check that the VM has internet access.
* You can also view logs by running the `sudo journalctl -u yc-container-daemon` command on the VM.

#### How can I close a port for public access and leave it accessible within the network? {#port}

* If you use a standard {{ coi }} (one Docker container configured by parameters), all ports that are open in the container will also be open on the host.
* If you need other [network](../../vpc/concepts/network.md#network) settings for Docker containers, you can configure them using a {{ coi }} with the Docker Compose specification.
* To make your Docker container's port open on the host but disable access to it from the internet, you can use [security groups](../../vpc/concepts/security-groups.md).
