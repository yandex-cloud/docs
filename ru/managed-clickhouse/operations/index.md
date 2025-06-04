---
title: Пошаговые инструкции для {{ mch-full-name }}
description: На странице представлен список пошаговых инструкций для {{ mch-name }}.
---

# Пошаговые инструкции для {{ mch-name }}

## Кластеры {#clusters}

* [Информация об имеющихся кластерах](cluster-list.md)
* [Создание кластера](cluster-create.md)
* [Изменение настроек кластера](update.md)
* [{#T}](change-server-level-settings.md)
* [{#T}](change-query-level-settings.md)
* [{#T}](cluster-version-update.md)
* [Остановка и запуск кластера](cluster-stop.md)
* [Управление хостами {{ CH }}](hosts.md)
* [Управление хостами {{ ZK }}](zk-hosts.md)
* [Миграция хостов кластера в другую зону доступности](host-migration.md)
* [Управление резервными копиями](cluster-backups.md)
* [Удаление кластера](cluster-delete.md)

## Подключение к кластеру {#connect}

* [Предварительная настройка](connect/index.md)
* [FQDN хостов {{ CH }}](connect/fqdn.md)
* [Подключение к кластеру из приложений](connect/clients.md)
* [Примеры кода для подключения к кластеру](connect/code-examples.md)

## Базы данных {#databases}

* [{#T}](web-sql-query.md)
* [Управление базами данных](databases.md)
* [Управление пользователями](cluster-users.md)

## Хранение и обработка данных {#data-storage-and-processing}

* [Управление собственной геобазой](geobase.md)
* [Подключение внешних словарей](dictionaries.md)
* [Управление схемами формата данных](format-schemas.md)
* [Управление моделями машинного обучения](ml-models.md)


* [Настройка доступа к {{ objstorage-name }}](s3-access.md)


## Шардирование {#sharding}

* [Управление шардами](shards.md)
* [Управление группами шардов](shard-groups.md)

## Логи и мониторинг {#monitoring-and-logs}

* [Просмотр логов кластера](cluster-logs.md)
* [Мониторинг состояния кластера и хостов](monitoring.md)
* [Подключение к кластеру из {{ datalens-name }}](datalens-connect.md)


{% include [clickhouse-disclaimer](../../_includes/clickhouse-disclaimer.md) %}
