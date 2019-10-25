# Управление сертификатами устройств

Вы можете:

- [Посмотреть список сертификатов устройства](device-certificates.md#list-cert)
- [Добавить сертификат устройству](device-certificates.md#add-cert)
- [Удалить сертификат устройства](device-certificates.md#delete-cert)

Для обращения к [устройству](../../concepts/index.md#device) используйте его уникальный идентификатор или имя. Как узнать уникальный идентификатор или имя устройства, читайте в разделе [{#T}](../device/device-list.md).

## Посмотреть список сертификатов {#list-cert}

{% list tabs %}

- CLI

  {% include [cli-install](../../../_includes/cli-install.md) %}

  Посмотрите список сертификатов устройства:

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

## Добавить сертификат {#add-cert}

{% list tabs %}

- CLI

  {% include [cli-install](../../../_includes/cli-install.md) %}

  Добавьте сертификат устройству:

  ```
  $ yc iot device certificate add \
  --device-name my-device \ # Имя устройства.
  --certificate-file device-cert.pem # Путь к публичной части сертификата.

  device_id: b9135goeh1uc1s2i07nm
  fingerprint: 65e5b050069da5ca5996a4a8a92514098b0a5dd1
  certificate_data: |
    -----BEGIN CERTIFICATE-----
    MIIE/jCCAuagAwI...
    -----END CERTIFICATE-----
  created_at: "2019-05-29T17:14:18.804Z"
  ```

{% endlist %}

## Удалить сертификат {#delete-cert}

{% list tabs %}

- CLI

  {% include [cli-install](../../../_includes/cli-install.md) %}

  1. Удалите сертификат устройства:

      ```
      $ yc iot device certificate delete --device-name my-device --fingerprint 65...
      ```

  2. Проверьте, что сертификат действительно удален:

      ```
      $ yc iot device certificate list --device-name my-device
      +-------------+------------+
      | FINGERPRINT | CREATED AT |
      +-------------+------------+
      +-------------+------------+
      ```

{% endlist %}
