---
title: SQL-запросы в {{ mmg-full-name }}
description: '{{ mmg-name }} позволяет подключаться к базам данных в вашем кластере {{ SD }} и отправлять SQL-запросы из консоли управления {{ yandex-cloud }}. Для этого войдите в консоль управления, откройте страницу нужного кластера и перейдите на вкладку WebSQL.'
---

# SQL-запросы в {{ websql-full-name }}

Вы можете отправлять SQL-запросы к базам данных в кластере {{ mmg-name }} с помощью сервиса [{{ websql-full-name }}](../../websql).

{{ websql-name }} — это сервис {{ yandex-cloud }}, который позволяет подключаться к кластерам управляемых баз данных, работать с БД, таблицами и схемами и выполнять запросы. Сервис работает в браузере, не требует дополнительной авторизации и предлагает удобные подсказки для работы с SQL-командами.

Для подключения из {{ websql-name }} в настройках кластера должна быть включена опция **{{ ui-key.yacloud.mdb.forms.additional-field-websql-service }}**. Опцию можно включить при [создании кластера](cluster-create.md) или [изменении кластера](update.md#change-additional-settings).

В кластере {{ mmg-name }} для каждого пользователя БД автоматически создается [подключение {{ connection-manager-name }}](../../metadata-hub/concepts/connection-manager.md), которое можно использовать для подключения к БД из {{ websql-name }}. При необходимости вы также можете [создать новое подключение](../../websql/operations/create-connection.md#connect-cluster).

Чтобы подключиться к БД из {{ websql-name }}:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) перейдите в каталог с нужным кластером.
  1. [Перейдите](../../console/operations/select-service.md#select-service) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-mongodb }}**.
  1. Нажмите на имя нужного кластера и перейдите на вкладку **{{ ui-key.yacloud.mdb.cluster.switch_explore-websql }}**.
  1. Выберите нужное подключение.
  
      Откроется подключение в сервисе {{ websql-name }}. Чтобы перейти в редактор запросов, выберите нужную БД.
    
{% endlist %}

Подробнее о работе с {{ websql-name }} см. в [документации сервиса](../../websql/operations/index.md).
