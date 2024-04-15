---
title: "Пошаговые инструкции для {{ mgp-full-name }}"
description: "На странице представлен список пошаговых инструкций для {{ mgp-name }}."
---

# Пошаговые инструкции для {{ mgp-name }}

## Кластеры

* [Информация об имеющихся кластерах](cluster-list.md)
* [{#T}](calculate-specs.md)
* [Создание кластера](cluster-create.md)
* [Изменение настроек кластера](update.md)
* [Остановка и запуск кластера](cluster-stop.md)
* [Управление хостами кластера](./hosts/cluster-hosts.md)
* [{#T}](./hosts/cluster-expand.md)
* [{#T}](./hosts/host-migration.md)
* [Управление резервными копиями](cluster-backups.md)
* [Удаление кластера](cluster-delete.md)

Если вы хотите перенести хосты кластера {{ mgp-name }} в другую зону доступности, обратитесь к [инструкции по управлению резервными копиями](cluster-backups.md).

## Базы данных

* [{#T}](connect.md)

## Пользователи и сессии

* [{#T}](roles-and-users.md)
* [{#T}](resource-groups.md)
* [{#T}](user-auth-rules.md)
* [{#T}](command-center.md)
* [{#T}](cluster-process.md)

## Внешние таблицы PXF

* [{#T}](external-tables.md)
* [{#T}](pxf/create-s3-source.md)
* [{#T}](pxf/create-jdbc-source.md)
* [{#T}](pxf/create-hdfs-source.md)
* [{#T}](pxf/create-hive-source.md)
* [{#T}](pxf/create-table.md)

## Работа с утилитой `gpfdist`

* [{#T}](gpfdist/connect.md)

## Расширения {{ GP }}

* [Управление расширениями](./extensions/cluster-extensions.md)
* [Использование pgcrypto](./extensions/pgcrypto.md)
* [Использование uuid-cb](./extensions/uuid-cb.md)

## Логи и мониторинг

* [Просмотр логов кластера](cluster-logs.md)
* [{#T}](performance-diagnostics.md)
* [Мониторинг состояния кластера и хостов](monitoring.md)

## Вспомогательные утилиты

* [{#T}](greenplum-db.md)

{% include [greenplum-trademark](../../_includes/mdb/mgp/trademark.md) %}
