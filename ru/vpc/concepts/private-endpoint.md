---
title: Сервисные подключения в {{ vpc-full-name }}
description: Из статьи вы узнаете, какие сервисные подключения (Private Endpoints) используются в {{ vpc-full-name }}.
keywords:
  - сервисное подключение
  - private endpoint
  - private link
---

# Сервисные подключения в {{ vpc-full-name }}


**Сервисное подключение** (VPC Private Endpoint) — это возможность подключать облачные ресурсы внутри {{ vpc-short-name }} к сервисам {{ yandex-cloud }} по внутренней сети без использования [публичных IP-адресов](address.md#public-addresses).

Сервисы {{ yandex-cloud }} остаются доступными как через публичные IP-адреса, так и через сервисные подключения. 

Сервисное подключение — это региональный сервис, распределенный по зонам доступности. В случае отказа сервиса в одной из зон нагрузка перераспределится в другие зоны доступности.

Пропускная способность для отдельного сервисного подключения не гарантируется и зависит от текущей нагрузки на сервис. Для стабильной работы рекомендуется контролировать нагрузку с помощью [мониторинга](../metrics.md) и учитывать [установленные лимиты](./limits.md#vpc-limits).

Логически сервисное подключение можно разделить на две части:

* **Точка доступа** к сервису (**Private Endpoint**, PE) — отвечает за представление (подключение) целевого сервиса в {{ vpc-short-name }}. Реализуется внутри сервиса {{ vpc-short-name }}. Эта общая часть для всех типов сервисных подключений.
* **Интеграция** на стороне целевого сервиса (**Provider**) — отвечает за взаимодействие с точкой доступа и реализуется на стороне целевого сервиса.

## Особенности использования сервисных подключений {#pe-notes1}

В одной [виртуальной сети](./network.md#network) можно создать сервисные подключения [разных типов](#pe-services), но не более одного сервисного подключения каждого типа (два и более сервисных подключений одного типа создать не получится).

Точка доступа является IP-адресом подключения в {{ vpc-short-name }} из диапазонов CIDR подсетей в сети, для которой создается сервисное подключение. После создания сервисного подключения все облачные ресурсы сети с этим подключением получат IP-связность с целевым сервисом.

В момент создания точки доступа для нее всегда создается **PE-запись** — DNS-запись A-типа со специальным FQDN сервисного подключения. Например, для сервиса [{{ objstorage-short-name }}](../../storage/) PE-запись будет иметь вид `storage.pe.yandexcloud.net`.

При необходимости можно создать дополнительную **Primary-запись** — DNS-запись A-типа для публичного FQDN сервиса. В ней также будет указан внутренний IP-адрес, выделенный для сервисного подключения. Создание Primary-записи определяется параметром `private-dns-records-enabled`. Например, для сервиса [{{ objstorage-short-name }}](../../storage/) Primary-запись будет иметь вид `storage.yandexcloud.net`.

DNS-записи A-типа создаются в [сервисной зоне internal](../../dns/concepts/dns-zone.md#service-zones).

При использовании сервиса [{{ interconnect-name }}](../../interconnect/) сервисное подключение будет доступно через [приватные соединения](../../interconnect/concepts/priv-con.md), так же, как и другие ресурсы {{ vpc-short-name }}. Если необходимо получить доступ к сервисному подключению через FQDN вне {{ yandex-cloud }}, то на корпоративном DNS-сервере необходимо настроить A-записи таким образом, чтобы FQDN нужного сервиса указывал на соответствующий IP-адрес сервисного подключения.

## Виды сервисных подключений {#pe-services}

В настоящее время можно создать сервисное подключение для следующих облачных сервисов:

| **Название сервиса** | **Тип сервиса** | **Способ создания** | **PE-запись** | **Primary-запись** |
| --- | --- | --- | --- | --- |
| [{{ objstorage-short-name }}](../../storage/) | yandex.cloud.storage | [Консоль управления, CLI, {{ TF }}](../operations/private-endpoint-create.md) | `storage.pe.yandexcloud.net` | `storage.yandexcloud.net` |
| [{{ cloud-registry-name }}](../../cloud-registry) | yandex.cloud.registry | [CLI, {{ TF }}](../operations/private-endpoint-create.md) | `registry.pe.yandexcloud.net` | `registry.yandexcloud.net` |
| [{{ ai-studio-name }}](../../ai-studio/concepts/) | yandex.cloud.ai-studio | [CLI, {{ TF }}](../operations/private-endpoint-create.md) | `ai.pe.api.cloud.yandex.net` | `ai.api.cloud.yandex.net` |
| [AI Studio MCP Gateway](https://aistudio.yandex.ru/docs/ai-studio/mcp-gateway/api-ref/) |yandex.cloud.mcp-gateway | [CLI, {{ TF }}](../operations/private-endpoint-create.md) | `*.mcpgw.serverless.pe.yandexcloud.net` | `*.mcpgw.serverless.yandexcloud.net` |
| [{{ mtr-name }}](../../managed-trino) | yandex.cloud.managed-trino | [CLI, {{ TF }}](../operations/private-endpoint-create.md) | `trino.pe.yandexcloud.net`, `*.trino.pe.yandexcloud.net` | - |
| [{{ serverless-containers-name }}](../../serverless-containers) | yandex.cloud.serverless-containers | [CLI, {{ TF }}](../operations/private-endpoint-create.md) | `*.containers.pe.yandexcloud.net` | `*.containers.yandexcloud.net` |
| [{{ sf-name }}](../../functions) | yandex.cloud.serverless-functions | [CLI, {{ TF }}](../operations/private-endpoint-create.md) | `functions.pe.yandexcloud.net` | `functions.yandexcloud.net` |
| Public API Gateway | yandex.cloud.api | [CLI, {{ TF }}](../operations/private-endpoint-create.md) | `-` | `*.api.cloud.yandex.net` |

## Особенности использования разных видов сервисных подключений {#pe-notes2}

### {{ objstorage-name }} {#pe-s3}

#### Политики доступа

Чтобы разрешить доступ к {{ objstorage-short-name }} только из {{ vpc-short-name }} через сервисное подключение, необходимо применить следующую политику доступа для бакета:

{% include [policy-scheme-json](../../_includes/vpc/policy-scheme-json.md) %}

### {{ cloud-registry-name }} {#pe-cr}

Перед тем как создать сервисное подключение для сервиса {{ cloud-registry-name }} нужно сначала создать сервисное подключение для сервиса {{ objstorage-name }}.

### Public API Gateway {#pe-pubapi}

В настоящее время для данного типа PE есть следующие ограничения:
1. Работа через PE-запись не поддерживается. При создании PE данного типа необходимо всегда создавать Primary-запись.
2. При работе через PE не поддерживается работа со следующими сервисами:
   * [Certificate Manager](../../certificate-manager/)
   * [Lockbox](../../lockbox/)
   * [Cloud Backup](../../backup/)
   * [Object Storage S3 API](../../storage/s3/)


## Примеры подключения к сервисам без использования VPC PE {#no-pe-examples}

* [{#T}](../tutorials/storage-vpc-access.md)
* [{#T}](../tutorials/vpc-cr-access.md)

