---
title: "Инструкция по подключению к кластеру {{ MY }} из {{ datalens-name }}"
description: "Из статьи вы узнаете, как подключиться к кластеру {{ MY }} из {{ datalens-name }}."
---

# Подключение к кластеру {{ MY }} из {{ datalens-name }}

{% include [mdb-datalens-connector-intro](../../_includes/mdb/datalens-connector-intro.md) %}

Чтобы использовать существующий кластер в качестве источника данных для {{ datalens-full-name }}:
1. [Активируйте {{ datalens-name }}](#activate-datalens).
1. [Разрешите доступ из {{ datalens-name }} к кластеру](#allow-access).
1. [Создайте подключение к кластеру в {{ datalens-name }}](#create-connector).

## Активировать {{ datalens-name }} {#activate-datalens}

{% include [mdb-activate-datalens](../../_includes/mdb/datalens-activate.md) %}

## Разрешить доступ из {{ datalens-name }} к кластеру {#allow-access}

Чтобы {{ datalens-name }} мог подключаться к кластеру и работать с данными в нем, включите опцию **{{ ui-key.yacloud.mdb.cluster.overview.label_access-datalens }}** при [создании кластера](cluster-create.md) или [изменении его настроек](update.md#change-additional-settings).

## Создать подключение к кластеру {#create-connector}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. Убедитесь, что сервис {{ datalens-name }} [активирован](#activate-datalens) в нужном каталоге и доступ к кластеру из него [разрешен](#allow-access).
  1. Перейдите на [страницу каталога]({{ link-console-main }}) и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-mysql }}**.
  1. Нажмите на имя нужного кластера и выберите вкладку **{{ ui-key.yacloud.mysql.cluster.switch_datalens }}**.
  1. Нажмите кнопку **Создать подключение**.

     {% cut "У меня нет кнопки «Создать подключение»" %}

     Если вместо кнопки **Создать подключение** вы видите сообщение «DataLens ещё не активирован», значит вы либо ещё не активировали {{ datalens-name }}, либо подключили его в другом каталоге. Чтобы подключить кластер к экземпляру {{ datalens-name }} из другого каталога, воспользуйтесь [инструкцией](../../datalens/operations/connection/create-mysql.md) в документации {{ datalens-name }}.

     {% endcut %}

  1. Задайте [настройки подключения](#connector-settings).
  1. В правом верхнем углу выберите область видимости подключения из выпадающего списка:
     * Доступно только мне.
     * Доступно для компании.
  1. Проверьте, что настройки заданы корректно, нажав кнопку **Проверить подключение**.
  1. После успешной проверки нажмите кнопку **Создать подключение**.
  1. Задайте имя подключения.
  1. Нажмите кнопку **Создать**.

{% endlist %}

После создания подключения вы сможете:
* [Изменить](#update-connector) или [удалить](#delete-connector) это подключение.
* [Создавать датасеты](../../datalens/concepts/dataset/index.md) с данными кластера, используя это подключение.
* Визуализировать датасеты с помощью [чартов](../../datalens/concepts/chart/index.md) и [дашбордов](../../datalens/concepts/dashboard.md).

## Просмотреть список подключений кластера {#connectors-list}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. Перейдите на [страницу каталога]({{ link-console-main }}) и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-mysql }}**.
  1. Нажмите на имя нужного кластера и выберите вкладку **{{ ui-key.yacloud.mysql.cluster.switch_datalens }}**.

{% endlist %}

## Изменить подключение к кластеру {#update-connector}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. Перейдите на [страницу каталога]({{ link-console-main }}) и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-mysql }}**.
  1. Нажмите на имя нужного кластера и выберите вкладку **{{ ui-key.yacloud.mysql.cluster.switch_datalens }}**.
  1. Выберите подключение из списка.
  1. Измените [настройки](#connector-settings) и область видимости подключения.
  1. Проверьте, что настройки заданы корректно, нажав кнопку **Проверить подключение**.
  1. После успешной проверки подключения нажмите кнопку **Сохранить**.

{% endlist %}

## Удалить подключение к кластеру {#delete-connector}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. Перейдите на [страницу каталога]({{ link-console-main }}) и выберите сервис **Managed Service for MySQL**.
  1. Нажмите на имя нужного кластера и выберите вкладку **DataLens**.
  1. Выберите подключение из списка.
  1. Нажмите на значок ![image](../../_assets/console-icons/ellipsis.svg) вверху страницы и выберите **Удалить**.
  1. В открывшемся окне нажмите кнопку **Удалить**.

{% endlist %}

## Настройки подключения {#connector-settings}

{% list tabs group=instructions %}

- Консоль управления {#console}

  Если кластер и {{ datalens-name }} находятся в одном каталоге:
  1. Откройте вкладку **Выбрать в каталоге**.
  1. Выберите кластер и его хост из выпадающих списков, либо [создайте новый кластер](cluster-create.md) в каталоге с {{ datalens-name }}, нажав на кнопку **Создать новый**.
  1. Выберите базу данных и пользователя из выпадающих списков.
  1. Введите пароль пользователя. См. также [{#T}](../../datalens/operations/connection/create-mysql.md) и [{#T}](../../datalens/concepts/dataset/settings.md#access-management) в документации {{ datalens-name }}.

  Если кластер и {{ datalens-name }} находятся в разных каталогах:
  1. Перейдите на вкладку **Указать вручную**.
  1. Используйте настройки из [инструкции](../../datalens/operations/connection/create-mysql.md) в документации {{ datalens-name }}.

{% endlist %}