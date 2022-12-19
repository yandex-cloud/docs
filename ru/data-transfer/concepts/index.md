---
title: "Взаимосвязь ресурсов сервиса {{ data-transfer-full-name }}"
description: "{{ data-transfer-full-name }} позволяет легко переносить данные между базами данных. Сервис позволяет сократить время на процесс миграции, минимизировать простой при переключении на новую базу данных или иметь постоянную реплику базы."
---

# Взаимосвязь ресурсов в {{ data-transfer-name }}

{{ data-transfer-full-name }} помогает переносить данные между СУБД, объектными хранилищами или брокерами сообщений. Сервис позволяет сократить время на процесс миграции и минимизировать простой при переключении на новую базу данных.

{{ data-transfer-full-name }} настраивается через стандартные интерфейсы {{ yandex-cloud }}.

Сервис подходит для создания постоянной реплики базы. Перенос схемы базы данных из источника на приемник автоматизирован.

## Эндпоинт {#endpoint}

_Эндпоинт_ — это конфигурация для подключения к сервису-_источнику_ или _приемнику_ данных. Кроме настроек подключения, эндпоинт может содержать информацию о том, какие данные будут участвовать в трансфере и как они должны быть обработаны в процессе переноса.

В качестве источника или приемника данных могут выступать:

{% if product == "yandex-cloud" %}

| Сервис                                                                                                     | Источник                             | Приемник                             |
|------------------------------------------------------------------------------------------------------------|:------------------------------------:|:------------------------------------:|
| Топик {{ KF }} — собственный или в составе [сервиса {{ mkf-short-name }}](../../managed-kafka/)            | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg)   |
| Поток сообщений AWS CloudTrail                                                                             | ![yes](../../_assets/common/yes.svg) | ![no](../../_assets/common/no.svg)   |
| Собственная база данных BigQuery                                                                           | ![yes](../../_assets/common/yes.svg) | ![no](../../_assets/common/no.svg)   |
| База данных {{ CH }} — собственная или в составе [сервиса {{ mch-short-name }}](../../managed-clickhouse/) | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) |
| База данных {{ GP }} — собственная или в составе [сервиса {{ mgp-short-name }}](../../managed-greenplum/)  | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) |
| База данных {{ MG }} — собственная или в составе [сервиса {{ mmg-short-name }}](../../managed-mongodb/)    | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) |
| База данных {{ MY }} — собственная или в составе [сервиса {{ mmy-short-name }}](../../managed-mysql/)      | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) |
| Собственная база данных Oracle                                                                             | ![yes](../../_assets/common/yes.svg) | ![no](../../_assets/common/no.svg)   |
| База данных {{ PG }} — собственная или в составе [сервиса {{ mpg-short-name }}](../../managed-postgresql/) | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) |
| S3-совместимый бакет                                                                                       | ![yes](../../_assets/common/yes.svg) | ![no](../../_assets/common/no.svg)   |
| Поток данных [{{ yds-full-name }}](../../data-streams/)                                                    | ![yes](../../_assets/common/yes.svg) | ![no](../../_assets/common/no.svg)   |
| База данных {{ ydb-name }} — в составе [сервиса {{ ydb-name }}](../../ydb/)                                | ![no](../../_assets/common/no.svg)   | ![yes](../../_assets/common/yes.svg) |
| Бакет [{{ objstorage-full-name }}](../../storage/)                                                         | ![no](../../_assets/common/no.svg)   | ![yes](../../_assets/common/yes.svg) |

{% endif %}

{% if product == "cloud-il" %}

| Сервис                                                                                                     | Источник                             | Приемник                             |
|------------------------------------------------------------------------------------------------------------|:------------------------------------:|:------------------------------------:|
| Топик {{ KF }} — собственный или в составе [сервиса {{ mkf-short-name }}](../../managed-kafka/)            | ![yes](../../_assets/common/yes.svg) | ![no](../../_assets/common/no.svg)   |
| Поток сообщений AWS CloudTrail                                                                             | ![yes](../../_assets/common/yes.svg) | ![no](../../_assets/common/no.svg)   |
| Собственная база данных BigQuery                                                                           | ![yes](../../_assets/common/yes.svg) | ![no](../../_assets/common/no.svg)   |
| База данных {{ CH }} — собственная или в составе [сервиса {{ mch-short-name }}](../../managed-clickhouse/) | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) |
| Собственная база данных {{ GP }}                                                                           | ![yes](../../_assets/common/yes.svg) | ![no](../../_assets/common/no.svg)   |
| Собственная база данных {{ MG }}                                                                           | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) |
| База данных {{ MY }} — собственная или в составе [сервиса {{ mmy-short-name }}](../../managed-mysql/)      | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) |
| Собственная база данных Oracle                                                                             | ![yes](../../_assets/common/yes.svg) | ![no](../../_assets/common/no.svg)   |
| База данных {{ PG }} — собственная или в составе [сервиса {{ mpg-short-name }}](../../managed-postgresql/) | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) |
| Бакет [{{ objstorage-full-name }}](../../storage/)                                                         | ![no](../../_assets/common/no.svg)   | ![yes](../../_assets/common/yes.svg) |

{% endif %}

## Трансфер {#transfer}

_Трансфер_ — это процесс переноса данных между сервисом-источником и сервисом-приемником. Он должен находиться в одном каталоге с используемыми эндпоинтами.

Если для эндпоинтов заданы подсети, то они должны быть размещены в одной {% if audience != "internal" %}[зоне доступности](../../overview/concepts/geo-scope.md){% else %}зоне доступности{% endif %}. Иначе активация трансфера с такими эндпоинтами завершится с ошибкой.

### Типы трансферов {#transfer-type}

Трансферы бывают следующих типов:

* _{{ dt-type-copy }}_ — переносит снапшот источника на приемник.
* _{{ dt-type-repl }}_ — непрерывно получает изменения из источника и применяет их на приемнике. При этом первоначальная синхронизация данных не выполняется.
* _{{ dt-type-copy-repl }}_ — переносит текущее состояние источника на приемник и поддерживает его актуальность.

Подробнее о различиях между типами трансферов читайте в разделе [{#T}](./transfer-lifecycle.md).

### Совместимость источников и приемников {#connectivity-matrix}

{% include [include](../../_includes/data-transfer/connectivity-marix.md) %}