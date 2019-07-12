# Getting started with Container Registry

Using these instructions, you will create your first [registry](../concepts/registry.md) and try managing [Docker images](../concepts/docker-image.md).

## Before you start

To create a registry, you will need a folder in Yandex.Cloud. If you don't have any folders yet, create a new folder before creating a registry:

{% include [create-folder](../../_includes/create-folder.md) %}

You will also need the [Yandex CLI](../../cli/quickstart.md) and [Docker](https://docs.docker.com/install/).

## Creating a registry and performing basic operations on Docker images

1. Create a registry in Container Registry:

    ```
    $ yc container registry create --name my-first-registry
    ..done
    id: crpc9qeoft236r8tfalm
    folder_id: b1g0itj57rbjk9thrinv
    name: my-first-registry
    status: ACTIVE
    created_at: "2018-12-25T12:24:56.286Z"
    ```

    You will need the received `id` to access the created registry.

1. Log in to Container Registry by running the `docker login` command with an OAuth token. You can get a token at this [link](https://oauth.yandex.com/authorize?response_type=token&client_id=1a6990aa636648e9b2ef855fa7bec2fb).

    ```
    $ docker login \
    --username oauth \ # type of token used
    --password <OAuth token> \
    cr.yandex
    ```

1. Pull a Docker image from the [Docker Hub](https://hub.docker.com) repository:

    ```
    $ docker pull ubuntu
    ```

1. Assign a tag to the Docker image:

    ```
    $ docker tag <image ID> \
    cr.yandex/crpc9qeoft236r8tfalm/ubuntu:hello
    ```

1. Push the Docker image to the repository:

    ```
    $ docker push \
    cr.yandex/crpc9qeoft236r8tfalm/ubuntu:hello
    ```

1. Run the Docker image:

    ```
    $ docker run \
    cr.yandex/crpc9qeoft236r8tfalm/ubuntu:hello
    ```

#### See also

* [Creating a registry](../operations/registry/registry-create.md)
* [Authentication in Container Registry](../operations/authentication.md)
* [Creating a Docker image](../operations/docker-image/docker-image-create.md)
* [Pushing a Docker image](../operations/docker-image/docker-image-push.md)
* [Pulling a Docker image](../operations/docker-image/docker-image-pull.md)
* [Running a Docker image on a VM](../scenario/index.md)

