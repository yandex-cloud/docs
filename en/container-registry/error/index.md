---
title: Troubleshooting in {{ container-registry-full-name }}
description: This page contains a list of common issues and their fixes.
---

# Troubleshooting in {{ container-registry-name }}

See below for a list of common issues and their fixes:
* `docker login is not supported with yc credential helper`

  **Why you got this error**: If you use a [Docker credential helper](../operations/authentication.md#cred-helper), you cannot [get authenticated](../operations/authentication.md) in {{ container-registry-name }} using your `docker login`. You can also see the same error in [{{ coi }}](../../cos/concepts/index.md) where a credential helper is used to authenticate as a [service account](../../iam/concepts/users/service-accounts.md) linked to a [VM](../../compute/concepts/vm.md).

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