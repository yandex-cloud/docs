---
title: "How to create, update, and destroy digital signature key pairs"
description: "This guide describes how you can create, update, and destroy digital signature key pairs."
---

# Managing digital signature key pairs

{% note info %}

{% include [preview-pp.md](../../_includes/preview-pp.md) %}

{% endnote %}

You can use {{ kms-name }} to create, update, and destroy digital signature key pairs.

## Creating digital signature key pairs {#create}

To create a digital signature key pair:

{% list tabs %}

- Management console

  1. In the [management console]({{ link-console-main }}), select the [folder](../../resource-manager/concepts/resources-hierarchy.md#folder) to create your key pair in.
  1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_kms }}**.
  1. In the left-hand panel, select ![image](../../_assets/kms/asymmetric-key.svg) **{{ ui-key.yacloud.kms.switch_asymmetric-keys }}**.
  1. In the top-right corner, click **{{ ui-key.yacloud.kms.asymmetric-keys.title_create }}**. In the window that opens:
      1. Enter a name and an optional description.
      1. In the **{{ ui-key.yacloud.kms.asymmetric-key.form.title_type }}** field, select `{{ ui-key.yacloud.kms.asymmetric-key.form.label_signature }}`.
      1. In the **{{ ui-key.yacloud.kms.asymmetric-key.form.title_algorithm }}** field, select the appropriate signature algorithm.
      1. Enable deletion protection if required.
      1. Click **{{ ui-key.yacloud.common.create }}**.

- CLI

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  1. View a description of the CLI command to create a digital signature key pair:

      ```bash
      yc kms asymmetric-signature-key create --help
      ```

  1. [Get](../../resource-manager/operations/folder/get-id.md) the ID of the folder to create the key pair in.

  1. Create your digital signature key pair:

      ```bash
      yc kms asymmetric-signature-key create \
        --name <key_pair_name> \
        --folder-id <folder_ID> \
        --signature-algorithm <signature_algorithm>
      ```

      Where:
      * `--name`: Name of the digital signature key pair.
      * `--folder-id`: ID of the folder where the key pair will be created.
      * `--signature-algorithm`: Digital signature algorithm. The following [ECDSA](https://en.wikipedia.org/wiki/Elliptic_Curve_Digital_Signature_Algorithm) and [RSA](https://en.wikipedia.org/wiki/RSA_(cryptosystem)) algorithms are available:

          * `rsa-2048-sign-pss-sha-256`
          * `rsa-2048-sign-pss-sha-384`
          * `rsa-2048-sign-pss-sha-512`
          * `rsa-3072-sign-pss-sha-256`
          * `rsa-3072-sign-pss-sha-384`
          * `rsa-3072-sign-pss-sha-512`
          * `rsa-4096-sign-pss-sha-256`
          * `rsa-4096-sign-pss-sha-384`
          * `rsa-4096-sign-pss-sha-512`
          * `ecdsa-nist-p256-sha-256`
          * `ecdsa-nist-p384-sha-384`
          * `ecdsa-nist-p521-sha-512`
          * `ecdsa-secp256-k1-sha-256`

      Result:

      ```bash
      id: abj9g2dil5sj********
      folder_id: b1gt6g8ht345********
      created_at: "2023-08-16T09:06:57Z"
      name: sample-signature-key
      status: ACTIVE
      signature_algorithm: RSA_2048_SIGN_PSS_SHA_512
      ```

{% endlist %}

## Updating digital signature key pairs {#update}

After creating a key pair, you can change its name, description, and labels, as well as enable or disable deletion protection.

To update a digital signature key pair:

{% list tabs %}

- Management console

  1. In the [management console]({{ link-console-main }}), select the [folder](../../resource-manager/concepts/resources-hierarchy.md#folder) with the appropriate key pair.
  1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_kms }}**.
  1. In the left-hand panel, select ![image](../../_assets/kms/asymmetric-key.svg) **{{ ui-key.yacloud.kms.switch_asymmetric-keys }}**.
  1. Go to the **{{ ui-key.yacloud.kms.asymmetric-key.form.label_signature }}** tab.
  1. In the line with the appropriate key pair, click ![image](../../_assets/console-icons/ellipsis.svg) and select **{{ ui-key.yacloud.common.edit }}**. In the window that opens:
      1. Change the required key pair attributes.
      1. Click **{{ ui-key.yacloud.common.save }}**.

- CLI

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  1. View a description of the CLI command to update a digital signature key pair:

      ```bash
      yc kms asymmetric-signature-key update --help
      ```

  1. [Get](../../resource-manager/operations/folder/get-id.md) the ID of the folder with the key pair.

  1. {% include [get-signature-key](../../_includes/kms/get-signature-key.md) %}

  1. Update the digital signature key pair:

      ```bash
      yc kms asymmetric-signature-key update \
        --id <key_pair_ID> \
        --new-name <key_pair_new_name> \
        --deletion-protection
      ```

      Where:
      * `--id`: ID of the digital signature key pair.
      * `--new-name`: New name for the key pair.
      * `--deletion-protection`: Flag to enable deletion protection. To disable the key pair's deletion protection, use the `--no-deletion-protection` flag.

      Result:

      ```bash
      id: abj9g2dil5sj********
      folder_id: b1gt6g8ht345********
      created_at: "2023-08-16T09:06:57Z"
      name: sample-new-key
      status: ACTIVE
      signature_algorithm: RSA_2048_SIGN_PSS_SHA_512
      deletion_protection: true
      ```

     The command renamed the digital signature key pair and enabled its deletion protection.

{% endlist %}

## Deleting digital signature key pair {#delete}

To delete your digital signature key pair:

{% list tabs %}

- Management console

  1. In the [management console]({{ link-console-main }}), select the [folder](../../resource-manager/concepts/resources-hierarchy.md#folder) with the appropriate key pair.
  1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_kms }}**.
  1. In the left-hand panel, select ![image](../../_assets/kms/asymmetric-key.svg) **{{ ui-key.yacloud.kms.switch_asymmetric-keys }}**.
  1. Go to the **{{ ui-key.yacloud.kms.asymmetric-key.form.label_signature }}** tab.
  1. In the line with the appropriate key pair, click ![image](../../_assets/horizontal-ellipsis.svg) and select **{{ ui-key.yacloud.common.delete }}**.
  1. Confirm the deletion.

- CLI

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  1. View a description of the CLI command to delete a signature key pair:

      ```bash
      yc kms asymmetric-signature-key delete --help
      ```

  1. [Get](../../resource-manager/operations/folder/get-id.md) the ID of the folder with the key pair.

  1. {% include [get-signature-key](../../_includes/kms/get-signature-key.md) %}

  1. Delete the digital signature key pair by specifying its ID:

      ```bash
      yc kms asymmetric-signature-key delete \
        --id <key_pair_ID>
      ```

      Result:

      ```bash
      done (1s)
      id: abj9g2dil5sj********
      folder_id: b1gt6g8ht345********
      created_at: "2023-08-16T09:06:57Z"
      name: sample-new-key
      signature_algorithm: RSA_2048_SIGN_PSS_SHA_512
      ```

{% endlist %}