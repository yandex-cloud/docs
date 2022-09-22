# Configuring the environment for service custom deployment

1. [Create a Docker image](../user-images.md) in the project and install necessary dependencies in the build script. Build the image.

1. [Create a secret](../data/secrets.md#create) with a password for your container registry. If you use the {{ container-registry-full-name }} registry, [authenticate using the authorized key](../../../container-registry/operations/authentication.md#sa-json) for your [service account](../../../iam/concepts/users/service-accounts.md). To generate the authorized key, run the command in the CLI:

   ```
   yc iam key create --service-account-id <service_account_id> -o key.json
   ```

   The password for the `<service_account_id>` is the contents of the `key.json` file.

1. [Upload](../../../container-registry/operations/docker-image/docker-image-push.md) the Docker image to the container registry. To do this, run the cell with the code:

   ```
   #!:docker-publish <datasphere_image_name>:<datasphere_image_tag> cr.yandex/<cloud_registry_path>:<tag>
   ```

   * `<datasphere_image_name>`: Image name in {{ ml-platform-name }}.
   * `<datasphere_image_tag>`: Image tag in {{ ml-platform-name }}.
   * `<cloud_registry_path>`: {{ container-registry-name }} registry path.
   * `<tag>`: Docker image [tag](../../../container-registry/concepts/docker-image.md#version).

   During the uploading, specify the username and choose a secret with a password. For authorization in {{ container-registry-name }}, enter the token type `json_key` as the username, and enter the secret as the password.

1. In the node creation form, specify the path to the image in the format `cr.yandex/<cloud_registry_path>:<tag>`.