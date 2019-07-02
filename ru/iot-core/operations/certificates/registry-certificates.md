# Управление сертификатами реестра

Вы можете:

- [Посмотреть список сертификатов реестра](registry-certificates.md#list-cert)
- [Добавить сертификат реестру](registry-certificates.md#add-cert)
- [Удалить сертификат реестра](registry-certificates.md#delete-cert)

Для обращения к [реестру](../../concepts/index.md#registry) используйте его идентификатор или имя. Как узнать идентификатор или имя реестра, читайте в разделе [#T](../registry/registry-list.md).

## Посмотреть список сертификатов {#list-cert}

{% list tabs %}

- CLI
  
  {% include [cli-install](../../../_includes/cli-install.md) %}
  
  Посмотрите список сертификатов реестра:
  
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

## Добавить сертификат {#add-cert}

{% list tabs %}

- CLI
  
  {% include [cli-install](../../../_includes/cli-install.md) %}
  
  Добавьте сертификат реестру:
  
  ```
  $ yc iot registry certificate add \
  --registry-name my-registry \ # Имя реестра.
  --certificate-file registry-cert.pem # Путь к публичной части сертификата.
  
  registry_id: b91ki3851hab9m0l68je
  fingerprint: 589ce1605...
  certificate_data: |
    -----BEGIN CERTIFICATE-----
    MIIE/jCCAuagAw...
    -----END CERTIFICATE-----
  created_at: "2019-05-29T16:40:48.230Z"
  ```
  
{% endlist %}

## Удалить сертификат {#delete-cert}

{% list tabs %}

- CLI
  
  {% include [cli-install](../../../_includes/cli-install.md) %}
  
  1. Удалите сертификат реестра:
  
      ```
      $ yc iot registry certificate delete --registry-name my-registry --fingerprint 0f...
      ```
  
  2. Проверьте, что сертификат действительно удален:
  
      ```
      $ yc iot registry certificate list --registry-name my-registry
      +-------------+------------+
      | FINGERPRINT | CREATED AT |
      +-------------+------------+
      +-------------+------------+
      ```
  
{% endlist %}

