---
title: "Docker image. What is it and how does it work?"
description: "A Docker image is a template for creating Docker containers. It's an executable package that contains everything you need to run an application: code, runtime environment, libraries, environment variables, and configuration files. A Docker image consists of layers. Each change is written to a new layer. When pushing or pulling a Docker image, operations are performed only on the layers that were changed."
---

# Docker image in {{ container-registry-name }}

A _Docker image_ is a template for creating Docker containers. It's an executable package that contains everything you need to run an application: code, runtime environment, libraries, environment variables, and configuration files.

A Docker image consists of layers. Each change is written to a new layer.

* When pushing or pulling a Docker image, operations are performed only on the layers that were changed.

* The layers of the source Docker image are shared by all its versions and are not duplicated.

## Version control {#version}

Docker image version control is carried out using tags and digests.

_Tags_ are assigned by the user. Tags are unique within a [repository](repository.md) and can be changed. If no tag is specified, Docker CLI assigns the **latest** tag by default while [pushing a Docker image](../operations/docker-image/docker-image-push.md) to the registry.

{% include [latest-info](../../_includes/container-registry/info-about-latest.md) %}

A Docker image can have multiple tags. If you push a new version of the Docker image with an existing tag, it's reused: it gets deleted from the old Docker image version and written to the new one.

A _digest_ is generated automatically, is unique, and identifies the exact version of a Docker image.

You can access a specific version of the Docker image in one of the following ways:
* `<registry>/<image_name>:<tag>`
* `<registry>/<image_name>@<digest>`

A Docker image and all its versions are stored in a repository.