# Troubleshooting in {{ container-registry-name }}

The most common errors and how to resolve them are listed below:

- `docker login is not supported with yc credential helper`

    **Why the error occurred:** If you use [Docker Credential helper](../operations/authentication.md#credit-helper), you can't authenticate in {{ container-registry-full-name }} using your `docker login`. You may also see this error in a [Container Optimized Image](../../cos/concepts/index.md), when credential helper is used to authenticate on behalf of the service account linked to your VM.

    **How to fix it:** Authenticate in the registry [using Docker Credential helper](../operations/authentication.md#cred-helper) or [disable Docker Credential helper](../operations/authentication.md#ch-not-use).

- `Got permission denied while trying to connect to the Docker daemon socket`

    **Why the error occurred:** The Docker daemon requires `root` permission to execute commands by default.

    **How to fix it:** Run commands using `sudo` or [set up permissions for other OS users](https://docs.docker.com/install/linux/linux-postinstall/#manage-docker-as-a-non-root-user).

- `name unknown: Registry <...> not found`

    **Why the error occurred:** The registry ID is missing or invalid. When using Docker CLI commands, you must specify the full name of the Docker image that includes the registry ID. Learn more about this in [{#T}](../concepts/repository.md).

    **How to fix it:** Check the validity of your unique registry ID [in the registry list](../operations/registry/registry-list.md).