1. Run Docker Desktop.
1. Log in to the registry under your username with:

   {% list tabs group=registry_auth %}

   - Docker credential helper {#docker}

     1. Configure Docker to use `docker-credential-yc`:

        ```bash
        yc container registry configure-docker
        ```

        Result:

        ```text
        Credential helper is configured in '/home/<user>/.docker/config.json'
        ```

        Settings are saved in the current user's profile.

        {% note warning %}

        The credential helper only works if you use Docker without `sudo`. To learn how to configure Docker to run under the current user without `sudo`, see the [official Docker documentation](https://docs.docker.com/engine/install/linux-postinstall/#manage-docker-as-a-non-root-user).

        {% endnote %}

     1. Make sure that Docker is configured.

        The following line must appear in the `/home/<user>/.docker/config.json` configuration file:

        ```json
        "{{ registry }}": "yc"
        ```

     1. You can now use Docker, for example, to [push Docker images](../../../container-registry/operations/docker-image/docker-image-push.md). You do not need to run the `docker login` command for that.

   - OAuth token {#oauth-token}

     1. If you do not have an [OAuth token](../../../iam/concepts/authorization/oauth-token.md) yet, get one at [this link]({{ link-cloud-oauth }}).
     1. Run this command:

        ```bash
        echo <OAuth_token> | docker login --username oauth --password-stdin {{ registry }}
        ```

        Result:

        ```text
        Login Succeeded
        ```

   - {{ iam-short-name }} token {#iam-token}

     {% note info %}

     {% include [iam-token-note](../../../_includes/iam/iam-token-note.md) %}

     {% endnote %}

     1. [Get](../../../iam/operations/iam-token/create.md) an [{{ iam-short-name }} token](../../../iam/concepts/authorization/iam-token.md).
     1. Run this command:

        ```bash
        yc iam create-token | docker login --username iam --password-stdin {{ registry }}
        ```

        Result:

        ```text
        Login Succeeded
        ```

   {% endlist %}

1. Pull a Docker image from [Docker Hub](https://hub.docker.com/):

   ```bash
   docker pull ubuntu:20.04
   ```

   Result:

   ```text
   20.04: Pulling from library/ubuntu
   Digest: sha256:cf31af331f38d1d7158470e095b132acd126a7180a54f263d386da88********
   Status: Image is up to date for ubuntu:20.04
   docker.io/library/ubuntu:20.04
   ```

1. Assign a tag to the Docker image:

   ```bash
   docker tag ubuntu:20.04 {{ registry }}/<registry_ID>/ubuntu:20.04
   ```

1. Push the Docker image to {{ container-registry-name }}:

   ```bash
   docker push {{ registry }}/<registry_ID>/ubuntu:20.04
   ```

   Result:

   ```text
   The push refers to repository [{{ registry }}/crpu20rpdc2f********/ubuntu]
   2f140462f3bc: Layer already exists
   63c99163f472: Layer already exists
   ccdbb80308cc: Layer already exists
   20.04: digest: sha256:86ac87f73641c920fb42cc9612d4fb57b5626b56ea2a19b894d0673f******** size: 943
   ```