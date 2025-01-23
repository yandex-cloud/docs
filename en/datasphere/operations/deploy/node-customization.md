---
title: Configuring the environment for deploying a standalone service
description: Follow this guide to configure the environment for deploying a standalone service.
---

# Configuring the environment for deploying a standalone service

1. [Create a Docker image](../user-images.md) in the project and install the required dependencies in the build script. Build the image.

1. [Create a secret](../data/secrets.md#create) with a password for your container registry.

   If you are using a registry created in {{ container-registry-full-name }}, get authenticated using the authorized key for the [service account](../../../iam/concepts/users/service-accounts.md) that has the [required roles](../../../container-registry/security/index.md) and is specified in the [project settings](../projects/update.md):

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

   1. Run the following command:

      ```bash
      cat key.json | docker login \
        --username json_key \
        --password-stdin \
        {{ registry }}
      ```

      Where:
      * `cat key.json`: Command to write the contents of the key file to the output stream.
      * `--password-stdin`: Flag that enables reading the password from the input stream.

      Result:

      ```text
      Login Succeeded
      ```
   {% include [disclaimer](../../../_includes/iam/authorized-keys-disclaimer.md) %}

1. [Upload](../../../container-registry/operations/docker-image/docker-image-push.md) the Docker image to the container registry. To do this, run this code in a cell:

   ```text
   #!:docker-publish <image_name>:<image_tag> {{ registry }}/<image_path>:<tag>
   ```

   * `<image_name>`: Name of the image in {{ ml-platform-name }}.
   * `<image_tag>`: Tag of the image in {{ ml-platform-name }}.
   * `<image_path>`: Path to the {{ container-registry-name }} image in `cr.yandex/<registry_ID>/<image_name>` format.
   * `<tag>`: Image [tag](../../../container-registry/concepts/docker-image.md#version).

   While uploading, enter the username and select the secret containing the password. When getting authorized in {{ container-registry-name }}, provide the `json_key` token type for the username and the secret for the password.

1. In the [node](../../concepts/deploy/index.md#node) creation form, specify the path to the image in this format: `{{ registry }}/<registry_address>:<tag>`.
