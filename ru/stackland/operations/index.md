# Пошаговые инструкции

## {{ iam-name }} {#iam}

* [Создать пользователя](iam/create-user.md)
* [Создать группу пользователей](iam/create-group.md)
* [Подключить SAML-федерацию](iam/connect-saml-federation.md)
* [Назначить права доступа](iam/assign-role.md)

## Базы данных {#databases}

{{ mpg-name }}:

* [Создать кластер PostgreSQL](postgresql/create-cluster.md)
* [Изменить настройки кластера](postgresql/edit-cluster.md)
* [Создать пользователя](postgresql/create-user.md)
* [Изменить пользователя](postgresql/edit-user.md)
* [Удалить пользователя](postgresql/delete-user.md)
* [Создать базу данных](postgresql/create-database.md)
* [Изменить базу данных](postgresql/edit-database.md)
* [Удалить базу данных](postgresql/delete-database.md)
* [Создать резервную копию](postgresql/new-copy.md)
* [Восстановить кластер](postgresql/recover-copy.md)
* [Удалить кластер](postgresql/delete-cluster.md)

{{ mch-name }}:

* [Создать кластер {{ CH }}](clickhouse/create-cluster.md)
* [Изменить настройки кластера](clickhouse/edit-cluster.md)
* [Создать резервную копию](clickhouse/new-copy.md)
* [Восстановить кластер](clickhouse/recover-copy.md)
* [Удалить кластер](clickhouse/delete-cluster.md)
* [Создать базу данных](clickhouse/create-database.md)
* [Изменить базу данных](clickhouse/edit-database.md)
* [Удалить базу данных](clickhouse/delete-database.md)
* [Создать роль](clickhouse/create-role.md)
* [Изменить роль](clickhouse/edit-role.md)
* [Удалить роль](clickhouse/delete-role.md)
* [Создать пользователя](clickhouse/create-user.md)
* [Изменить пользователя](clickhouse/edit-user.md)
* [Удалить пользователя](clickhouse/delete-user.md)

{{ yt-name }}:

* [Включить {{ yt-name }}](ytsaurus/enable.md)
* [Изменить настройки кластера](ytsaurus/edit-cluster.md)
* [Получить пароль и токен администратора](ytsaurus/get-admin-credentials.md)
* [Открыть веб-интерфейс](ytsaurus/connect-ui.md)
* [Подключиться к HTTP-прокси](ytsaurus/connect-api.md)
* [Отключить {{ yt-name }}](ytsaurus/disable.md)

## {{ rest-catalog-name }} {#rest-catalog}

* [Создать каталог](rest-catalog/create-catalog.md)
* [Изменить каталог](rest-catalog/edit-catalog.md)
* [Создать пользователя каталога](rest-catalog/create-principal.md)
* [Удалить пользователя каталога](rest-catalog/delete-principal.md)
* [Удалить каталог](rest-catalog/delete-catalog.md)

## Бакеты {#buckets}

* [Создать бакет](storage/create-bucket.md)
* [Создать AccessKey](storage/create-accesskey.md)
* [Удалить бакет](storage/delete-bucket.md)
* [Удалить AccessKey](storage/delete-accesskey.md)

## Брокер сообщений {#broker}

* [Создать кластер {{ KF }}](kafka/create-cluster.md)
* [Создать топик](kafka/create-topic.md)
* [Создать пользователя](kafka/create-user.md)
* [Подключиться к кластеру](kafka/connect-to-kafka.md)
* [Удалить кластер](kafka/delete-cluster.md)
* [Удалить топик](kafka/delete-topic.md)
* [Удалить пользователя](kafka/delete-user.md)

## Логирование {#logging}

* [Посмотреть логи](logging/logs-view.md)
* [Восстановить Loki в standalone-режиме при заполнении PVC](logging/loki-recovery.md)

## Мониторинг {#monitoring}

* [Создать дашборд](monitoring/dashboard-create.md)
* [Изменить дашборд](monitoring/dashboard-update.md)
* [Удалить дашборд](monitoring/dashboard-delete.md)
* [Управлять доступом к дашбордам](monitoring/dashboard-access.md)
* [Создать канал уведомлений](monitoring/alerts-create-contact-point.md)
* [Создать правило алертинга](monitoring/alerts-create-rule.md)

## {{ datalens-name }} {#datalens}

* [Установить образы](datalens/install-images.md)
* [Включить {{ datalens-name }}](datalens/configure.md)
* [Отключить {{ datalens-name }}](datalens/disable.md)

## Политики {#policies}

* [Активировать пресет с политиками](policy-manager/apply-preset.md)
* [Деактивировать политику](policy-manager/apply-mute.md)
* [Удалить пресет с политиками](policy-manager/delete-preset.md)

## {{ speechsense-name }} {#speechsense}

* [Загрузить образы](speechsense/install-images.md)
* [Настроить и активировать](speechsense/configure.md)
* [Отключить](speechsense/disable.md)

## Проекты {#projects}

* [Создать проект](projects/create-project.md)
* [Управлять пространствами имен](projects/manage-namespaces.md)
* [Настроить роли проекта](projects/project-roles.md)
* [Установить квоты проекта](projects/namespace-quotas.md)

## Дисковая подсистема {#disk-storage}

* [Диагностика дисковой подсистемы](disk-storage/troubleshooting.md)
* [Переключить класс хранилища компонента](disk-storage/change-storage-class.md)

## Управление кластером {#cluster-management}

* [Обновить кластер](cluster/upgrade-cluster.md)
* [Масштабирование кластера](cluster/scale-cluster.md)
