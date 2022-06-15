# Troubleshooting in {{ container-registry-name }}

The most common errors and how to resolve them are listed below:
* `docker login is not supported with yc credential helper`

   **Why the error occurred:** If you use [Docker Credential helper](../operations/authentication.md#cred-helper), you can't authenticate in {{ container-registry-name }} using your `docker login`. You can also see the same error in [{{ coi }}](../../cos/concepts/index.md) where Credential helper is used to authenticate on behalf of a service account associated with a virtual machine.

   **How to fix it:** Authenticate in the registry [using Docker Credential helper](../operations/authentication.md#cred-helper) or [disable Docker Credential helper](../operations/authentication.md#ch-not-use).
* `Got permission denied while trying to connect to the Docker daemon socket`

   **Why the error occurred:** The Docker daemon requires `root` permission to execute commands by default.

   **Fix:** Run commands using `sudo` or [configure access for other operating system users](https://docs.docker.com/install/linux/linux-postinstall/#manage-docker-as-a-non-root-user).
* `name unknown: Registry <...> not found`

   **Why the error occurred:** The registry ID is missing or invalid. When using Docker CLI commands, you must specify the full name of the Docker image that includes the registry ID. For more information, see [{#T}](../concepts/repository.md).

   **How to fix it:** Check the validity of your unique registry ID [in the registry list](../operations/registry/registry-list.md).