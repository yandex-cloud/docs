# Сервисные подключения в Yandex Virtual Private Cloud


**Сервисное подключение** (VPC Private Endpoint) — это возможность подключать облачные ресурсы внутри VPC к сервисам Yandex Cloud по внутренней сети без использования [публичных IP-адресов](address.md#public-addresses).

Сервисы Yandex Cloud остаются доступными как через публичные IP-адреса, так и через сервисные подключения. 

Сервисное подключение — это региональный сервис, распределенный по зонам доступности. В случае отказа сервиса в одной из зон нагрузка перераспределится в другие зоны доступности.

Пропускная способность для отдельного сервисного подключения не гарантируется и зависит от текущей нагрузки на сервис. Для стабильной работы рекомендуется контролировать нагрузку с помощью [мониторинга](../metrics.md) и учитывать [установленные лимиты](limits.md#vpc-limits).

Логически сервисное подключение можно разделить на две части:

* **Точка доступа** к сервису (**Private Endpoint**, PE) — отвечает за представление (подключение) целевого сервиса в VPC. Реализуется внутри сервиса VPC. Эта общая часть для всех типов сервисных подключений.
* **Интеграция** на стороне целевого сервиса (**Provider**) — отвечает за взаимодействие с точкой доступа и реализуется на стороне целевого сервиса.

## Особенности использования сервисных подключений {#pe-notes1}

В одной [виртуальной сети](network.md#network) можно создать сервисные подключения [разных типов](#pe-services), но не более одного сервисного подключения каждого типа (два и более сервисных подключений одного типа создать не получится).

Точка доступа является IP-адресом подключения в VPC из диапазонов CIDR подсетей в сети, для которой создается сервисное подключение. После создания сервисного подключения все облачные ресурсы сети с этим подключением получат IP-связность с целевым сервисом.

В момент создания точки доступа для нее всегда создается **PE-запись** — DNS-запись A-типа со специальным FQDN сервисного подключения. Например, для сервиса [Object Storage](../../storage/index.md) PE-запись будет иметь вид `storage.pe.yandexcloud.net`.

При необходимости можно создать дополнительную **Primary-запись** — DNS-запись A-типа для публичного FQDN сервиса. В ней также будет указан внутренний IP-адрес, выделенный для сервисного подключения. Создание Primary-записи определяется параметром `private-dns-records-enabled`. Например, для сервиса [Object Storage](../../storage/index.md) Primary-запись будет иметь вид `storage.yandexcloud.net`.

DNS-записи A-типа создаются в [сервисной зоне internal](../../dns/concepts/dns-zone.md#service-zones).

При использовании сервиса [Cloud Interconnect](../../interconnect/index.md) сервисное подключение будет доступно через [приватные соединения](../../interconnect/concepts/priv-con.md), так же, как и другие ресурсы VPC. Если необходимо получить доступ к сервисному подключению через FQDN вне Yandex Cloud, то на корпоративном DNS-сервере необходимо настроить A-записи таким образом, чтобы FQDN нужного сервиса указывал на соответствующий IP-адрес сервисного подключения.

## Виды сервисных подключений {#pe-services}

В настоящее время можно создать сервисное подключение для следующих облачных сервисов:

| **Название сервиса** | **Тип сервиса** | **Способ создания** | **PE-запись** | **Primary-запись** |
| --- | --- | --- | --- | --- |
| [Object Storage](../../storage/index.md) | yandex.cloud.storage | [Консоль управления, CLI, Terraform](../operations/private-endpoint-create.md) | `storage.pe.yandexcloud.net` | `storage.yandexcloud.net` |
| [Cloud Registry](../../cloud-registry/index.md) | yandex.cloud.registry | [CLI, Terraform](../operations/private-endpoint-create.md) | `registry.pe.yandexcloud.net` | `registry.yandexcloud.net` |
| [AI Studio](../../ai-studio/concepts/) | yandex.cloud.ai-studio | [CLI, Terraform](../operations/private-endpoint-create.md) | `ai.pe.api.cloud.yandex.net` | `ai.api.cloud.yandex.net` |
| [AI Studio MCP Gateway](https://aistudio.yandex.ru/docs/ai-studio/mcp-gateway/api-ref/) |yandex.cloud.mcp-gateway | [CLI, Terraform](../operations/private-endpoint-create.md) | `*.mcpgw.serverless.pe.yandexcloud.net` | `*.mcpgw.serverless.yandexcloud.net` |
| [Managed Service for Trino](../../managed-trino/index.md) | yandex.cloud.managed-trino | [CLI, Terraform](../operations/private-endpoint-create.md) | `trino.pe.yandexcloud.net`, `*.trino.pe.yandexcloud.net` | - |
| [Serverless Containers](../../serverless-containers/index.md) | yandex.cloud.serverless-containers | [CLI, Terraform](../operations/private-endpoint-create.md) | `*.containers.pe.yandexcloud.net` | `*.containers.yandexcloud.net` |
| [Cloud Functions](../../functions/index.md) | yandex.cloud.serverless-functions | [CLI, Terraform](../operations/private-endpoint-create.md) | `functions.pe.yandexcloud.net` | `functions.yandexcloud.net` |
| Public API Gateway | yandex.cloud.api | [CLI, Terraform](../operations/private-endpoint-create.md) | `-` | `*.api.cloud.yandex.net` |

## Особенности использования разных видов сервисных подключений {#pe-notes2}

### Object Storage {#pe-s3}

#### Политики доступа

Чтобы разрешить доступ к Object Storage только из VPC через сервисное подключение, необходимо применить следующую политику доступа для бакета:

```json
{
  "Version": "2012-10-17",
  "Statement": {
    "Effect": "Allow",
    "Principal": "*",
    "Action": "*",
    "Resource": [
      "arn:aws:s3:::<имя_бакета>/*",
      "arn:aws:s3:::<имя_бакета>"
    ],
    "Condition": {
      "StringEquals": {
        "yc:private-endpoint-id": "<идентификатор_подключения>"
      }
    }
  }
}
```

Где:

* `<имя_бакета>` — имя бакета в Object Storage, к которому нужно применить политику доступа, например `my-s3-bucket`.
* `<идентификатор_подключения>` — идентификатор сервисного подключения (Private Endpoint), например `enpd7rq1s3f5********`.

### Cloud Registry {#pe-cr}

Перед тем как создать сервисное подключение для сервиса Cloud Registry нужно сначала создать сервисное подключение для сервиса Object Storage.

### Public API Gateway {#pe-pubapi}

В настоящее время для данного типа PE есть следующие ограничения:
1. Работа через PE-запись не поддерживается. При создании PE данного типа необходимо всегда создавать Primary-запись.
2. При работе через PE не поддерживается работа со следующими сервисами:
   * [Certificate Manager](../../certificate-manager/index.md)
   * [Lockbox](../../lockbox/index.md)
   * [Cloud Backup](../../backup/index.md)
   * [Object Storage S3 API](../../storage/s3/index.md)


## Примеры подключения к сервисам без использования VPC PE {#no-pe-examples}

* [Подключение к Object Storage из Virtual Private Cloud](../tutorials/storage-vpc-access.md)
* [Подключение к Container Registry из Virtual Private Cloud](../tutorials/vpc-cr-access.md)