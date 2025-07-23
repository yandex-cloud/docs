---
title: Registry in {{ cloud-registry-full-name }}
description: Registry is a centralized repository and a management tool for the various files used in app development and deployment.
---

# Registry in {{ cloud-registry-full-name }}

A _registry_ is a centralized repository as well as a management tool for the various files used in app development and deployment.

Each registry may contain a set of package versions associated with particular resources. Use [Maven CLI](https://maven.apache.org/ref/3-LATEST/maven-embedder/cli.html), [NPM](art-nodejs.md#npm-inf), or [NuGet CLI](https://learn.microsoft.com/en-us/nuget/reference/nuget-exe-cli-reference) to retrieve and publish packages.

With a registry, you can quickly access the [artifacts](artifacts.md) you need and manage their versions. Using a registry simplifies the process of managing dependencies between the project components. This feature will be of use to development teams working on large and complex projects.

Registries share the same data centers with your infrastructure for speedy performance without needless traffic costs.

## Registry types in {{ cloud-registry-name }} {#registry-types}

Depending on artifact storage location, {{ cloud-registry-name }} registries can be local, remote, or virtual.

### Local registries {#local-registry}

_Local registries_ allow you to store, securely distribute, and manage artifacts ([Docker images](./docker-image.md), Helm charts, binary files, etc.) created within your [organization](../../organization/concepts/organization.md). Local registries are centralized and secure storage facilities for internal binary data.

### Remote registries {#remote-registry}

_Remote registries_ operate as proxies for remote repositories, such as [Docker Hub](https://hub.docker.com/) or other third-party repositories. Remote registries enable local caching of artifacts after initial access, thus accelerating access to frequently used data and reducing load on source remote resources.

With {{ cloud-registry-name }}, developers can upload code libraries, software packages, and other development artifacts into remote registries for storage.

### Virtual registries {#virtual-registry}

Multiple local and/or remote registries can be combined under a single name with the help of _virtual registries_, providing a single entry point to search and download required artifacts. Virtual registries simplify access and management because, with the single entry point, users do not have to think about the physical location of registries.
