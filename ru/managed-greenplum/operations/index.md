---
title: Пошаговые инструкции для {{ mgp-full-name }}
description: На странице представлен список пошаговых инструкций для {{ mgp-name }}.
---

# Пошаговые инструкции для {{ mgp-name }}

## Кластеры {#clusters}

* [Информация об имеющихся кластерах](cluster-list.md)
* [Создание кластера](cluster-create.md)
* [Изменение настроек кластера](update.md)
* [Остановка и запуск кластера](cluster-stop.md)
* [Информация о хостах кластера](./hosts/cluster-hosts.md)
* [{#T}](./hosts/cluster-expand.md)
* [Миграция хостов кластера в другую зону доступности](./hosts/host-migration.md)
* [Управление резервными копиями](cluster-backups.md)
* [Удаление кластера](cluster-delete.md)

## Базы данных {#databases}

* [{#T}](connect.md)

## Пользователи и сессии {#users-and-sessions}

* [{#T}](roles-and-users.md)
* [{#T}](resource-groups.md)
* [{#T}](user-auth-rules.md)
* [{#T}](command-center.md)
* [{#T}](cluster-process.md)

## Внешние таблицы PXF {#pxf}

* [{#T}](external-tables.md)
* [{#T}](pxf/create-s3-source.md)
* [{#T}](pxf/create-jdbc-source.md)
* [{#T}](pxf/create-hdfs-source.md)
* [{#T}](pxf/create-hive-source.md)
* [{#T}](pxf/create-table.md)
* [{#T}](pxf/settings.md)

## Работа с утилитой `gpfdist` {#gpfdist}

* [{#T}](gpfdist/connect.md)

## Расширения {{ GP }} {#extensions}

* [Управление расширениями](./extensions/cluster-extensions.md)
* [Использование pgcrypto](./extensions/pgcrypto.md)
* [Использование uuid-cb](./extensions/uuid-cb.md)

## Логи и мониторинг {#logs-and-monitoring}

* [Просмотр логов кластера](cluster-logs.md)
* [{#T}](performance-diagnostics.md)
* [Мониторинг состояния кластера и хостов](monitoring.md)

## Вспомогательные утилиты {#tools}

* [{#T}](greenplum-db.md)

{% include [greenplum-trademark](../../_includes/mdb/mgp/trademark.md) %}
