# Configuring the environment for service custom deployment

1. [Create a Docker image](../user-images.md) in the project and install necessary dependencies in the build script. Build the image.

1. [Create a secret](../data/secrets.md#create) with a password for your container registry.

   If you are using a registry created in {{ container-registry-full-name }}, authenticate using the authorized key for the [service account](../../../iam/concepts/users/service-accounts.md) that has the [required roles](../../../container-registry/security/index.md) and is specified in the [project settings](../projects/update.md).

   1. {% include [cli-install](../../../_includes/cli-install.md) %}

   1. Get authorized keys for your service account and save them to the `key.json` file:

      ```bash
      yc iam key create --service-account-name default-sa -o key.json
      ```

      Result:

      ```text
      id: aje8a87g4eaj********
      service_account_id: aje3932acde3********
      created_at: "2019-05-31T16:56:47Z"
      key_algorithm: RSA_2048
      ```

   1. Run this command:

      ```bash
      cat key.json | docker login \
        --username json_key \
        --password-stdin \
        {{ registry }}
      ```

      Where:
      * The `cat key.json` command writes the contents of the key file to the output stream.
      * The `--password-stdin` flag allows the password to be read from the input stream.

      Result:

      ```text
      Login succeeded
      ```

   {% include [disclaimer](../../../_includes/iam/authorized-keys-disclaimer.md) %}

1. [Upload](../../../container-registry/operations/docker-image/docker-image-push.md) the Docker image to the container registry. To do this, run the cell with the code:

   ```
   #!:docker-publish <image_name>:<image_tag> {{ registry }}/<registry_path>:<tag>
   ```

   * `<image_name>`: Image name in {{ ml-platform-name }}.
   * `<image_tag>`: Image tag in {{ ml-platform-name }}.
   * `<registry_path>`: {{ container-registry-name }} registry path.
   * `<tag>`: Image [tag](../../../container-registry/concepts/docker-image.md#version).

   During the uploading, specify the username and choose a secret with a password. For authorization in {{ container-registry-name }}, provide the `json_key` token type as username and enter the secret as password.

1. In the [node](../../concepts/deploy/index.md#node) creation form, specify the path to the image in `{{ registry }}/<registry_path>:<tag>` format.