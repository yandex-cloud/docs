---
title: FAQ about {{ cos-full-name }}
description: This page covers FAQ about {{ cos-name }}.
---

# FAQ about {{ cos-name }}

#### How do I perform auto updates based on immutable tags? {#auto-update}

Updating a Docker container will not work with [tags](../../container-registry/concepts/docker-image.md#version) that persist from version to version. We recommend using a new tag for each [Docker image](../../cos/concepts/docker-image.md).

## Getting started {#before-you-begin}

Using tags that persist from version to version has multiple disadvantages:
* When an issue occurs, finding its source is difficult if multiple identical [VMs](../../compute/concepts/vm.md) have the same tag but various code.
* A VM cluster can be heterogeneous, e.g., if one VM has restarted and updated a Docker image.
* It is difficult to distinguish between Docker image versions on a VM.

#### Unable to create a Docker container. Why is that? {#create-container}

{% note warning %}

The [Docker Compose specification](../../cos/concepts/coi-specifications.md#compose-spec) does not support the `build` instruction: Make sure to build a Docker image beforehand. In addition, the Docker Compose spec should not contain any links to other files, as the VM does not get these.

{% endnote %}

* Make sure the Docker image name is correct.
* Make sure the [service account](../../iam/concepts/users/service-accounts.md) linked to the VM has the `{{ roles-cr-puller }}` permissions for the appropriate Docker image.
* Make sure the VM has internet access.
* You can also view [log errors](../error/index.md) by running the `sudo journalctl -eu yc-container-daemon` command on the VM.

#### How can I close a port for public access and leave it accessible within the network? {#port}

* When using a standard {{ coi }}, i.e., one Docker container configured using parameters, all ports that are open in the container will also be open on the host.
* If you need other [network](../../vpc/concepts/network.md#network) settings for Docker containers, you can employ them using a {{ coi }} with the Docker Compose spec. 
* To make your Docker container port open on the host while disabling internet access, you can use [security groups](../../vpc/concepts/security-groups.md).
