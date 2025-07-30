# Посмотреть операции с зонами

Все действия с зонами {{ dns-name }} сохраняются в виде списка операций. Каждой операции присваивается уникальный идентификатор.

## Получить список операций {#get-operations}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) откройте каталог, в котором находится зона DNS.
  1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_dns }}**.
  1. Выберите нужную зону.
  1. Перейдите на панель ![image](../../_assets/operations.svg) **{{ ui-key.yacloud.common.operations-key-value }}** для выбранной зоны.

      В открывшемся списке отображаются операции с выбранной зоной и записями в ней.

- CLI {#cli}

  {% include [include](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  Чтобы получить список операций для зоны DNS, воспользуйтесь командой:

  ```bash
  yc dns zone list-operations <имя_или_идентификатор_зоны>
  ```

  По умолчанию информация об операциях выводится в текстовом формате. Чтобы получить более подробную информацию, укажите формат `yaml` или `json` для выводимых данных с помощью параметра `--format`:

  ```bash
  yc dns zone list-operations dns3fh7phb04******** --format yaml
  ```

  Результат:

  ```text
  - id: dnsi5gv00kas********
    description: Update DNS RecordSets
    created_at: "2024-02-01T08:46:21.554860158Z"
    created_by: ajego134p5h1********
    modified_at: "2024-02-01T08:46:21.554933861Z"
    done: true
    metadata:
      '@type': type.googleapis.com/yandex.cloud.dns.v1.UpdateRecordSetsMetadata
  - id: dnssdag1giqk********
    description: Create DNS Zone
    created_at: "2024-02-01T08:45:40.481514713Z"
    created_by: ajego134p5h1********
    modified_at: "2024-02-01T08:45:40.481608241Z"
    done: true
    metadata:
      '@type': type.googleapis.com/yandex.cloud.dns.v1.CreateDnsZoneMetadata
      dns_zone_id: dns3fh7phb04********
  ```

- API {#api}

  Чтобы получить список операций с зоной, воспользуйтесь методом REST API [listOperations](../api-ref/DnsZone/listOperations.md) для ресурса [DnsZone](../api-ref/DnsZone/index.md), или вызовом gRPC API [DnsZoneService/ListOperations](../api-ref/grpc/DnsZone/listOperations.md).

{% endlist %}

## Получить подробную информацию об операции {#get-operations-info}

1. [Получите список операций](#get-operations) для зоны.
1. Скопируйте идентификатор нужной операции.
1. Получите подробную информацию об операции:

    {% list tabs group=instructions %}

    - CLI {#cli}

      {% include [cli-install](../../_includes/cli-install.md) %}

      {% include [default-catalogue](../../_includes/default-catalogue.md) %}

      Выполните команду:

      ```bash
      yc operation get <идентификатор_операции>
      ```

      Результат:

      ```text
      id: dnsi5gv00kas********
      description: Create DNS Zone
      created_at: "2024-02-01T08:45:40.481Z"
      created_by: ajego134p5h1********
      modified_at: "2024-02-01T08:45:40.481Z"
      done: true
      metadata:
        '@type': type.googleapis.com/yandex.cloud.dns.v1.CreateDnsZoneMetadata
        dns_zone_id: dns3fh7phb04********
      response:
        '@type': type.googleapis.com/yandex.cloud.dns.v1.DnsZone
        id: dnssdag1giqk********
        folder_id: b1gmit33ngp3********
        created_at: "2024-02-01T08:45:40.416Z"
        zone: zonedone.com.
        public_visibility: {}
      ```

    - API {#api}

      Воспользуйтесь методом REST API [get](../../api-design-guide/concepts/operation.md#monitoring), или вызовом gRPC API [OperationService/Get](../api-ref/grpc/Operation/get.md).

    {% endlist %}

#### См. также {#see-also}

* [{#T}](../../api-design-guide/concepts/about-async.md)