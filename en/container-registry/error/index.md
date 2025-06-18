---
title: Troubleshooting in {{ container-registry-full-name }}
description: This page contains a list of common issues and their fixes.
---

# Troubleshooting in {{ container-registry-name }}

See below for a list of common issues and their fixes:

* `docker login is not supported with yc credential helper`

  **Why you got this error**: If you are using a [Docker credential helper](../operations/authentication.md#cred-helper), you cannot [get authenticated](../operations/authentication.md) in {{ container-registry-name }} with `docker login`. You may also see the same error in [{{ coi }}](../../cos/concepts/index.md) where a credential helper is used for authentication as a [service account](../../iam/concepts/users/service-accounts.md) linked to a [VM](../../compute/concepts/vm.md).

  **How to fix it**: Get authenticated in the [registry](../concepts/registry.md) using a Docker credential helper or [disable the Docker credential helper](../operations/authentication.md#ch-not-use).

* `Got permission denied while trying to connect to the Docker daemon socket`

  **Why you got this error**: By default, the Docker daemon requires `root` permissions to run commands.

  **How to fix it**: Run commands using `sudo` or [configure permissions for other OS users](https://docs.docker.com/install/linux/linux-postinstall/#manage-docker-as-a-non-root-user).

* `name unknown: Registry <...> not found`

  **Why you got this error**: Registry ID is missing or invalid. When using Docker CLI commands, you must specify the full name of a [Docker image](../concepts/docker-image.md), including the registry ID. For more information, see [{#T}](../concepts/repository.md).

  **How to fix it**: [View the registry list](../operations/registry/registry-list.md) to check your unique registry ID is valid.

* `Error response from daemon: pull access denied for <{{ registry }}/registry_ID/Docker_image_name>, repository does not exist or may require 'docker login': denied: Permission denied ; requestId = <request_ID>`

  **Why you got this error**: [IP address](../../vpc/concepts/address.md) sending the pull Docker image request has no PULL permissions.

  **How to fix it**: [Add](../operations/registry/registry-access.md) rules that allow pulling images from this IP address in the registry settings or delete all rules and try again.

* `InvalidImageName`

  **Why you got this error**: Invalid Docker image name.

  **How to fix it**: The repository name must be a [URI](https://en.wikipedia.org/wiki/Uniform_Resource_Identifier) with the Docker image name forming its part. The Docker image name must have a particular format. For more information, see the [OCI Distribution Specification](https://github.com/opencontainers/distribution-spec/blob/main/spec.md#pull).

* `invalid reference format`

  **Why you got this error**: Invalid Docker image tag.
  
  **How to fix it**: The repository name must be a [URI](https://en.wikipedia.org/wiki/Uniform_Resource_Identifier) with the Docker image tag forming its part. The Docker image tag must have a particular format. For more information, see the [OCI Distribution Specification](https://github.com/opencontainers/distribution-spec/blob/main/spec.md#pull).

* `Error response from daemon: unauthorized: Authentication problem ; requestId = <request_ID>`
  
  `unauthorized: Authentication problem ; requestId = <request_ID>`

  **Why you got this error**: You are trying to pull or push a Docker image to {{ container-registry-name }}, but you are not authenticated. To perform operations with images in {{ container-registry-name }}, you need to get authenticated first.

  **How to fix it**: [Get authenticated](../operations/authentication.md) in {{ container-registry-name }}.

