---

__system: {"dislikeVariants":["No answer to my question","Recomendations didn't help","The content doesn't match title","Other"]}
---
# Managing device certificates

For devices and registries to begin exchanging data and commands, you need to [log in](../../concepts/authorization.md). This section describes how to manage device certificates for the relevant authorization method.

{% include [pass-priority-note](../../../_includes/iot-core/pass-priority-note.md) %}

- [Viewing a list of device certificates](device-certificates.md#list-cert).
- [Adding a certificate to a device](device-certificates.md#add-cert).
- [Deleting a device certificate](device-certificates.md#delete-cert).

To access a [device](../../concepts/index.md#device), use its unique ID or name. For information about how to get its unique ID or name, see [{#T}](../device/device-list.md).

## Getting a list of certificates {#device-certificates-list}

{% include [device-certificates-list](../../../_includes/iot-core/device-certificates-list.md) %}

## Adding a certificate {#add-cert}

{% list tabs %}

- Management console

   To add a device certificate:

   1. In the [management console]({{ link-console-main }}), select the folder where you want to add a device certificate.

   1. Select **{{ iot-name }}**.

   1. Click on the name of the registry.

   1. In the left menu, select **Devices**.

   1. Select the desired device from the list.

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

  Add a certificate to the device:

  ```
  $ yc iot device certificate add \
  --device-name my-device \ # Device name.
  --certificate-file device-cert.pem # Path to the public part of the certificate.
  
  device_id: b9135goeh1uc1s2i07nm
  fingerprint: 65e5b050069da5ca5996a4a8a92514098b0a5dd1
  certificate_data: |
    -----BEGIN CERTIFICATE-----
    MIIE/jCCAuagAwI...
    -----END CERTIFICATE-----
  created_at: "2019-05-29T17:14:18.804Z"
  ```

{% endlist %}

## Deleting a certificate {#delete-cert}

{% list tabs %}

- Management console

   To delete a device certificate:
   1. In the [management console]({{ link-console-main }}), select the folder to delete the device certificate from.
   1. Select the **{{ iot-name }}**.
   1. Click on the name of the registry.
   1. In the left menu, select **Devices**.
   1. Select the desired device from the list.
   1. On the **Overview** page, go to the **Certificates** section.
   1. Click ![image](../../../_assets/horizontal-ellipsis.svg) in the line with the appropriate certificate and select **Delete** from the drop-down list.
   1. In the window that opens, click **Delete**.

- CLI

  {% include [cli-install](../../../_includes/cli-install.md) %}

  1. Delete a device certificate:

      ```
      $ yc iot device certificate delete --device-name my-device --fingerprint 65...
      ```

  2. Make sure the certificate was deleted:

      ```
      $ yc iot device certificate list --device-name my-device
      +-------------+------------+
      | FINGERPRINT | CREATED AT |
      +-------------+------------+
      +-------------+------------+
      ```

{% endlist %}