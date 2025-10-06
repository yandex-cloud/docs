---
title: История изменений в {{ mtr-full-name }}
description: В разделе представлена история изменений сервиса {{ mtr-name }}.
---

# История изменений в {{ mtr-full-name }}

## Сентябрь 2025 {#september-2025}

Добавлена возможность выбора версии {{ TR }} при [создании](operations/cluster-create.md) и [изменении](operations/cluster-update.md#change-version) кластера.

## Август 2025 {#august-2025}

Добавлена возможность [работать с каталогами в кластере {{ TR }}](operations/index.md#catalogs) с помощью методов [REST](api-ref/Catalog/index.md) и вызова [gRPC](api-ref/grpc/Catalog/index.md).
 
## Июль 2025 {#july-2025}

* 21 июля 2025 {{ mtr-name }} перешел на стадию [General Availability](../overview/concepts/launch-stages.md), и за его использование начала взиматься плата в соответствии с [правилами тарификации](pricing.md).
* Добавлена возможность [получать подробную информацию об операции для кластера](operations/cluster-list.md).
* Добавлена возможность [получать список каталогов {{ TR }} в кластере](operations/cluster-list.md).

## Июнь 2025 {#june-2025}

* Поддержано [отказоустойчивое выполнение запросов в кластере](concepts/retry-policy.md).
* Добавлена возможность совершать операции над кластером и каталогами {{ TR }} с помощью [CLI {{ yandex-cloud }}](../cli/cli-ref/managed-trino/cli-ref/index.md), [{{ TF }}](tf-ref.md).

## Май 2025 {#may-2025}

* [Доступен новый коннектор](concepts/index.md#connector): MS SQL Server.
* В консоли управления добавлен раздел [**{{ ui-key.yacloud.mdb.maintenance.title_maintenance }}**](operations/cluster-maintenance.md).

## Апрель 2025 {#april-2025}

* Сервис {{ mtr-full-name }} вышел в [Public Preview](../overview/concepts/launch-stages.md).
* [Доступен новый коннектор](concepts/index.md#connector): Oracle.
* Добавлена интеграция с {{ connection-manager-full-name }}.
* Добавлена возможность совершать операции над кластером {{ TR }} с помощью [API](api-ref/authentication.md).
