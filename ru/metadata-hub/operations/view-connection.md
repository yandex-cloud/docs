---
title: Как получить информацию о подключении {{ metadata-hub-name }}. Пошаговые инструкции
description: Пошаговые инструкции по работе с {{ connection-manager-name }} в {{ yandex-cloud }}. Из статьи вы узнаете, как просматривать подключения.
---

# Просмотр информации о подключении

{% include notitle [preview](../../_includes/note-preview.md) %}

Чтобы посмотреть созданные подключения:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder).
  1. Выберите сервис **{{ metadata-hub-full-name }}**.
  1. Hа панели слева выберите ![image](../../_assets/console-icons/plug-connection.svg) **{{ ui-key.yacloud.iam.folder.dashboard.label_connection-manager }}**.
  1. Нажмите на строку подключения для просмотра детальной информации о нем.

{% endlist %}

Для выбранного подключения вы можете просмотреть информацию о зависимостях от других сервисов и выполненных операциях.

Вы можете открыть выбранное подключение в сервисе [{{ websql-full-name }}](../../websql/concepts/index.md) для выполнения запросов к базам данных. Перейдите по ссылке **{{ ui-key.yacloud.connection-manager.label_open-websql }}**, расположенной в правом верхнем углу.

{% note info %}

В списке подключений показываются только те подключения, к которым у пользователя есть доступ (выдана [роль `connection-manager.auditor`](../security/connection-manager-roles.md#connection-manager-auditor) или [роль `connection-manager.viewer`](../security/connection-manager-roles.md#connection-manager-viewer)). Пользователь с доступом к каталогу будет видеть все подключения в этом каталоге.

{% endnote %}

## Просмотр зависимостей подключения {#dependencies}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder).
  1. Выберите сервис **{{ metadata-hub-full-name }}**.
  1. На панели слева выберите ![image](../../_assets/console-icons/plug-connection.svg) **{{ ui-key.yacloud.iam.folder.dashboard.label_connection-manager }}** и нажмите на имя нужного подключения.
  1. На панели слева выберите ![image](../../_assets/console-icons/nodes-right.svg) **{{ ui-key.yacloud.connection-manager.label_dependences }}**.

     В списке зависимостей показываются кластеры управляемых баз данных и экземпляры сервисов, которые используют {{ connection-manager-name }} для хранения информации о подключениях. Нажмите на строку в списке зависимостей, чтобы перейти к кластеру или экземпляру сервиса.

{% endlist %}

## Просмотр выполненных операций {#operations}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder).
  1. Выберите сервис **{{ metadata-hub-full-name }}**.
  1. На панели слева выберите ![image](../../_assets/console-icons/plug-connection.svg) **{{ ui-key.yacloud.iam.folder.dashboard.label_connection-manager }}** и нажмите на имя нужного подключения.
  1. На панели слева выберите ![image](../../_assets/console-icons/list-check.svg) **{{ ui-key.yacloud.common.operations-key-value }}**.

     В списке операций вы можете просмотреть все операции выбранного подключения с момента его создания:

     * `Create` — подключение создано;
     * `Update` — подключение изменено;
     * `Delete` — подключение удалено;
     * `Set access bindings` — назначены роли пользователям данного подключения;
     * `Update access bindings` — изменены роли пользователей данного подключения.

     Вы также можете просмотреть технические операции:

     * `Bump version` — обновлена версия секрета для подключений MDB;
     * `Update references` — обновлены ссылки на подключение;
     * `Update version references` — обновлены ссылки на версию подключения при создании или удалении бекапа кластера MDB;
     * `Delete version` — удалена версия подключения после удаления последнего бэкапа кластера MDB.

{% endlist %}