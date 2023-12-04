---
title: "Backing up TLS certificates"
description: "To back up and save your TLS certificate, get the certificate ID and contents and keep the resulting files in a secure place for long-term storage. Repeat the procedure for each certificate you want to back up. To restore a TLS certificate, follow the steps in the article."
---

# Back up certificates

## Saving a certificate {#backup}

To save a certificate:
1. Get the certificate ID.

   {% list tabs %}

   - Management console

      1. In the [management console]({{ link-console-main }}), select the [folder](../../resource-manager/concepts/resources-hierarchy.md#folder) where the certificate is located.
      1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_certificate-manager }}**.
      1. Copy the contents of the **{{ ui-key.yacloud.common.id }}** field for the certificate you want to save.

   - CLI

      {% include [cli-install](../../_includes/cli-install.md) %}

      {% include [default-catalogue](../../_includes/default-catalogue.md) %}

      1. View a description of the CLI command to get the certificate list:

         ```bash
         yc cm certificate list --help
         ```

      1. Run this command:

         ```bash
         yc cm certificate list
         ```

   - API

      To get the certificate ID, use the [list](../api-ref/Certificate/list.md) REST API method for the [Certificate](../api-ref/Certificate/) resource or the [CertificateService/List](../api-ref/grpc/certificate_service.md#List) gRPC API call.


   {% endlist %}

1. Get the contents of the certificate.

   {% list tabs %}

   - CLI

      {% include [cli-install](../../_includes/cli-install.md) %}

      {% include [default-catalogue](../../_includes/default-catalogue.md) %}

      1. View a description of the CLI command to get the certificate contents:

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

   - API

      To get the certificate contents, use the [get](../api-ref/CertificateContent/get.md) REST API method for the [CertificateContent](../api-ref/CertificateContent/) resource or the [CertificateContentService/Get](../api-ref/grpc/certificate_content_service.md#Get) gRPC API call.

   {% endlist %}

   Keep the resulting files in a secure place for long-term storage.
1. Repeat the procedure for each certificate you want to back up.

## Restoring a certificate {#restore}

{% note info %}

You can't restore an expired certificate.

{% endnote %}

To restore a user certificate from the certificate chain and key files:
1. Prepare the files with the certificate contents.
1. Import the certificate.

   {% list tabs %}

   - Management console

      1. In the [management console]({{ link-console-main }}), select the folder where the certificate will be restored.
      1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_certificate-manager }}**.
      1. Click **{{ ui-key.yacloud.certificate-manager.button_add }}**.
      1. In the menu that opens, select **{{ ui-key.yacloud.certificate-manager.action_import }}**.
      1. In the window that opens, enter a name for your certificate in the **{{ ui-key.yacloud.certificate-manager.metadata.field_name }}** field.
      1. (Optional) In the **Description** field, enter a description for the certificate.
      1. In the **{{ ui-key.yacloud.certificate-manager.import.field_chain }}** field, click **{{ ui-key.yacloud.certificate-manager.import.button_add-chain }}**.
         1. Choose how to add a certificate: `{{ ui-key.yacloud.component.file-content-dialog.value_upload }}`.
         1. Click **Attach file** and specify the certificate chain file.
         1. Click **{{ ui-key.yacloud.component.file-content-dialog.button_submit }}**.
      1. In the **{{ ui-key.yacloud.certificate-manager.import.field_privateKey }}** field, click **{{ ui-key.yacloud.certificate-manager.import.button_add-privateKey }}**.
         1. Choose how to add it: `{{ ui-key.yacloud.component.file-content-dialog.value_upload }}` or `{{ ui-key.yacloud.component.file-content-dialog.value_manual }}`.
         1. Click **Attach file** and specify the private key file.
         1. Click **{{ ui-key.yacloud.component.file-content-dialog.button_submit }}**.
      1. Click **{{ ui-key.yacloud.common.create }}**.

   - CLI

      {% include [cli-install](../../_includes/cli-install.md) %}

      {% include [default-catalogue](../../_includes/default-catalogue.md) %}

      1. View a description of the command:

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

   - API

      To import a certificate, use the [create](../api-ref/Certificate/create.md) REST API method for the [Certificate](../api-ref/Certificate/) resource or the [CertificateService/Create](../api-ref/grpc/certificate_service.md#Create) gRPC API call.

   {% endlist %}

   The ID of the restored certificate will be different from the ID that the certificate had when it was saved.
1. Repeat the process for each certificate you want to restore.

The saved [Let's Encrypt certificate](../concepts/managed-certificate.md) becomes a [custom](../concepts/imported-certificate.md) certificate after it's restored. To [renew](../operations/import/cert-update.md) this certificate, download its latest version yourself.

#### See also {#see-also}

* [{#T}](import/cert-create.md)