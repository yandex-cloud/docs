---
title: Пошаговые инструкции для {{ mgp-full-name }}
description: На странице представлен список пошаговых инструкций для {{ mgp-name }}.
---

# Пошаговые инструкции для {{ mgp-name }}

## Кластеры {#clusters}

* [Информация об имеющихся кластерах](cluster-list.md)
* [Создание кластера](cluster-create.md)
* [Изменение конфигурации кластера](cluster-config.md)
* [Изменение настроек кластера](update.md)
* [Остановка и запуск кластера](cluster-stop.md)
* [{#T}](cluster-expand.md)
* [Управление резервными копиями](cluster-backups.md)
* [Управление доступом к кластеру](cluster-access.md)
* [Удаление кластера](cluster-delete.md)

## Подключение {#connect}

* [Предварительная настройка для подключения к кластеру](./connect/index.md)
* [FQDN хостов](./connect/fqdn.md)
* [Подключение к кластеру из приложений](./connect/clients.md)
* [Примеры кода для подключения к кластеру](./connect/code-examples.md)

## Базы данных {#databases}

* [{#T}](databases.md)
* [{#T}](web-sql-query.md)

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
* [Использование gp_relsizes_stats](./extensions/gp-relsizes-stats.md)
* [Использование gp_url_tools](./extensions/gp-url-tools.md)
* [Использование pgcrypto](./extensions/pgcrypto.md)
* [Использование uuid-cb](./extensions/uuid-cb.md)

## Логи и мониторинг {#logs-and-monitoring}

* [Просмотр логов кластера](cluster-logs.md)
* [Просмотр операций кластера](cluster-operations.md)
* [{#T}](performance-diagnostics.md)
* [Мониторинг состояния кластера и хостов](monitoring.md)
* [Передача логов кластера в {{ cloud-logging-full-name }}](mgp-to-cloud-logging.md)

## Вспомогательные утилиты {#tools}

* [{#T}](greenplum-db.md)

{% include [greenplum-trademark](../../_includes/mdb/mgp/trademark.md) %}
