# Pulling a Docker image from a registry {{ cloud-registry-name }}

To download a [Docker image](../../concepts/docker-image.md), you need the `cloud-registry.artifacts.puller` [role](../../security/index.md#cloud-registry-artifacts-puller) or higher.

To work with Docker images, [install and configure](installation.md) Docker.

{% list tabs group=instructions %}

- CLI {#cli}

  1. Select the Docker image you need.
  1. Pull the Docker image from the [registry](../../concepts/registry.md):
     * Using the **tag**:

       ```bash
       docker pull {{ cloud-registry }}/<registry_ID>/ubuntu:hello
       ```

       Result:

       ```text
       hello: Pulling from crpd50616s9a********/ubuntu
       84ed7d2f608f: Already exists
       be2bf1c4a48d: Already exists
       a5bdc6303093: Already exists
       e9055237d68d: Already exists
       Digest: sha256:035ac8e1bd9c49871a2fd76ccb3c4b0f84e7eee775919ccd345337ec********
       Status: Downloaded newer image for {{ cloud-registry }}/crpd50616s9a********/ubuntu:hello
       ```

     * Using the **digest**:

       ```bash
       docker pull {{ cloud-registry }}/<registry_ID>/ubuntu@sha256:035ac8e1bd9c49871a2fd76
       ```

       Result:

       ```text
       ccb3c4b0f84e7eee775919ccd345337ec7b49f80d
       sha256:035ac8e1bd9c49871a2fd76ccb3c4b0f84e7eee775919ccd345337ec********: Pulling from crpd50616s9a********/ubuntu
       84ed7d2f608f: Already exists
       ...
       e9055237d68d: Already exists
       Digest: sha256:035ac8e1bd9c49871a2fd76ccb3c4b0f84e7eee775919ccd345337ec********
       Status: Downloaded newer image for {{ cloud-registry }}/crpd50616s9a********/ubuntu@sha256:035ac8e1bd9c49871a2fd76ccb3c4b0f84e7eee775919ccd345337ec********
       ```

       Note that in this case the Docker image will be pulled with no tag. In the `TAG` field, there will be `<none>`.
  1. Make sure the Docker image has been pulled:

     ```bash
     docker image list
     ```

     Result:

     ```text
     REPOSITORY                                  TAG     IMAGE ID      CREATED       SIZE
     {{ cloud-registry }}/crpd50616s9a********/ubuntu       <none>  50ff********  24 hours ago  86.7MB
     ubuntu                                      latest  1d9c********  2 weeks ago   86.7MB
     ```

{% endlist %}
