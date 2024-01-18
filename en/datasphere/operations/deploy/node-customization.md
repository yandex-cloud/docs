# Configuring the environment for service custom deployment

1. [Create a Docker image](../user-images.md) in the project and install necessary dependencies in the build script. Build the image.

1. [Create a secret](../data/secrets.md#create) with a password for your container registry. If you use the {{ container-registry-full-name }} registry, [authenticate using the authorized key](../../../container-registry/operations/authentication.md#sa-json) for your [service account](../../../iam/concepts/users/service-accounts.md) that has the [required roles](../../../container-registry/security/index.md) and is specified in the [project settings](../projects/update.md). To generate the authorized key, run the command in the CLI:

   ```
   yc iam key create --service-account-id <service_account_ID> -o key.json
   ```

   The contents of the `key.json` file will serve as the password for the service account `<service_account_ID>`.

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