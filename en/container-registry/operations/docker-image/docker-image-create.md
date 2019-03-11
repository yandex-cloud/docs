# Creating a Docker image

The instructions describe how to build a [Docker image](../../concepts/docker-image.md) from a Dockerfile and how to assemble it.

---

**[!TAB CLI]**

1. Create a file named Dockerfile and add the following lines to it:

    ```
    FROM ubuntu:latest
    CMD echo "Hi, I'm inside"
    ```

    The described Docker image is based on Ubuntu and will execute one simple command.

1. Assemble the Docker image. As a `<registry ID>`, use the `ID` received when 
[creating the registry](../registry/registry-create.md).

    ```
    $ docker build . \
    -t container-registry.cloud.yandex.net/<registry ID>/ubuntu:hello
    ```

    The `-t` flag is optional: a Docker image can be assembled without any tag. In this case, the Docker CLI will assign the default label: `latest`.

--- 

After running these commands, the Docker image will be created with the following parameters:

- Full address of the repository consisting of:
    - Address of Yandex Container Registry `container-registry.cloud.yandex.net`.
    - ID of your registry `<registry ID>`.
    - Name of your `ubuntu` repository.
- Docker image tag in your repository: `hello`.

