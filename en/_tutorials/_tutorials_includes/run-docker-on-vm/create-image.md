1. To make command execution easier, add the following variables:
    * Username and your VM's public IP to the `${PUBLIC_IP}` variable:

        ```bash
        export PUBLIC_IP=<username>@<VM_public_IP_address>
        ```

    * ID of the previously created registry in `crpc9qeoft23********` format to the `${REGISTRY_ID}` variable:

        ```bash
        export REGISTRY_ID=<registry_ID>
        ```

1. Authenticate as yourself:

    {% list tabs group=registry_auth %}

    - OAuth token {#oauth-token}

      1. If you do not have an OAuth token yet, get one by following [this link]({{ link-cloud-oauth }}).
      1. Run this command:

          ```bash
          echo <OAuth_token> | docker login --username oauth --password-stdin {{ registry }}
          ```

          Result:

          ```text
          Login Succeeded
          ```

    - IAM token {#iam-token}

      {% note info %}

      {% include [iam-token-note](../../../_includes/iam/iam-token-note.md) %}

      {% endnote %}

      1. [Get](../../../iam/operations/iam-token/create.md) an {{ iam-name }} token.
      1. Run this command:

          ```bash
          yc iam create-token | docker login --username iam --password-stdin {{ registry }}
          ```

          Result:

          ```text
          ...
          Login Succeeded
          ```

    - Docker credential helper {#docker}

      1. If you do not have a YC CLI profile yet, [create one](../../../cli/quickstart.md#initialize).
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

          The credential helper only works if you use Docker without `sudo`. To learn how to configure Docker to run under the current user without `sudo`, see the [official documentation](https://docs.docker.com/engine/install/linux-postinstall/#manage-docker-as-a-non-root-user).

          {% endnote %}

      1. Make sure that Docker is configured.

          The following line must appear in the `/home/<user>/.docker/config.json` configuration file:

          ```json
          "{{ registry }}": "yc"
          ```

      1. You can now use Docker, for example, to [push Docker images](../../../container-registry/operations/docker-image/docker-image-push.md). You do not need to run the `docker login` command for that.

    {% endlist %}

1. Create a file called Dockerfile:

    ```bash
    touch .dockerfile
    ```

1. Open Dockerfile in a text editor, e.g.:

    ```bash
    nano .dockerfile
    ```

1. Add the lines below to the file:

    ```text
    FROM ubuntu:latest
    CMD echo "Hi, I'm inside"
    ```

1. Build the Docker image:

    ```bash
    docker build . -t {{ registry }}/${REGISTRY_ID}/ubuntu:hello -f .dockerfile
    ```

    Result:

    ```text
    ...
    Successfully built b68ee9b6b1af
    Successfully tagged {{ registry }}/crpmnjr98tm5********/ubuntu:hello
    ```

1. Push the built Docker image to {{ container-registry-name }}:

    ```bash
    docker push {{ registry }}/${REGISTRY_ID}/ubuntu:hello
    ```

    Result:

    ```text
    The push refers to repository [{{ registry }}/crpc9qeoft23********/ubuntu]
    cc9d18e90faa: Pushed
    0c2689e3f920: Pushed
    47dde53750b4: Pushed
    hello: digest: sha256:42068479274f1d4c7ea095482430dcba24dcfe8c23ebdf6d32305928******** size: 943
    ```