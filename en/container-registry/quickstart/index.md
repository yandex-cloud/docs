# Getting started with {{ container-registry-name }}

Use this guide to create your first [registry](../concepts/registry.md) and try managing [Docker images](../concepts/docker-image.md).

## Getting started {#before-you-begin}

To create a registry, you will need a folder in {{ yandex-cloud }}. If you do not have any folders yet, create one before creating a registry:

{% include [create-folder](../../_includes/create-folder.md) %}

To work with {{ container-registry-name }} and Docker images, [install the {{ yandex-cloud }} CLI](../../cli/operations/install-cli.md) and [configure](../operations/configure-docker.md) Docker.

## Creating a registry and performing basic operations on Docker images {#registry-create}

1. Create a registry in {{ container-registry-name }}:

   ```bash
   yc container registry create --name my-first-registry
   ```

   Result:

   ```text
   ..done
   id: crpc9qeoft23********
   folder_id: b1g0itj57rbj********
   name: my-first-registry
   status: ACTIVE
   created_at: "2018-12-25T12:24:56.286Z"
   ```

   You will use the received `ID` to access the created registry later.
1. Authenticate in {{ container-registry-name }} using [Docker Credential helper](../operations/authentication.md#cred-helper):
   1. Configure Docker to use `docker-credential-yc`:

      ```bash
      yc container registry configure-docker
      ```

      Result:

      ```text
      Credential helper is configured in '/home/<user>/.docker/config.json'
      ```

      During setup, information about the current user profile is saved.
   1. Make sure that Docker is configured.

      In the `/home/<user>/.docker/config.json` configuration file, you should see the following line:

      ```json
      "{{ registry }}": "yc"
      ```

1. Pull a Docker image from [Docker Hub](https://hub.docker.com):

   ```bash
   docker pull ubuntu
   ```

1. Assign the pulled Docker image a tag in this format: `{{ registry }}/<registry_ID>/<Docker_image_name>:<tag>`:

   ```bash
   docker tag ubuntu \
   {{ registry }}/<registry_ID>/ubuntu:hello
   ```

1. Push the Docker image to the repository {{ container-registry-name }}:

   ```bash
   docker push \
   {{ registry }}/<registry_ID>/ubuntu:hello
   ```

1. Run the Docker image:

   ```bash
   docker run \
   {{ registry }}/<registry_ID>/ubuntu:hello
   ```

#### See also {#see-also}

* [Creating a registry](../operations/registry/registry-create.md).
* [Authentication in {{ container-registry-name }}](../operations/authentication.md).
* [Creating a Docker image](../operations/docker-image/docker-image-create.md).
* [Pushing a Docker image](../operations/docker-image/docker-image-push.md).
* [Pulling a Docker image](../operations/docker-image/docker-image-pull.md).
* [Running a Docker image on a VM](../tutorials/index.md).