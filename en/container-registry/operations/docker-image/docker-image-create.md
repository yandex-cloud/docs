# Creating a Docker image

The instructions describe how to build a [Docker image](../../concepts/docker-image.md) from a Dockerfile and how to assemble it.

{% list tabs %}

- CLI

  1. Create a file named Dockerfile and add the following lines to it:

     ```
     FROM ubuntu:latest
     CMD echo "Hi, I'm inside"
     ```

     The described Docker image is based on Ubuntu and will execute one simple command.

  1. Assemble the Docker image. As a `<registry ID>`, use the `ID` received when [creating the registry](../registry/registry-create.md).

     ```
     docker build . \
       -t cr.yandex/<registry ID>/ubuntu:hello
     ```

     The `-t` flag assigns a URL in the format `cr.yandex/<registry ID>/<Docker image name>:<tag>`to the Docker image. You can build Docker images without any tag. In this case, the Docker CLI assigns them the default label: `latest`.

{% endlist %}

Once completed, these commands will create a Docker image with the `hello` tag in your repository as well as the full address of the repository, including:
* {{ container-registry-name }} service address `cr.yandex`.
* ID of your registry `<registry ID>`.
* Name of your `ubuntu` repository.
