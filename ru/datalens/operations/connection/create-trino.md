---
title: Инструкция по созданию подключения к {{ TR }} в {{ datalens-full-name }}
description: Из статьи вы узнаете, как подключиться к {{ TR }} в {{ datalens-full-name }}.
---

# Создание подключения к {{ TR }} в {{ datalens-full-name }}

Чтобы создать подключение к {{ TR }}:


1. Перейдите на [страницу создания нового подключения]({{ link-datalens-main }}/connections/new).
1. В разделе **Базы данных** выберите подключение **{{ TR }}**.



1. Выберите тип подключения:

    {% list tabs group=connection %}

    - Выбрать в организации {#organization}

      1. {% include [datalens-db-select](../../../_includes/datalens/datalens-db-select-2.md) %}

          * **Облако и каталог**. Выберите каталог, в котором будет находиться ваш сервисный аккаунт.
          * **Сервисный аккаунт**. Выберите существующий сервисный аккаунт или [создайте](../../../iam/operations/sa/create.md) новый.
          * **Кластер**. Укажите кластер из списка доступных кластеров {{ TR }} или [создайте](../../../managed-trino/operations/cluster-create.md) новый.

          {% include [datalens-db-sql-level-2](../../../_includes/datalens/datalens-db-connection-sql-level-2.md) %}

      1. {% include [connection-trino-cache](../../../_includes/datalens/connection-trino-cache.md) %}
      1. {% include [connection-trino-advanced](../../../_includes/datalens/connection-trino-advanced.md) %}

    - Указать вручную {#manual}

      1. Выберите **Тип аутентификации**:
          * `Без аутентификации`
          * `Пароль`
          * `JWT`

      1. {% include [connection-trino-manual](../../../_includes/datalens/connection-trino-manual.md) %}
      1. {% include [connection-trino-cache](../../../_includes/datalens/connection-trino-cache.md) %}
      1. {% include [connection-trino-advanced](../../../_includes/datalens/connection-trino-advanced.md) %}
      1. (Опционально) Проверьте работоспособность подключения. Для этого нажмите кнопку **Проверить подключение**.

    {% endlist %}

1. Нажмите кнопку **Создать подключение**.
1. Выберите [воркбук](../../workbooks-collections/index.md), в котором сохранится подключение, или создайте новый. Если вы пользуетесь старой навигацией по папкам, выберите папку для сохранения подключения.
1. Укажите название подключения и нажмите кнопку **Создать**.



## Дополнительные настройки {#additional-settings}

Вы можете указать дополнительные параметры подключения в разделе **Продвинутые настройки подключения**:


{% list tabs group=connection %}

- Выбрать в организации {#organization}

  * {% include [datalens-db-connection-export-settings-item](../../../_includes/datalens/operations/datalens-db-connection-export-settings-item.md) %}
  * {% include [datalens-db-connection-table-list-settings-item.md](../../../_includes/datalens/operations/datalens-db-connection-table-list-settings-item.md) %}

  ![image](../../../_assets/datalens/operations/connection/connection-trino-yc-additional.png)

- Указать вручную {#manual}

  {% include [connection-trino-additional-settings](../../../_includes/datalens/connection-trino-additional-settings.md) %}

{% endlist %}




## Подключение внешней БД {#external-db-connection}

{% include [connection-external](../../../_includes/datalens/datalens-connection-external.md) %}



## Создание датасета {#create-dataset}

Область поиска таблиц при подключении к {{ TR }} ограничена конкретным каталогом.

При [создании датасета](../../dataset/create-dataset.md) на основе подключения к {{ TR }}:

1. На странице подключения в правом верхнем углу нажмите кнопку **Создать датасет**.
1. Выберите каталог в источнике. На панели ниже отобразятся размещенные в нем таблицы.

   {% cut "Выбор каталога в источнике" %}

   ![image](../../../_assets/datalens/operations/connection/dataset-trino-catalog.png)

   {% endcut %}

1. Продолжайте [инструкцию](../../dataset/create-dataset.md#add-data) с шага 4.