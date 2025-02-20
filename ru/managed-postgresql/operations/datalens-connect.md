---
title: Инструкция по подключению к кластеру {{ PG }} из {{ datalens-name }}
description: Из статьи вы узнаете, как подключиться к кластеру {{ PG }} из {{ datalens-name }}.
---

# Подключение к кластеру {{ PG }} из {{ datalens-name }}

{% include [mdb-datalens-connector-intro](../../_includes/mdb/datalens-connector-intro.md) %}

Чтобы использовать существующий кластер в качестве источника данных для {{ datalens-full-name }}:
1. [Активируйте {{ datalens-name }}](#activate-datalens).
1. [Разрешите доступ из {{ datalens-name }} к кластеру](#allow-access).
1. [Создайте подключение к кластеру в {{ datalens-name }}](#create-connector).

## Активировать {{ datalens-name }} {#activate-datalens}

{% include [mdb-activate-datalens](../../_includes/mdb/datalens-activate.md) %}

## Разрешить доступ из {{ datalens-name }} к кластеру {#allow-access}

Чтобы {{ datalens-name }} мог подключаться к кластеру и работать с данными в нем, включите опцию **{{ ui-key.yacloud.mdb.forms.additional-field-datalens }}** при [создании кластера](cluster-create.md) или [изменении его настроек](update.md#change-additional-settings).

![screen01](../../_assets/managed-postgresql/operations/datalens-connect/screen01.png)

## Создать подключение к кластеру {#create-connector}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. Убедитесь, что сервис {{ datalens-name }} [активирован](#activate-datalens) в нужном каталоге и доступ к кластеру из него [разрешен](#allow-access).
  1. Перейдите на страницу каталога и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-postgresql }}**.

     ![screen02](../../_assets/managed-postgresql/operations/datalens-connect/screen02.png)

  1. Нажмите на имя нужного кластера и выберите вкладку **{{ ui-key.yacloud.postgresql.cluster.switch_datalens }}**.
  1. Нажмите кнопку **{{ ui-key.yacloud.mdb.datalens.button-action_new-connection }}**.

     ![screen03](../../_assets/managed-postgresql/operations/datalens-connect/screen03.png)

     {% cut "У меня нет кнопки «{{ ui-key.yacloud.mdb.datalens.button-action_new-connection }}»" %}

     Если вместо кнопки **{{ ui-key.yacloud.mdb.datalens.button-action_new-connection }}** вы видите сообщение «{{ ui-key.yacloud.mdb.datalens.label_activate-datalens-title }}», значит вы либо ещё не активировали {{ datalens-name }}, либо подключили его в другом каталоге. Чтобы подключить кластер к экземпляру {{ datalens-name }} из другого каталога, воспользуйтесь [инструкцией](../../datalens/operations/connection/create-postgresql.md) в документации {{ datalens-name }}.

     {% endcut %}

  1. Задайте [настройки подключения](#connector-settings).
  1. Проверьте, что настройки заданы корректно, нажав кнопку **Проверить подключение**.
  1. После успешной проверки подключения нажмите кнопку **Создать подключение**.

     ![screen04](../../_assets/managed-postgresql/operations/datalens-connect/screen04.png)

  1. В открывшемся окне введите имя подключения и нажмите **Создать**.

     ![screen05](../../_assets/managed-postgresql/operations/datalens-connect/screen05.png)

{% endlist %}

После создания подключения вы сможете:
* [Изменить](#update-connector) или [удалить](#delete-connector) это подключение.
* [Создавать датасеты](../../datalens/dataset/index.md) с данными кластера, используя это подключение.
* Визуализировать датасеты с помощью [чартов](../../datalens/concepts/chart/index.md) и [дашбордов](../../datalens/concepts/dashboard.md).

## Просмотреть список подключений кластера {#connectors-list}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. Перейдите на страницу каталога и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-postgresql }}**.
  1. Нажмите на имя нужного кластера и выберите вкладку **{{ ui-key.yacloud.postgresql.cluster.switch_datalens }}**.

     ![screen11](../../_assets/managed-postgresql/operations/datalens-connect/screen11.png)

{% endlist %}

## Изменить подключение к кластеру {#update-connector}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. Перейдите на страницу каталога и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-postgresql }}**.
  1. Нажмите на имя нужного кластера и выберите вкладку **{{ ui-key.yacloud.postgresql.cluster.switch_datalens }}**.
  1. Выберите подключение из списка.

     ![screen12](../../_assets/managed-postgresql/operations/datalens-connect/screen12.png)

  1. Измените [настройки](#connector-settings).
  1. Проверьте, что настройки заданы корректно, нажав кнопку **Проверить подключение**.
  1. После успешной проверки подключения нажмите кнопку **Сохранить изменения**.

     ![screen06](../../_assets/managed-postgresql/operations/datalens-connect/screen06.png)

{% endlist %}

## Удалить подключение к кластеру {#delete-connector}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. Перейдите на страницу каталога и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-postgresql }}**.
  1. Нажмите на имя нужного кластера и выберите вкладку **{{ ui-key.yacloud.postgresql.cluster.switch_datalens }}**.
  1. Выберите подключение из списка.
  1. Нажмите на значок ![image](../../_assets/console-icons/ellipsis.svg) вверху страницы и выберите **Удалить**.

     ![screen07](../../_assets/managed-postgresql/operations/datalens-connect/screen07.png)

  1. В открывшемся окне нажмите кнопку **Удалить**.

     ![screen08](../../_assets/managed-postgresql/operations/datalens-connect/screen08.png)

{% endlist %}

## Настройки подключения {#connector-settings}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. Если кластер и {{ datalens-name }} находятся в одной организации:
     1. Выберите вкладку **Выбрать в организации**.
     1. Выберите облако и каталог, в котором находится кластер.
     1. Выберите кластер и его хост из выпадающих списков, либо [создайте новый кластер](cluster-create.md) в каталоге с {{ datalens-name }}, нажав на кнопку **Создать новый**.
     1. Значение настройки **Порт** нужно оставить без изменений.
     1. Выберите **Путь к базе данных** из выпадающего списка.
     1. Выберите пользователя из выпадающего списка.
     1. Введите пароль этого пользователя.
     1. Укажите время жизни кеша или оставьте значение по умолчанию. Рекомендованное значение — 300 секунд (5 минут).
     1. Настройте **Уровень доступа SQL запросов**.

        ![screen09](../../_assets/managed-postgresql/operations/datalens-connect/screen09.png)

     1. Если в запросах к БД требуется явно задать правило сортировки, перейдите к разделу **Продвинутые настройки подключения**. Выберите один из режимов для настройки **Указание collate в запросе**:
        * **Авто** — применяется настройка по умолчанию, решение о включении локали `en_US` остается на усмотрение {{ datalens-name }}.
        * **Вкл** — применяется настройка {{ datalens-name }}, для отдельных выражений в запросе указывается локаль `en_US`. Это приводит к использованию соответствующей логики сортировки сервером, вне зависимости от настроек сервера и конкретных таблиц. Используйте настройку {{ datalens-name }}, если локаль в БД несовместима с работой {{ datalens-name }}. Подробнее о локали и `LC_COLLATE` смотрите в разделе [Создание кластера](./cluster-create.md#create-cluster).
        * **Выкл** — применяется настройка по умолчанию, {{ datalens-name }} использует только имеющиеся параметры локали БД.

        ![screen10](../../_assets/managed-postgresql/operations/datalens-connect/screen10.png)

   1. Если кластер и {{ datalens-name }} находятся в разных организациях, используйте настройки из [инструкции](../../datalens/operations/connection/create-postgresql.md) в документации {{ datalens-name }}.

{% endlist %}
