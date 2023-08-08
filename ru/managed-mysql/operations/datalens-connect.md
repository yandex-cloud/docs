---
title: "Инструкция по подключению к {{ MY }}-кластеру из {{ datalens-name }}"
description: "Из статьи вы узнаете, как подключиться к {{ MY }}-кластеру из {{ datalens-name }}."
---

# Подключение к {{ MY }}-кластеру из {{ datalens-name }}

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

{% list tabs %}

- Консоль управления

  1. Убедитесь, что сервис {{ datalens-name }} [активирован](#activate-datalens) в нужном каталоге и доступ к кластеру из него [разрешен](#allow-access).
  1. Перейдите на [страницу каталога]({{ link-console-main }}) и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-mysql }}**.
  1. Нажмите на имя нужного кластера и выберите вкладку **{{ ui-key.yacloud.mysql.cluster.switch_datalens }}**.
  1. Нажмите кнопку **{{ ui-key.yacloud.mdb.datalens.button-action_new-connection }}**.

     {% cut "У меня нет кнопки «{{ ui-key.yacloud.mdb.datalens.button-action_new-connection }}»" %}

     Если вместо кнопки **{{ ui-key.yacloud.mdb.datalens.button-action_new-connection }}** вы видите сообщение «{{ ui-key.yacloud.mdb.datalens.label_activate-datalens-title }}», значит вы либо ещё не активировали {{ datalens-name }}, либо подключили его в другом каталоге. Чтобы подключить кластер к экземпляру {{ datalens-name }} из другого каталога, воспользуйтесь [инструкцией](../../datalens/operations/connection/create-mysql.md) в документации {{ datalens-name }}.

     {% endcut %}

  1. Задайте [настройки подключения](#connector-settings).
  1. В правом верхнем углу выберите область видимости подключения из выпадающего списка:
     * {{ ui-key.datalens.connections.form.value_permission-owner-only }}.
     * {{ ui-key.datalens.connections.form.value_permission-explicit }}.
  1. Проверьте, что настройки заданы корректно, нажав кнопку **{{ ui-key.datalens.connections.form.button_verify }}**.
  1. После успешной проверки нажмите кнопку **{{ ui-key.yacloud.mdb.datalens.button-action_new-connection }}**.
  1. Задайте имя подключения.
  1. Нажмите кнопку **{{ ui-key.datalens.connections.form.button_create }}**.

{% endlist %}

После создания подключения вы сможете:
* [Изменить](#update-connector) или [удалить](#delete-connector) это подключение.
* [Создавать датасеты](../../datalens/concepts/dataset/index.md) с данными кластера, используя это подключение.
* Визуализировать датасеты с помощью [чартов](../../datalens/concepts/chart/index.md) и [дашбордов](../../datalens/concepts/dashboard.md).

## Просмотреть список подключений кластера {#connectors-list}

{% list tabs %}

- Консоль управления

  1. Перейдите на [страницу каталога]({{ link-console-main }}) и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-mysql }}**.
  1. Нажмите на имя нужного кластера и выберите вкладку **{{ ui-key.yacloud.mysql.cluster.switch_datalens }}**.

{% endlist %}

## Изменить подключение к кластеру {#update-connector}

{% list tabs %}

- Консоль управления

  1. Перейдите на [страницу каталога]({{ link-console-main }}) и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-mysql }}**.
  1. Нажмите на имя нужного кластера и выберите вкладку **{{ ui-key.yacloud.mysql.cluster.switch_datalens }}**.
  1. Выберите подключение из списка.
  1. Измените [настройки](#connector-settings) и область видимости подключения.
  1. Проверьте, что настройки заданы корректно, нажав кнопку **{{ ui-key.datalens.connections.form.button_verify }}**.
  1. После успешной проверки подключения нажмите кнопку **{{ ui-key.datalens.connections.form.button_save-connection }}**.

{% endlist %}

## Удалить подключение к кластеру {#delete-connector}

{% list tabs %}

- Консоль управления

  1. Перейдите на [страницу каталога]({{ link-console-main }}) и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-mysql }}**.
  1. Нажмите на имя нужного кластера и выберите вкладку **{{ ui-key.yacloud.mysql.cluster.switch_datalens }}**.
  1. Выберите подключение из списка.
  1. Нажмите на значок ![image](../../_assets/horizontal-ellipsis.svg) вверху страницы и выберите **{{ ui-key.datalens.connections.file.view.label_action-delete }}**.
  1. В открывшемся окне нажмите кнопку **{{ ui-key.datalens.connections.form.button_remove }}**.

{% endlist %}

## Настройки подключения {#connector-settings}

{% list tabs %}

- Консоль управления

  Если кластер и {{ datalens-name }} находятся в одном каталоге:
  1. Откройте вкладку **{{ ui-key.datalens.connections.form.value_fill-mode-cloud }}**.
  1. Выберите кластер и его хост из выпадающих списков, либо [создайте новый кластер](cluster-create.md) в каталоге с {{ datalens-name }}, нажав на кнопку **{{ ui-key.datalens.connections.form.button_create-mdb-cluster }}**.
  1. Выберите базу данных и пользователя из выпадающих списков.
  1. Введите пароль пользователя. См. также [{#T}](../../datalens/operations/connection/create-mysql.md) и [{#T}](../../datalens/concepts/dataset/settings.md#access-management) в документации {{ datalens-name }}.

  Если кластер и {{ datalens-name }} находятся в разных каталогах:
  1. Перейдите на вкладку **{{ ui-key.datalens.connections.form.value_fill-mode-manually }}**.
  1. Используйте настройки из [инструкции](../../datalens/operations/connection/create-mysql.md) в документации {{ datalens-name }}.

{% endlist %}