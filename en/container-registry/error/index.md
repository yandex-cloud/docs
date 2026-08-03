---
title: Troubleshooting in {{ container-registry-full-name }}
description: This page gives a list of common issues and their fixes.
---

# Troubleshooting in {{ container-registry-name }}

Below is a list of common issues and their fixes:

* `docker login is not supported with yc credential helper`

  **Why you got this error**: If using a [Docker credential helper](../operations/authentication.md#cred-helper), you cannot [get authenticated](../operations/authentication.md) in {{ container-registry-name }} with `docker login`. You may also get the same error in [{{ coi }}](../../cos/concepts/index.md) where a credential helper is used for authentication on behalf of a [service account](../../iam/concepts/users/service-accounts.md) associated with the [VM](../../compute/concepts/vm.md).

  **How to fix it**: Get authenticated in the [registry](../concepts/registry.md) using a Docker credential helper or [disable the Docker credential helper](../operations/authentication.md#ch-not-use).

* `Got permission denied while trying to connect to the Docker daemon socket`

  **Why you got this error**: By default, the Docker daemon requires `root` permissions to run commands.

  **How to fix it**: Run commands using `sudo` or [configure permissions for other OS users](https://docs.docker.com/install/linux/linux-postinstall/#manage-docker-as-a-non-root-user).

* `name unknown: Registry <...> not found`

  **Why you got this error**: Registry ID is missing or invalid. When using Docker CLI commands, specify the full [Docker image](../concepts/docker-image.md) name, including the registry ID. For more information, see [{#T}](../concepts/repository.md).

  **How to fix it**: [View the registry list](../operations/registry/registry-list.md) to make sure your unique registry ID is valid.

* `Error response from daemon: pull access denied for <{{ registry }}/registry_ID/Docker_image_name>, repository does not exist or may require 'docker login': denied: Permission denied ; requestId = <request_ID>`

  **Why you got this error**: [IP address](../../vpc/concepts/address.md) sending the pull Docker image request has no PULL permissions.

  **How to fix it**: [Add](../operations/registry/registry-access.md) allow rules for this IP address in the registry settings, or remove all rules and try again.

* `InvalidImageName`

  **Why you got this error**: Invalid Docker image name.

  **How to fix it**: Repository name must be a [URI](https://en.wikipedia.org/wiki/Uniform_Resource_Identifier) that includes the Docker image name. The Docker image name must follow a specific format. For more information, see the [OCI Distribution Specification](https://github.com/opencontainers/distribution-spec/blob/main/spec.md#pull).

* `invalid reference format`

  **Why you got this error**: Invalid Docker image tag.
  
  **How to fix it**: Repository name must be a [URI](https://en.wikipedia.org/wiki/Uniform_Resource_Identifier) that includes the Docker image tag. The Docker image tag must follow a specific format. For more information, see the [OCI Distribution Specification](https://github.com/opencontainers/distribution-spec/blob/main/spec.md#pull).

* `Error response from daemon: unauthorized: Authentication problem ; requestId = <request_ID>`
  
  `unauthorized: Authentication problem ; requestId = <request_ID>`

  **Why you got this error**:
  * You are trying to pull or push a Docker image to {{ container-registry-name }}, but you are not authenticated. To perform operations with images in {{ container-registry-name }}, you need to get authenticated first.
  * Docker cannot run [docker-credential-yc](../operations/authentication.md#cred-helper), e.g., because the path to the executable is missing from the `PATH` environment variable.
  
  **How to fix it**:
  * [Get authenticated](../operations/authentication.md) in {{ container-registry-name }}.
  * Make sure the `yc` executable file path has been added to the `PATH` environment variable.

* `Permission denied`

  **Why you got this error**: Not enough permissions to perform the operation.

  **How to fix it**: Make sure the [service account](../../iam/concepts/users/service-accounts.md) or [user](../../iam/concepts/users/accounts.md) performing the operation has the required [roles](../security/index.md).
  