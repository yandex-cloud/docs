---
title: "Backing up TLS certificates"
description: "To back up and save your TLS certificate, get the certificate ID and contents and keep the resulting files in a secure place for long-term storage. Repeat the procedure for each certificate you want to back up. To restore a TLS certificate, follow the steps in the article."
---

# Back up certificates

## Save a certificate {#backup}

To save a certificate:

1. Get the certificate ID.

   {% list tabs %}

   - Management console

      1. In the [management console]({{ link-console-main }}), select the [folder](../../resource-manager/concepts/resources-hierarchy.md#folder) where the certificate is located.
      1. From the list of services, select {{ certificate-manager-name }}.
      1. Copy the contents of the **ID** field for the certificate you want to save.

   - CLI

      {% include [cli-install](../../_includes/cli-install.md) %}

      {% include [default-catalogue](../../_includes/default-catalogue.md) %}

      1. View a description of the CLI command to get the certificate list:

         ```bash
         yc cm certificate list --help
         ```

      1. Run the command:

         ```bash
         yc cm certificate list
         ```

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

      1. Run the command:

         ```bash
         yc cm certificate content \
         --id <certificate ID> \
         --chain <path to the file to save the chain to> \
         --key <path to the file to save the key to>
         ...
         ```

   {% endlist %}

   Keep the resulting files in a secure place for long-term storage.

1. Repeat the procedure for each certificate you want to back up.

## Restore a certificate {#restore}

{% note info %}

You can't restore an expired certificate.

{% endnote %}

To restore a user certificate from the certificate chain and key files:

1. Prepare the files with the certificate contents.
1. Import the certificate.

   {% list tabs %}

   - Management console

      1. In the [management console]({{ link-console-main }}), select the folder where the certificate will be restored.
      1. In the list of services, select **{{ certificate-manager-name }}**.
      1. Click **Add certificate**.
      1. In the menu that opens, select **User certificate**.
      1. In the window that opens, enter a name for the certificate in the **Name** field.
      1. (optional) In the **Description** field, enter a description for the certificate.
      1. In the **Intermediate certificate chain** field, click **Add chain**.
         1. Select **File** as the adding method.
         1. Click **Select file** and specify the certificate chain file.
         1. Click **Add**.
      1. In the **Private key** field, click **Add private key**.
         1. Select how to add your certificate: **File** or **Text**.
         1. Click **Select file** and specify the private key file.
         1. Click **Add**.
      1. Click **Create**.

   - CLI

      {% include [cli-install](../../_includes/cli-install.md) %}

      {% include [default-catalogue](../../_includes/default-catalogue.md) %}

      1. View a description of the command:

         ```bash
         yc cm certificate create --help
         ```

      1. Run the command:

         ```bash
         yc cm certificate create \
         --name <certificate name> \
         --chain <path to the certificate chain file> \
         --key <path to the private key file>
         ...
         ```

   {% endlist %}

   The ID of the restored certificate will be different from the ID that the certificate had when it was saved.

1. Repeat the process for each certificate you want to restore.

The saved [Let's Encrypt<sup>®</sup> certificate](../concepts/managed-certificate.md) becomes a [user certificate](../concepts/imported-certificate.md) after it's restored. To [renew](../operations/import/cert-update.md) this certificate, download its latest version yourself.

#### See also {#see-also}

- [{#T}](import/cert-create.md).
