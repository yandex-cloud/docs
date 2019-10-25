# Managing device certificates

You can:

- [View the list of device certificates](device-certificates.md#list-cert)
- [Add a certificate to the device](device-certificates.md#add-cert)
- [Delete a device certificate](device-certificates.md#delete-cert)

To access a [device](../../concepts/index.md#device), use its ID or name. For information about how to get the ID or name of a device, see [{#T}](../device/device-list.md).

## Viewing a list of certificates {#list-cert}

{% list tabs %}

- CLI

  {% include [cli-install](../../../_includes/cli-install.md) %}

  View the list of device certificates:

  ```
  $ yc iot device certificate list --device-name my-device
  +------------------------------------------+---------------------+
  |               FINGERPRINT                |     CREATED AT      |
  +------------------------------------------+---------------------+
  | df3cc4f337eba01a264803d15b119e2d33943315 | 2019-05-29 17:14:36 |
  | 65e5b050069da5ca5996a4a8a92514098b0a5dd1 | 2019-05-29 17:14:18 |
  +------------------------------------------+---------------------+
  ```

{% endlist %}

## Adding a certificate {#add-cert}

{% list tabs %}

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

- CLI

  {% include [cli-install](../../../_includes/cli-install.md) %}

  1. Delete a device certificate:

      ```
      $ yc iot device certificate delete --device-name my-device --fingerprint 65e...
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

