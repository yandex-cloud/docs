If you are frequent user of services with an AWS-compatible API, such as [{{ objstorage-full-name }}](../../storage/index.yaml), [{{ yds-full-name }}](../../data-streams/index.yaml), or [{{ message-queue-full-name }}](../../message-queue/index.yaml), it is your responsibility to safely store your [static access keys](../../iam/concepts/authorization/access-key.md).

This guide describes the scenario where a {{ lockbox-full-name }} [secret](../../lockbox/concepts/secret.md) is used as the static access key storage. In this configuration, the access key value is neither stored locally on the user's computer, nor displayed on the screen.

When accessing a resource of an AWS-compatible service ({{ objstorage-name }}), the static access key and its ID will be extracted from the {{ lockbox-name }} secret into special environment variables, which will be used for request authentication.

This approach will ensure safe storage and use of your key when accessing the services.

To use the static access key saved in a {{ lockbox-name }} secret:
1. [Prepare the environment](#prepare).
1. [Save the static access key to a {{ lockbox-name }} secret](#store-key-into-secret).
1. [Use the key from the {{ lockbox-name }} secret to work with the service](#use-key).

If you no longer need the resources you created, [delete them](#clear-out).


## Getting started {#before-you-begin}

{% include [before-you-begin](../_tutorials_includes/before-you-begin.md) %}


### Required paid resources {#paid-resources}

You will be charged for storing one version of the {{ lockbox-name }} secret (see [{{ lockbox-name }} pricing](../../lockbox/pricing.md#secrets)).

You will not be charged for the {{ objstorage-name }} bucket unless you keep your data in it (see [{{ objstorage-name }} pricing](../../storage/pricing.md#rules)).


## Prepare the environment {#prepare}

1. {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

1. [Install](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html) the AWS CLI.

   There is no need to configure the utility: all the required parameters will come with the command and environment variables.


## Save the static access key to the {{ lockbox-name }} secret {#store-key-into-secret}

{% list tabs group=instructions %}

- {{ yandex-cloud }} CLI {#cli}

   1. Create a [service account](../../iam/concepts/users/service-accounts.md), e.g., `storage-bucket-sa`, you will use to perform operations in {{ objstorage-name }}:

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

      Save the ID (`id`) of the service account you created: you will need it to assign roles to the service account.

      For more information about the `yc iam service-account create` command, see the [CLI reference](../../cli/cli-ref/iam/cli-ref/service-account/create.md).

   1. Assign the `storage.editor` [role](../../storage/security/index.md#storage-editor) for the folder to the service account:

      ```bash
      yc resource-manager folder add-access-binding <folder_name_or_ID> \
        --role storage.editor \
        --subject serviceAccount:<service_account_ID>
      ```

      Where:
      * `<folder_name_or_ID>`: Name or [ID](../../resource-manager/operations/folder/get-id.md) of the folder where the service account was created.
      * `<service_account_ID>`: ID of the previously saved service account.

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

   1. Create a static access key for the service account. For the key value not to be shown on the screen, it will be saved to the `STATIC_KEY` variable:

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
      * `--cloud-id`: [ID](../../resource-manager/operations/cloud/get-id.md) of the cloud the service account was created in.
      * `--folder-id`: ID of the folder the service account was created in.
      * `--deletion-protection`: Secret deletion protection. You cannot delete a secret with this option enabled. This is an optional parameter.

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

The service account's static access key is now saved inside the {{ lockbox-name }} secret.


## Use the key from the {{ lockbox-name }} secret to work with the service {#use-key}

1. Get the static access key saved in the `static-key` secret. For the key value not to be shown on the screen, it will be saved in the `SECRET` variable:

   {% list tabs group=instructions %}

   - {{ yandex-cloud }} CLI {#cli}

      ```bash
      SECRET=$(yc lockbox payload get static-key)
      ```

      For more information about the `yc lockbox payload get` command, see the [CLI reference](../../cli/cli-ref/lockbox/cli-ref/payload/get.md).

   {% endlist %}

1. Save the key ID, secret key, and placement region to the AWS CLI environment variables:

   ```bash
   export AWS_ACCESS_KEY_ID=$(echo | awk '{if (match($0, "key: ")) {print substr($0, RSTART + 5, 25)}}' <<< "$SECRET") \
     && export AWS_SECRET_ACCESS_KEY=$(echo | awk '{if (match($0, "text_value: ")) {print substr($0, RSTART + 12, 40)}}' <<< "$SECRET") \
     && export AWS_DEFAULT_REGION="{{ region-id }}"
   ```

   The AWS CLI will use the environment variables you created for authentication when performing operations with the service's resources.

1. Create a bucket in {{ objstorage-name }} by specifying a unique [bucket name](../../storage/concepts/bucket.md#naming) in the command:

   {% list tabs group=instructions %}

   - AWS CLI {#aws-cli}

      ```bash
      aws --endpoint-url=https://storage.yandexcloud.net \
        s3 mb s3://<bucket_name>
      ```

      Result:

      ```bash
      make_bucket: my-first-bucket
      ```

   {% endlist %}

   A new bucket has been created in {{ objstorage-full-name }}. When performing this operation, authentication was performed using the static access key obtained from the {{ lockbox-name }} secret and saved to the environment variables.

   You can also include the key ID, secret key, and placement region values directly in every AWS CLI command instead of creating environment variables:

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
1. [Delete the secret](../../lockbox/operations/secret-delete.md).
1. [Delete the bucket](../../storage/operations/buckets/delete.md).