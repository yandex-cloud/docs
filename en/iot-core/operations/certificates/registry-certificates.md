# Managing registry certificates

For devices and registries to begin exchanging data and commands, you need to [log in](../../concepts/authorization.md). This section describes how to manage registry certificates for the relevant authorization method.

{% include [pass-priority-note](../../../_includes/iot-core/pass-priority-note.md) %}

- [Viewing a list of registry certificates](registry-certificates.md#list-cert)
- [Adding a certificate to a registry](registry-certificates.md#add-cert)
- [Deleting a registry certificate](registry-certificates.md#delete-cert)

To access a [registry](../../concepts/index.md#registry), use its unique ID or name. For information about how to find the unique ID or name, see [{#T}](../registry/registry-list.md).

## Viewing a list of certificates {#list-cert}

{% list tabs %}

- CLI

  {% include [cli-install](../../../_includes/cli-install.md) %}

  View the list of registry certificates:

  ```
  $ yc iot registry certificate list --registry-name my-registry
  +------------------------------------------+---------------------+
  |               FINGERPRINT                |     CREATED AT      |
  +------------------------------------------+---------------------+
  | 0f511ea32139178edf73afb953a9cc398f33adf1 | 2019-05-29 16:46:23 |
  | 589ce1605019eeff7bb0992f290be0cd708ecc6c | 2019-05-29 16:40:48 |
  +------------------------------------------+---------------------+
  ```

{% endlist %}

## Adding a certificate {#add-cert}

{% list tabs %}

- CLI

  {% include [cli-install](../../../_includes/cli-install.md) %}

  Add a certificate to the registry:

  ```
  $ yc iot registry certificate add \
  --registry-name my-registry \ # Registry name.
  --certificate-file registry-cert.pem # Path to the public part of the certificate.
  
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

- CLI

  {% include [cli-install](../../../_includes/cli-install.md) %}

  1. Delete a registry certificate:

      ```
      $ yc iot registry certificate delete --registry-name my-registry --fingerprint 0f...
      ```

  2. Make sure the certificate was deleted:

      ```
      $ yc iot registry certificate list --registry-name my-registry
      +-------------+------------+
      | FINGERPRINT | CREATED AT |
      +-------------+------------+
      +-------------+------------+
      ```

{% endlist %}

