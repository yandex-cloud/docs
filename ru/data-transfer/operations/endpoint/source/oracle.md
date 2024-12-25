---
title: Передача данных из эндпоинта-источника Oracle
description: Следуя данной инструкции, вы сможете настроить передачу данных из эндпоинта-источника Oracle.
---

# Передача данных из эндпоинта-источника Oracle

С помощью сервиса {{ data-transfer-full-name }} вы можете переносить данные из базы Oracle и реализовывать различные сценарии переноса, обработки и трансформации данных. Для реализации трансфера:

1. [Ознакомьтесь с возможными сценариями передачи данных](#scenarios).
1. [Подготовьте базу данных Oracle](#prepare) к трансферу.
1. [Настройте эндпоинт-источник](#endpoint-settings) в {{ data-transfer-full-name }}.
1. [Настройте один из поддерживаемых приемников данных](#supported-targets).
1. [Cоздайте](../../transfer.md#create) и [запустите](../../transfer.md#activate) трансфер.
1. Выполняйте необходимые действия по работе с базой и [контролируйте трансфер](../../monitoring.md).
1. При возникновении проблем, [воспользуйтесь готовыми решениями](../../../../data-transfer/troubleshooting/index.md) по их устранению.

## Сценарии передачи данных из Oracle {#scenarios}

1. {% include [migration](../../../../_includes/data-transfer/scenario-captions/migration.md) %}

1. {% include [data-mart](../../../../_includes/data-transfer/scenario-captions/data-mart.md) %}

Подробное описание возможных сценариев передачи данных в {{ data-transfer-full-name }} см. в разделе [Практические руководства](../../../tutorials/index.md).

## Подготовка базы данных источника {#prepare}

{% include [prepare db](../../../../_includes/data-transfer/endpoints/sources/oracle-prepare.md) %}

## Настройка эндпоинта-источника Oracle {#endpoint-settings}

При [создании](../index.md#create) или [изменении](../index.md#update) эндпоинта задайте настройки подключения к кластеру Oracle.

Настройки приведены для пользовательской инсталляции, когда все поля заполняются вручную.

{% list tabs group=instructions %}

- Консоль управления {#console}

    {% include [On premise Oracle UI](../../../../_includes/data-transfer/necessary-settings/ui/on-premise-oracle.md) %}

{% endlist %}

## Настройка приемника данных {#supported-targets}

Настройте один из поддерживаемых приемников данных:

* [{{ PG }}](../target/postgresql.md);
* [{{ CH }}](../target/clickhouse.md);
* [{{ GP }}](../target/greenplum.md).

Полный список поддерживаемых источников и приемников в {{ data-transfer-full-name }} см. в разделе [Доступные трансферы](../../../transfer-matrix.md).

После настройки источника и приемника данных [создайте и запустите трансфер](../../transfer.md#create).
