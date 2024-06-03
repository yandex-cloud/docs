# Creating a Docker image

The guide describes how to create and build a [Docker image](../../concepts/docker-image.md) from a Dockerfile.

{% list tabs group=instructions %}

- CLI {#cli}

   1. Create a file named Dockerfile on your device and add the below lines to it:

      ```
      FROM ubuntu:latest
      CMD echo "Hi, I'm inside"
      ```

      The described Docker image is based on Ubuntu and will execute one simple command.

   1. Assemble the Docker image. For `<registry_ID>`, use the `ID` you got when [creating the registry](../registry/registry-create.md).

      ```
      docker build . \
        -t {{ registry }}/<registry_ID>/ubuntu:hello
      ```

      The `-t` flag assigns to the Docker image a URL in `{{ registry }}/<registry_ID>/<Docker_image_name>:<tag>` format. You can build Docker images without any tag. In this case, the Docker CLI will assign the default label: `latest`.

{% endlist %}

Once these commands are completed, a Docker image will be created in your repository with the `hello` tag as well as the full address of the repository, including:
* {{ container-registry-name }} service address `{{ registry }}`.
* Your registry ID `<registry_ID>`.
* Name of your `ubuntu` repository.