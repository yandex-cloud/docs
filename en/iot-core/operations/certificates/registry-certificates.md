# Managing registry certificates

For devices and registries to begin exchanging data and commands, you need to [log in](../../concepts/authorization.md). This section describes how to manage registry certificates for the appropriate authorization method.

{% include [pass-priority-note](../../../_includes/iot-core/pass-priority-note.md) %}

- [Viewing a list of registry certificates](registry-certificates.md#list-cert).
- [Adding a certificate to a registry](registry-certificates.md#add-cert).
- [Deleting a registry certificate](registry-certificates.md#delete-cert).

To access a [registry](../../concepts/index.md#registry), use its unique ID or name. For information on retrieving the unique registry ID or name, see [{#T}](../registry/registry-list.md).

## Getting a list of registry certificates {#registry-certificates-list}

{% include [registry-certificates-list](../../../_includes/iot-core/registry-certificates-list.md) %}

## Adding a certificate {#add-cert}

{% list tabs %}

- Management console

   To add a certificate to a registry:

   1. In the [management console]({{ link-console-main }}), select the folder to add the registry certificate to.
   1. Select **{{ iot-short-name }}**.
   1. Select the desired registry from the list.
   1. On the **Overview** page, go to the **Certificates** section and click **Add certificate**.

      - To add a file:

         1. Choose the **File** method.
         1. Click **Select file**.
         1. Specify the certificate file on your computer and click **Open**.
         1. Click **Add**.

      - To add text:

         1. Choose the **Text** method.
         1. Insert the certificate body in the **Contents** field.
         1. Click **Add**.

- CLI

   {% include [cli-install](../../../_includes/cli-install.md) %}

   Add a certificate to the registry:

   ```
   yc iot registry certificate add \
     --registry-name my-registry \ # Registry name.
     --certificate-file registry-cert.pem # Path to the public part of the certificate.
   ```

   Result:
   ```
   registry_id: b91ki3851hab9m0l68je
   fingerprint: 589ce1605...
   certificate_data: |
     -----BEGIN CERTIFICATE-----
     MIIE/jCCAuagAw...
     -----END CERTIFICATE-----
   created_at: "2019-05-29T16:40:48.230Z"
   ```

{% endlist %}

## Deleting a certificate {#delete-cert}

{% list tabs %}

- Management console

   To delete a registry certificate:

   1. In the [management console]({{ link-console-main }}), select the folder to delete the registry certificate from.
   1. Select **{{ iot-short-name }}**.
   1. Select the desired registry from the list.
   1. On the **Overview** page, go to the **Certificates** section.
   1. In the row with the certificate in question, click ![image](../../../_assets/horizontal-ellipsis.svg) and select **Delete** from the drop-down list.
   1. In the window that opens, click **Delete**.

- CLI

   {% include [cli-install](../../../_includes/cli-install.md) %}

   1. Delete a registry certificate:

      ```
      yc iot registry certificate delete --registry-name my-registry --fingerprint 0f...
      ```

   2. Make sure the certificate was deleted:

      ```
      yc iot registry certificate list --registry-name my-registry
      ```

      Result:

      ```
      +-------------+------------+
      | FINGERPRINT | CREATED AT |
      +-------------+------------+
      +-------------+------------+
      ```

{% endlist %}

