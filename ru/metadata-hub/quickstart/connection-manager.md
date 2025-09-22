---
title: Как начать работать с {{ connection-manager-name }}
description: Управляйте подключениями к источникам данных {{ PG }}, {{ MY }}, {{ CH }}, {{ RD }} и {{ TR }} с {{ connection-manager-full-name }}.
---

# Начало работы с {{ connection-manager-name }}


Управляйте подключениями к источникам данных {{ PG }}, {{ MY }}, {{ CH }}, {{ RD }}, {{ VLK }}, {{ OS }}, {{ MG }}, {{ TR }} и {{ KF }} с {{ connection-manager-full-name }}.

## Интеграция с сервисами управляемых баз данных {#mdb-integration}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. Создайте кластер [{{ mpg-short-name }}](../../managed-postgresql/operations/cluster-create.md), [{{ mmy-short-name }}](../../managed-mysql/operations/cluster-create.md) и [{{ mch-short-name }}](../../managed-clickhouse/operations/cluster-create.md).
  1. Чтобы включить интеграцию сервиса с кластерами управляемых баз данных, в дополнительных настройках кластера выберите **{{ ui-key.yacloud.mdb.forms.additional-field-connman }}**. После сохранения настроек кластера, его подключения будут создаваться автоматически.
  1. Для проверки автоматически созданного подключения, перейдите в [{{ connection-manager-name }}]({{ link-console-main }}/link/metadata-hub/connection-manager) в консоли управления.

  В списке подключений вы можете просмотреть подключения, созданные для ваших кластеров, и [настроить доступ](../operations/connection-access.md) к ним. В списке [зависимостей](../operations/view-connection.md#dependencies) подключения вы сможете просмотреть, для каких кластеров управляемых баз данных используется это подключение. Вы также можете посмотреть список и статус [операций](../operations/operation-connection.md) для выбранного подключения.

{% endlist %}

## Управление подключениями к базам данных {#database-connections}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором нужно создать подключение.
  1. Выберите сервис **{{ metadata-hub-full-name }}**.
  1. Hа панели слева выберите ![image](../../_assets/console-icons/plug-connection.svg) **{{ ui-key.yacloud.iam.folder.dashboard.label_connection-manager }}**.
  1. Нажмите кнопку **{{ ui-key.yacloud.connection-manager.label_create-connection-action }}**.
  1. Укажите имя подключения и тип базы данных.
  1. Опционально добавьте описание подключения и [метку](../../resource-manager/concepts/labels.md).
  1. Укажите параметры подключения в зависимости от выбранной базы данных:
     * [подключение к управляемой базе данных в кластере](../operations/create-connection.md#mdb-connection);
     * [подключение к пользовательской инсталляции базы данных](../operations/create-connection.md#on-premise-connection).
  1. Укажите данные для аутентификации подключения.

     {% note tip %}

     Если вы создаете подключение к пользовательской инсталляции базы данных для использования с [{{ datalens-full-name }}](../../datalens/concepts/index.md), укажите внешний адрес хоста.

     {% endnote %}
  
  1. Нажмите кнопку **{{ ui-key.yacloud.common.create }}**.


{% endlist %}

После того как подключение будет создано, вы можете [просмотреть его настройки](../operations/update-connection.md#list-connections) в списке подключений и [изменить их](../operations/update-connection.md#update-connections), посмотреть список [операций](../operations/operation-connection.md) для выбранного подключения, а также [управлять доступом](../operations/connection-access.md) к этому подключению.


## Что дальше {#what-is-next}

* [Просмотрите информацию о подключении](../operations/view-connection.md).
* [Измените настройки подключения](../operations/update-connection.md).
* [Настройте права доступа к подключению](../operations/connection-access.md).
* [Удалите ненужное подключение](../operations/delete-connection.md).


{% include [clickhouse-disclaimer](../../_includes/clickhouse-disclaimer.md) %}
