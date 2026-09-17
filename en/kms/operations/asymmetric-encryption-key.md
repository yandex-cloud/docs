---
title: How to create, update, and delete an encryption key pair
description: Follow this guide to create, update, and delete an encryption key pair.
---

# Managing encryption key pairs

You can use {{ kms-name }} to create, update, and delete asymmetric encryption key pairs.

## Creating an encryption key pair {#create}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the [folder](../../resource-manager/concepts/resources-hierarchy.md#folder) where you want to create your key pair.
  1. [Navigate]({{ link-console-main }}/link/kms) to **{{ ui-key.yacloud.iam.folder.dashboard.label_kms }}**.
  1. In the left-hand panel, select ![image](../../_assets/kms/asymmetric-key.svg) **{{ ui-key.yacloud.kms.switch_asymmetric-keys }}**.
  1. Click **{{ ui-key.yacloud.kms.asymmetric-keys.title_create }}**. In the window that opens:
      
      1. Enter a name and, optionally, a description.
      1. In the **{{ ui-key.yacloud.kms.asymmetric-key.form.title_type }}** field, select `{{ ui-key.yacloud.kms.asymmetric-keys.title_key-type-encryption }}`.
      1. In the **{{ ui-key.yacloud.kms.asymmetric-key.form.title_algorithm }}** field, select the encryption algorithm.
      1. Enable deletion protection, if required.
      1. Click **{{ ui-key.yacloud.common.create }}**.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  1. See the description of the CLI command for creating an encryption key pair:

      ```bash
      yc kms asymmetric-encryption-key create --help
      ```

  1. [Get](../../resource-manager/operations/folder/get-id.md) the ID of the folder where you want to create your key pair.

  1. Create your key pair:

      ```bash
      yc kms asymmetric-encryption-key create \
        --name <key_pair_name> \
        --encryption-algorithm <encryption_algorithm> \
        --folder-id <folder_ID>
      ```

      Where:
      
      * `--name`: Name of the encryption key pair.
      * `--folder-id`: ID of the folder where the key pair will be created.
      * `--encryption-algorithm`: Encryption algorithm. Here are available options:

          * `rsa-2048-enc-oaep-sha-256`
          * `rsa-3072-enc-oaep-sha-256`
          * `rsa-4096-enc-oaep-sha-256`

      Result:

      ```text
      id: abjfmo5enqlr********
      folder_id: b1gt6g8ht345********
      created_at: "2023-08-16T18:10:03Z"
      name: sample-encryption-key
      status: ACTIVE
      encryption_algorithm: RSA_2048_ENC_OAEP_SHA_256
      ```

- API {#api}

  To create an encryption key pair, use the [AsymmetricEncryptionKeyService/Create](../asymmetricencryption/api-ref/grpc/AsymmetricEncryptionKey/create.md) gRPC API call.

{% endlist %}

## Updating an encryption key pair {#update}

After creating an encryption key pair, you can change its name, description, and labels, as well as enable or disable deletion protection.

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the [folder](../../resource-manager/concepts/resources-hierarchy.md#folder) containing the key pair.
  1. [Navigate]({{ link-console-main }}/link/kms) to **{{ ui-key.yacloud.iam.folder.dashboard.label_kms }}**.
  1. In the left-hand panel, select ![image](../../_assets/kms/asymmetric-key.svg) **{{ ui-key.yacloud.kms.switch_asymmetric-keys }}**.
  1. Navigate to the **{{ ui-key.yacloud.kms.asymmetric-key.form.label_encryption }}** tab.
  1. In the key pair row, click ![image](../../_assets/console-icons/ellipsis.svg) and select ![pencil](../../_assets/console-icons/pencil.svg) **{{ ui-key.yacloud.common.edit }}**. In the window that opens:
      
      1. Change the key pair attributes as appropriate.
      1. Click **{{ ui-key.yacloud.common.save }}**.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  1. See the description of the CLI command for updating an encryption key pair:

      ```bash
      yc kms asymmetric-encryption-key update --help
      ```

  1. [Get](../../resource-manager/operations/folder/get-id.md) the ID of the folder containing the key pair.

  1. {% include [get-asymmetric-encryption-key](../../_includes/kms/get-a-encryption-key.md) %}

  1. Update your key pair:

      ```bash
      yc kms asymmetric-encryption-key update \
        --id <key_pair_ID> \
        --new-name <new_key_pair_name> \
        --deletion-protection
      ```

      Where:
      
      * `--id`: ID of the encryption key pair.
      * `--new-name`: New name for the key pair.
      * `--deletion-protection`: Flag to enable deletion protection. To disable key pair deletion protection, use the `--no-deletion-protection` flag.

      Result:

      ```text
      id: abjfmo5enqlr********
      folder_id: b1gt6g8ht345********
      created_at: "2023-08-16T18:10:03Z"
      name: new-encryption-key
      status: ACTIVE
      encryption_algorithm: RSA_2048_ENC_OAEP_SHA_256
      deletion_protection: true
      ```

      The above command renamed the encryption key pair and enabled its deletion protection.

- API {#api}

  To update an encryption key pair, use the [AsymmetricEncryptionKeyService/Update](../asymmetricencryption/api-ref/grpc/AsymmetricEncryptionKey/update.md) gRPC API call.

{% endlist %}

## Deleting an encryption key pair {#delete}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the [folder](../../resource-manager/concepts/resources-hierarchy.md#folder) containing the key pair.
  1. [Navigate]({{ link-console-main }}/link/kms) to **{{ ui-key.yacloud.iam.folder.dashboard.label_kms }}**.
  1. In the left-hand panel, select ![image](../../_assets/kms/asymmetric-key.svg) **{{ ui-key.yacloud.kms.switch_asymmetric-keys }}**.
  1. Navigate to the **{{ ui-key.yacloud.kms.asymmetric-key.form.label_encryption }}** tab.
  1. In the key pair row, click ![image](../../_assets/console-icons/ellipsis.svg) and select ![trash-bin](../../_assets/console-icons/trash-bin.svg) **{{ ui-key.yacloud.common.delete }}**.
  1. Confirm the deletion.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  1. See the description of the CLI command for deleting an encryption key pair:

      ```bash
      yc kms asymmetric-encryption-key delete --help
      ```

  1. [Get](../../resource-manager/operations/folder/get-id.md) the ID of the folder containing the key pair.

  1. {% include [get-asymmetric-encryption-key](../../_includes/kms/get-a-encryption-key.md) %}

  1. Delete the key pair by specifying its ID:

      ```bash
      yc kms asymmetric-encryption-key delete \
        --id <key_pair_ID>
      ```

      Result:

      ```text
      id: abjfmo5enqlr********
      folder_id: b1gt6g8ht345********
      created_at: "2023-08-16T18:10:03Z"
      name: new-encryption-key
      encryption_algorithm: RSA_2048_ENC_OAEP_SHA_256
      ```

- API {#api}

  To delete an encryption key pair, use the [AsymmetricEncryptionKeyService/Delete](../asymmetricencryption/api-ref/grpc/AsymmetricEncryptionKey/delete.md) gRPC API call.

{% endlist %}
