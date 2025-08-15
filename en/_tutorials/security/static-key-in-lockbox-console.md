1. [Set up your environment](#prepare).
1. [Save the static access key to a {{ lockbox-name }} secret](#store-key-into-secret).
1. [Use the key from the {{ lockbox-name }} secret for your operations with the service](#use-key).

If you no longer need the resources you created, [delete them](#clear-out).


## Getting started {#before-you-begin}

{% include [before-you-begin](../_tutorials_includes/before-you-begin.md) %}


### Required paid resources {#paid-resources}

{% include [paid-resources](../_tutorials_includes/static-key-in-lockbox/paid-resources.md) %}


## Set up your environment {#prepare}

1. {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

1. {% include [prepare](../_tutorials_includes/static-key-in-lockbox/prepare.md) %}


## Save the static access key to the {{ lockbox-name }} secret {#store-key-into-secret}

{% list tabs group=instructions %}

- {{ yandex-cloud }} CLI {#cli}

  1. Create a service account, e.g., `storage-bucket-sa`, that you will use to perform operations in {{ objstorage-name }}:

      ```bash
      yc iam service-account create storage-bucket-sa
      ```

      Result:

      ```text
      done (1s)
      id: ajeplujf759j********
      folder_id: b1gt6g8ht345********
      created_at: "2024-05-07T19:18:37.244159066Z"
      name: storage-bucket-sa
      ```

      Save the service account `id`, as you will need it to assign roles to the service account.

      For more information about the `yc iam service-account create` command, see the [CLI reference](../../cli/cli-ref/iam/cli-ref/service-account/create.md).

  1. Assign the `storage.editor` [role](../../storage/security/index.md#storage-editor) for the folder to the service account you created.

      ```bash
      yc resource-manager folder add-access-binding <folder_name_or_ID> \
        --role storage.editor \
        --subject serviceAccount:<service_account_ID>
      ```

      Where:

      * `<folder_name_or_ID>`: Name or [ID](../../resource-manager/operations/folder/get-id.md) of the folder where you created the service account.
      * `<service_account_ID>`: Service account ID you saved in the previous step.

      Result:

      ```yml
      done (2s)
      effective_deltas:
        - action: ADD
          access_binding:
            role_id: storage.editor
            subject:
              id: ajeplujf759j********
              type: serviceAccount
      ```

      For more information about the `yc resource-manager folder add-access-binding` command, see the [CLI reference](../../cli/cli-ref/resource-manager/cli-ref/folder/add-access-binding.md).

  1. Similarly, assign the `{{ roles-lockbox-payloadviewer }}` [role](../../lockbox/security/index.md#lockbox-payloadViewer) for the folder to the service account:

      ```bash
      yc resource-manager folder add-access-binding <folder_name_or_ID> \
        --role {{ roles-lockbox-payloadviewer }} \
        --subject serviceAccount:<service_account_ID>
      ```

  1. Create a static access key for the service account. To avoid displaying the key value on the screen, it will be saved to the `STATIC_KEY` variable:

      ```bash
      STATIC_KEY=$(yc iam access-key create --service-account-name storage-bucket-sa)
      ```

      For more information about the `yc iam access-key create` command, see the [CLI reference](../../cli/cli-ref/iam/cli-ref/access-key/create.md).

  1. Save the [key ID](../../iam/concepts/authorization/access-key.md#key-id) and [secret key](../../iam/concepts/authorization/access-key.md#private-key) values to the separate `KEY_ID` and `KEY_VALUE` variables:

      ```bash
      KEY_ID=$(echo | awk '{if (match($0, "key_id: ")) {print substr($0, RSTART + 8, 25)}}' <<< "$STATIC_KEY") \
        && KEY_VALUE=$(echo | awk '{if (match($0, "secret: ")) {print substr($0, RSTART + 8, 40)}}' <<< "$STATIC_KEY")
      ```

  1. Create a {{ lockbox-name }} secret named `static-key` containing the new static access key:

      ```bash
      yc lockbox secret create \
        --name static-key \
        --payload "[{'key': $KEY_ID, 'text_value': $KEY_VALUE}]" \
        --cloud-id <cloud_ID> \
        --folder-id <folder_ID> \
        --deletion-protection
      ```

      Where:

      * `--cloud-id`: [ID](../../resource-manager/operations/cloud/get-id.md) of the cloud where you created the service account.
      * `--folder-id`: ID of the folder where you created the service account.
      * `--deletion-protection`: Secret deletion protection. You cannot delete a secret with this option enabled. This is an optional setting.

      Result:

      ```yml
      done (1s)
      id: e6qk0c62b4ep********
      folder_id: b1gt6g8ht345********
      created_at: "2024-05-07T20:05:51.569Z"
      name: static-key
      status: ACTIVE
      current_version:
        id: e6qrsj2hi8ug********
        secret_id: e6qk0c62b4ep********
        created_at: "2024-05-07T20:05:51.569Z"
        status: ACTIVE
        payload_entry_keys:
          - YCAJEO4w80Zf5DERM********
      deletion_protection: true
      ```

      For more information about the `yc lockbox secret create` command, see the [CLI reference](../../cli/cli-ref/lockbox/cli-ref/secret/create.md).

{% endlist %}

The service account's static access key is now securely held in the {{ lockbox-name }} secret.


## Use the key from the {{ lockbox-name }} secret for your operations with the service {#use-key}

{% include [bash-windows-note-single](../../_includes/translate/bash-windows-note-single.md) %}

1. Get the static access key saved in the `static-key` secret. To avoid displaying the key value on the screen, it will be saved to the `SECRET` variable:

    {% list tabs group=instructions %}

    - {{ yandex-cloud }} CLI {#cli}

      ```bash
      SECRET=$(yc lockbox payload get <secret_name_or_ID>)
      ```
      Use either the `--id` or `--name` parameter.

      For more information about the `yc lockbox payload get` command, see the [CLI reference](../../cli/cli-ref/lockbox/cli-ref/payload/get.md).

    {% endlist %}

1. Save the key ID, secret key, and placement region to the AWS CLI environment variables:

    ```bash
    export AWS_ACCESS_KEY_ID=$(echo | awk '{if (match($0, "key: ")) {print substr($0, RSTART + 5, 25)}}' <<< "$SECRET") \
      && export AWS_SECRET_ACCESS_KEY=$(echo | awk '{if (match($0, "text_value: ")) {print substr($0, RSTART + 12, 40)}}' <<< "$SECRET") \
      && export AWS_DEFAULT_REGION="{{ region-id }}"
    ```

    The AWS CLI will use the environment variables you created for authentication when performing operations with the service resources.

1. Create a bucket in {{ objstorage-name }}, specifying a unique [bucket name](../../storage/concepts/bucket.md#naming) in the command:

    {% include [create-bucket](../_tutorials_includes/static-key-in-lockbox/create-bucket.md) %}

    {% list tabs group=instructions %}

    - AWS CLI {#aws-cli}

      ```bash
      AWS_ACCESS_KEY_ID=$(echo | awk '{if (match($0, "key: ")) {print substr($0, RSTART + 5, 25)}}' <<< "$SECRET") \
        AWS_SECRET_ACCESS_KEY=$(echo | awk '{if (match($0, "text_value: ")) {print substr($0, RSTART + 12, 40)}}' <<< "$SECRET") \
        AWS_DEFAULT_REGION="{{ region-id }}" \
        aws --endpoint-url=https://storage.yandexcloud.net \
        s3 mb s3://<bucket_name>
      ```

      Result:

      ```bash
      make_bucket: my-first-bucket
      ```

    {% endlist %}


## How to delete the resources you created {#clear-out}

To stop using the resources you created:
1. [Delete](../../lockbox/operations/secret-delete.md) the secret.
1. [Delete](../../storage/operations/buckets/delete.md) the bucket.