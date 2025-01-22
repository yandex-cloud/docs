---
title: Инструкция по подключению к кластеру {{ CH }} из {{ datalens-name }}
description: Из статьи вы узнаете, как подключиться к кластеру {{ CH }} из {{ datalens-name }}.
---

# Подключение к кластеру {{ CH }} из {{ datalens-name }}

{% include [mdb-datalens-connector-intro](../../_includes/mdb/datalens-connector-intro.md) %}

Чтобы использовать существующий кластер в качестве источника данных для {{ datalens-name }}:
1. [Активируйте {{ datalens-full-name }}](#activate-datalens).
1. [Разрешите доступ из {{ datalens-name }} к кластеру](#allow-access).
1. [Создайте подключение к кластеру в {{ datalens-name }}](#create-connector).

## Активировать {{ datalens-name }} {#activate-datalens}

Подключить кластер к {{ datalens-name }} внутри облака можно только, если {{ datalens-name }} активирован в том же каталоге, что и кластер.

Если {{ datalens-name }} активирован в другом каталоге, кластер можно подключить как внешний ресурс при условии, что к кластеру есть публичный доступ. [Подробнее о подключении из другого каталога](../../datalens/operations/connection/create-clickhouse.md).

{% include [mdb-activate-datalens](../../_includes/mdb/datalens-activate.md) %}

## Разрешить доступ из {{ datalens-name }} к кластеру {#allow-access}

Чтобы {{ datalens-name }} мог подключаться к кластеру и работать с данными в нем, включите опцию **{{ ui-key.yacloud.mdb.forms.additional-field-datalens }}** при [создании кластера](cluster-create.md) или [изменении его настроек](update.md#change-additional-settings).

## Создать подключение к кластеру {#create-connector}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. Убедитесь, что сервис **{{ datalens-name }}** [активирован](#activate-datalens) в нужном каталоге и доступ к кластеру из него [разрешен](#allow-access).
  1. В [консоли управления]({{ link-console-main }}) перейдите на страницу каталога и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-clickhouse }}**.
  1. Нажмите на имя нужного кластера и выберите вкладку **{{ ui-key.yacloud.clickhouse.cluster.switch_datalens }}**.
  1. Нажмите кнопку **{{ ui-key.yacloud.mdb.datalens.button-action_new-connection }}**.

     {% cut "У меня нет кнопки «{{ ui-key.yacloud.mdb.datalens.button-action_new-connection }}»" %}

     
     Если вместо кнопки **{{ ui-key.yacloud.mdb.datalens.button-action_new-connection }}** вы видите сообщение «{{ ui-key.yacloud.mdb.datalens.label_activate-datalens-title }}», значит вы либо еще не активировали {{ datalens-name }}, либо подключили его в другом каталоге. Чтобы подключить кластер к экземпляру {{ datalens-name }} из другого каталога, воспользуйтесь [инструкцией](../../datalens/operations/connection/create-clickhouse.md) в документации {{ datalens-name }}.


     {% endcut %}

  1. Задайте [настройки подключения](#connector-settings).
  1. Проверьте, что настройки заданы корректно, нажав кнопку **Проверить подключение**.
  1. После успешной проверки подключения нажмите кнопку **Создать**.

{% endlist %}

После создания подключения вы сможете:
* [Изменить](#update-connector) или [удалить](#delete-connector) это подключение.
* [Создавать датасеты](../../datalens/dataset/index.md) с данными кластера, используя это подключение.
* Визуализировать датасеты с помощью [чартов](../../datalens/concepts/chart/index.md) и [дашбордов](../../datalens/concepts/dashboard.md).


См. также: [пример визуализации данных из {{ CH }}](../../tutorials/datalens/data-from-ch-visualization.md).


## Просмотреть список подключений кластера {#connectors-list}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) перейдите на страницу каталога и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-clickhouse }}**.
  1. Нажмите на имя нужного кластера и выберите вкладку **{{ ui-key.yacloud.clickhouse.cluster.switch_datalens }}**.

     {% cut "Моего подключения нет в списке" %}

     Если нужного подключения нет в списке, значит кластер подключен к {{ datalens-name }} как внешний источник. [Подробнее о работе {{ datalens-name }}](../../datalens/).

     {% endcut %} 

{% endlist %}

## Изменить подключение к кластеру {#update-connector}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) перейдите на страницу каталога и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-clickhouse }}**.
  1. Нажмите на имя нужного кластера и выберите вкладку **{{ ui-key.yacloud.clickhouse.cluster.switch_datalens }}**.
  1. Выберите подключение из списка.

     {% cut "Моего подключения нет в списке" %}

     Если нужного подключения нет в списке, значит кластер подключен к {{ datalens-name }} как внешний источник. [Подробнее о работе {{ datalens-name }}](../../datalens/).

     {% endcut %} 

  1. Измените [настройки](#connector-settings).
  1. Проверьте, что настройки заданы корректно, нажав кнопку **Проверить подключение**.
  1. После успешной проверки подключения нажмите кнопку **Сохранить**.

{% endlist %}

## Удалить подключение к кластеру {#delete-connector}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) перейдите на страницу каталога и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-clickhouse }}**.
  1. Нажмите на имя нужного кластера и выберите вкладку **{{ ui-key.yacloud.clickhouse.cluster.switch_datalens }}**.
  1. Выберите подключение из списка.

     {% cut "Моего подключения нет в списке" %}

     Если нужного подключения нет в списке, значит кластер подключен к {{ datalens-name }} как внешний источник. [Подробнее о работе {{ datalens-name }}](../../datalens/).

     {% endcut %} 

  1. Нажмите на значок ![image](../../_assets/console-icons/ellipsis.svg) вверху страницы и выберите **Удалить**.
  1. В открывшемся окне нажмите кнопку **Удалить**.

{% endlist %}

## Настройки подключения {#connector-settings} 

{% list tabs group=instructions %}

- Консоль управления {#console}

  В [консоли управления]({{ link-console-main }}) при [создании](#create-connector) или [изменении](#update-connector) подключения к кластеру:
  1. Задайте имя подключения.
  1. Выберите вкладку **Выбрать в каталоге**.
  1. Выберите кластер и его хост из выпадающих списков, либо [создайте новый кластер](cluster-create.md) в каталоге с {{ datalens-name }}, нажав на кнопку **Создать новый**.
  1. Выберите пользователя из выпадающего списка.
  1. Введите пароль этого пользователя.

     Значения настроек **Порт HTTP-интерфейса**, **HTTPS**, **Время жизни кеша в секундах** и **Уровень доступа SQL-запросов** оставьте без изменений.

{% endlist %}

{% cut "Кластер и {{ datalens-name }} находятся в разных каталогах" %}

Если кластер и {{ datalens-name }} находятся в разных каталогах, используйте настройки из [инструкции](../../datalens/operations/connection/create-clickhouse.md) в документации {{ datalens-name }}.

{% endcut %}

Если для пользователя задана [настройка **Read only**](cluster-users.md#setting-readonly), убедитесь, что значение настройки — `0` или `2`. В противном случае подключение работать не будет.

{% include [clickhouse-disclaimer](../../_includes/clickhouse-disclaimer.md) %}
