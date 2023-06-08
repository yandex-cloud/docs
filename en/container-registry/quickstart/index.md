# Getting started with {{ container-registry-name }}

Using these instructions, you will create your first [registry](../concepts/registry.md) and try managing [Docker images](../concepts/docker-image.md).

## Before you start {#before-you-begin}

To create a registry, you'll need a folder in {{ yandex-cloud }}. If you don't have any folders yet, create a new folder:

{% include [create-folder](../../_includes/create-folder.md) %}

You will also need the [{{ yandex-cloud }} CLI](../../cli/quickstart.md) and [Docker](https://docs.docker.com/install/).

## Creating a registry and performing basic operations on Docker images {#registry-create}

1. Create a registry in {{ container-registry-name }}:

   ```bash
   yc container registry create --name my-first-registry
   ```

   Result:

   ```text
   ..done
   id: crpc9qeoft236r8tfalm
   folder_id: b1g0itj57rbjk9thrinv
   name: my-first-registry
   status: ACTIVE
   created_at: "2018-12-25T12:24:56.286Z"
   ```

   You will use the `ID` received to access the created registry later.
1. Authenticate in {{ container-registry-name }} using [Docker Credential helper](../operations/authentication.md#cred-helper):
   1. Configure Docker to use `docker-credential-yc`:

      ```bash
      yc container registry configure-docker
      ```

      Result:

      ```bash
      Credential helper is configured in '/home/<user>/.docker/config.json'
      ```

      During setup, information about the current user profile is saved.
   1. Make sure that Docker is configured.

      The `/home/<user>/.docker/config.json` configuration file must include the following line:

      ```json
      "{{ registry }}": "yc"
      ```

1. Pull a Docker image from [Docker Hub](https://hub.docker.com):

   ```bash
   docker pull ubuntu
   ```

1. Assign the pulled Docker image a tag in the following format: `{{ registry }}/<registry ID>/<Docker image name>:<tag>`:

   ```bash
   docker tag ubuntu \
   {{ registry }}/crpc9qeoft236r8tfalm/ubuntu:hello
   ```

1. Push the Docker image to the repository {{ container-registry-name }}:

   ```bash
   docker push \
   {{ registry }}/crpc9qeoft236r8tfalm/ubuntu:hello
   ```

1. Run the Docker image:

   ```bash
   docker run \
   {{ registry }}/crpc9qeoft236r8tfalm/ubuntu:hello
   ```

#### See also {#see-also}

* [Creating a registry](../operations/registry/registry-create.md).
* [Authentication in {{ container-registry-name }}](../operations/authentication.md).
* [Creating a Docker image](../operations/docker-image/docker-image-create.md).
* [Pushing a Docker image](../operations/docker-image/docker-image-push.md).
* [Pulling a Docker image](../operations/docker-image/docker-image-pull.md).
* [Running a Docker image on a VM](../tutorials/index.md).