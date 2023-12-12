---
title: "Troubleshooting in {{ container-registry-full-name }}"
description: "This page describes common errors and ways to fix them."
---

# Troubleshooting in {{ container-registry-name }}

The most common errors and how to resolve them are listed below:
* `docker login is not supported with yc credential helper`

  **Why the error occurred:** If you use [Docker credential helpers](../operations/authentication.md#cred-helper), you cannot [get authenticated](../operations/authentication.md) in {{ container-registry-name }} using your `docker login`. You can also see the same error in [{{ coi }}](../../cos/concepts/index.md) where a credential helper is used to authenticate on behalf of a [service account](../../iam/concepts/users/service-accounts.md) linked to a [VM](../../compute/concepts/vm.md).

  **How to fix it**: Get authenticated in the [registry](../concepts/registry.md) using Docker credential helper or [disable Docker credential helper](../operations/authentication.md#ch-not-use).
* `Got permission denied while trying to connect to the Docker daemon socket`

  **Why the error occurred:** The Docker daemon requires `root` permission to execute commands by default.

  **Fix:** Run commands using `sudo` or [configure access for other operating system users](https://docs.docker.com/install/linux/linux-postinstall/#manage-docker-as-a-non-root-user).
* `name unknown: Registry <...> not found`

  **Why the error occurred:** The registry ID is missing or invalid. When using Docker CLI commands, you must specify the full name of a [Docker image](../concepts/docker-image.md), including the registry ID. For more information, see [{#T}](../concepts/repository.md).

  **How to fix it:** Check the validity of your unique registry ID [in the registry list](../operations/registry/registry-list.md).
* `Error response from daemon: pull access denied for <cr.yandex/registry_ID/Docker_image_name>, repository does not exist or may require 'docker login': denied: Permission denied ; requestId = <request_ID>`

  **Why the error occurred:** The [IP address](../../vpc/concepts/address.md) from which the pull Docker image request comes has no PULL permission.

  **How to fix it:** [Add](../operations/registry/registry-access.md) rules that allow pulling image for this IP in the registry settings or delete all rules and try again.