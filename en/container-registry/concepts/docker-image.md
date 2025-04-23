---
title: Docker image. What is it and how does it work?
description: 'A Docker image is a template for creating Docker containers. It is an executable package that contains everything you need to run an application: code, runtime environment, libraries, environment variables, and configuration files. A Docker image consists of layers. Each change is written to a new layer. When pushing or pulling a Docker image, operations are performed only on the layers that were changed.'
---

# Docker image in {{ container-registry-name }}

A _Docker image_ is a template for creating Docker containers. It is an executable package that contains everything you need to run an application: code, runtime environment, libraries, environment variables, and configuration files.

A Docker image consists of layers. Each change is written to a new layer.

* When pushing or pulling a Docker image, operations are performed only on the layers that were changed.
 
* The layers of the source Docker image are shared by all its versions and are not duplicated.

## Version control {#version}

Docker image version control is carried out using tags and digests.

A _tag_ is assigned by the user. The tag must be unique within a single [repository](repository.md) and can be changed. If no tag is specified, Docker CLI assigns the **latest** tag by default while [pushing a Docker image](../operations/docker-image/docker-image-push.md) to the registry.

{% include [latest-info](../../_includes/container-registry/info-about-latest.md) %}

A Docker image can have multiple tags. If you push a new version of the Docker image with an existing tag, it is going to be reused by being deleted from the old Docker image version and written to the new one.

A _digest_ is generated automatically, is unique, and identifies the exact Docker image version.

You can access a specific Docker image version in one of the following ways:
* `<registry>/<image_name>:<tag>`
* `<registry>/<image_name>@<digest>`

A Docker image and all its versions are stored in a repository.

## Use cases {#examples}

* [{#T}](../tutorials/run-docker-on-vm/index.md)
* [{#T}](../tutorials/container-pg-connect.md)
* [{#T}](../tutorials/cr-scanner-with-k8s-and-gitlab.md)
* [{#T}](../tutorials/deploy-app-container.md)
* [{#T}](../tutorials/fault-tolerance.md)
