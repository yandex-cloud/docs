---
title: Backing up TLS certificates
description: To back up and save your TLS certificate, get the certificate ID and contents and put the resulting files in a secure long-term storage. Repeat the steps for each certificate you want to back up. To restore a TLS certificate, follow the steps in this article.
---

# Backing up certificates

## Saving a certificate {#backup}

To save a certificate:
1. Get the certificate ID.

   {% list tabs group=instructions %}

   - Management console {#console}

     1. In the [management console]({{ link-console-main }}), select the [folder](../../resource-manager/concepts/resources-hierarchy.md#folder) containing the certificate.
     1. Navigate to **{{ ui-key.yacloud.iam.folder.dashboard.label_certificate-manager }}**.
     1. Copy the **{{ ui-key.yacloud.common.id }}** field data for the certificate you want to save.

   - CLI {#cli}

     {% include [cli-install](../../_includes/cli-install.md) %}

     {% include [default-catalogue](../../_includes/default-catalogue.md) %}

     1. View the description of the CLI command for getting a list of certificates:

        ```bash
        yc cm certificate list --help
        ```

     1. Run this command:

        ```bash
        yc cm certificate list
        ```

   - API {#api}

     To get the certificate ID, use the [list](../api-ref/Certificate/list.md) REST API method for the [Certificate](../api-ref/Certificate/) resource or the [CertificateService/List](../api-ref/grpc/Certificate/list.md) gRPC API call.


   {% endlist %}

1. Get the certificate contents.

   {% list tabs group=instructions %}

   - CLI {#cli}

     {% include [cli-install](../../_includes/cli-install.md) %}

     {% include [default-catalogue](../../_includes/default-catalogue.md) %}

     1. View the description of the CLI command for getting certificate contents:

        ```bash
        yc cm certificate content --help
        ```

     1. Run this command:

        ```bash
        yc cm certificate content \
          --id <certificate_ID> \
          --chain <path_to_certificate_chain_file> \
          --key <path_to_private_key_file>
        ...
        ```

   - API {#api}

     To get the certificate contents, use the [get](../api-ref/CertificateContent/get.md) REST API method for the [CertificateContent](../api-ref/CertificateContent/) resource or the [CertificateContentService/Get](../api-ref/grpc/CertificateContent/get.md) gRPC API call.

   {% endlist %}

   Put the resulting files in a secure long-term storage.
1. Repeat the steps for each certificate you want to back up.

## Restoring a certificate {#restore}

{% note info %}

You cannot restore an expired certificate.

{% endnote %}

To restore a user certificate from the certificate chain and key files:
1. Prepare the files with the certificate contents.
1. Import the certificate.

   {% list tabs group=instructions %}

   - Management console {#console}

     1. In the [management console]({{ link-console-main }}), select the folder the certificate will be restored to.
     1. Navigate to **{{ ui-key.yacloud.iam.folder.dashboard.label_certificate-manager }}**.
     1. Click **{{ ui-key.yacloud.certificate-manager.button_empty-action }}**.
     1. In the menu that opens, select **{{ ui-key.yacloud.certificate-manager.action_import }}**.
     1. In the window that opens, enter a name for your certificate in the **{{ ui-key.yacloud.certificate-manager.metadata.field_name }}** field.
     1. Optionally, in the **Description** field, describe the certificate.
     1. In the **{{ ui-key.yacloud.certificate-manager.import.field_chain }}** field, click **{{ ui-key.yacloud.certificate-manager.import.button_add-chain }}**.
        1. Choose how to add it: `{{ ui-key.yacloud.component.file-content-dialog.value_upload }}`.
        1. Click **Attach file** and specify the certificate chain file.
        1. Click **{{ ui-key.yacloud.component.file-content-dialog.button_submit }}**.
     1. In the **{{ ui-key.yacloud.certificate-manager.import.field_privateKey }}** field, click **{{ ui-key.yacloud.certificate-manager.import.button_add-privateKey }}**.
        1. Choose how to add it: `{{ ui-key.yacloud.component.file-content-dialog.value_upload }}` or `{{ ui-key.yacloud.component.file-content-dialog.value_manual }}`.
        1. Click **Attach file** and specify the private key file.
        1. Click **{{ ui-key.yacloud.component.file-content-dialog.button_submit }}**.
     1. Click **{{ ui-key.yacloud.common.create }}**.

   - CLI {#cli}

     {% include [cli-install](../../_includes/cli-install.md) %}

     {% include [default-catalogue](../../_includes/default-catalogue.md) %}

     1. View the command description:

        ```bash
        yc cm certificate create --help
        ```

     1. Run this command:

        ```bash
        yc cm certificate create \
          --name <certificate_name> \
          --chain <path_to_certificate_chain_file> \
          --key <path_to_private_key_file>
        ...
        ```

   - API {#api}

     To import a certificate, use the [create](../api-ref/Certificate/create.md) REST API method for the [Certificate](../api-ref/Certificate/) resource or the [CertificateService/Create](../api-ref/grpc/Certificate/create.md) gRPC API call.

   {% endlist %}

   The ID of the restored certificate will be different from the ID the certificate had upon saving.
1. Repeat the steps for each certificate you want to restore.

If you restore a saved [Let's Encrypt certificate](../concepts/managed-certificate.md), it becomes a [custom](../concepts/imported-certificate.md) one. To [renew](../operations/import/cert-update.md) this certificate, download its latest version yourself.

#### See also {#see-also}

* [{#T}](import/cert-create.md)