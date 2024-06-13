---
title: "Инструкция по созданию подключения к {{ MY }} в {{ datalens-full-name }}"
description: "Из статьи вы узнаете, как подключиться к {{ MY }} в {{ datalens-full-name }}."
---

# Создание подключения к {{ MY }}


{% include [connection-note](../../../_includes/datalens/datalens-connection-note.md) %}


Чтобы создать подключение к {{ MY }}:


1. Перейдите на [страницу создания нового подключения]({{ link-datalens-main }}/connections/new).
1. В разделе **Базы данных** выберите подключение  **MySQL**.


1. Выберите тип подключения:

   {% list tabs group=connection %}

   - Выбрать в организации {#organization}

     {% include [datalens-db-select](../../../_includes/datalens/datalens-db-select.md) %}

     * **Кластер**. Укажите кластер из списка доступных кластеров {{ MY }}. В настройках кластера должна быть активирована опция **Доступ из {{ datalens-short-name }}**. Если у вас нет доступного кластера, нажмите кнопку **Создать новый**.

       {% include [datalens-cluster-list](../../../_includes/datalens/datalens-cluster-list.md) %}

     * **Имя хоста**. Выберите имя хоста из списка доступных в кластере {{ MY }}. Вы можете выбрать несколько хостов. Если к первому хосту подключиться не получится, {{ datalens-short-name }} выберет следующий из списка.
     * **Порт**. Укажите порт подключения к {{ MY }}. Порт по умолчанию — 3306.
     * **Путь к базе данных**. Укажите имя подключаемой базы данных.
     * **Имя пользователя**. Укажите имя пользователя для подключения к {{ MY }}.
     * **Пароль**. Укажите пароль для пользователя.
     * **Время жизни кеша в секундах**. Укажите время жизни кеша или оставьте значение по умолчанию. Рекомендованное значение — 300 секунд (5 минут).
     * **Уровень доступа SQL запросов**. Позволяет использовать произвольный SQL-запрос для [формирования датасета](../../concepts/dataset/settings.md#sql-request-in-datatset).

   - Указать вручную {#manual}

     {% include [datalens-db-specify-mannualy](../../../_includes/datalens/datalens-db-specify-mannualy.md) %}

     {% include [datalens-db-connection-parameters-mysql](../../../_includes/datalens/datalens-db-connection-parameters-mysql.md) %}

   {% endlist %}


1. (опционально) Проверьте работоспособность подключения. Для этого нажмите кнопку **Проверить подключение**.
1. Нажмите кнопку **Создать подключение**.


1. Выберите [воркбук](../../workbooks-collections/index.md), в котором сохранится подключение, или создайте новый. Если вы пользуетесь старой навигацией по папкам, выберите папку для сохранения подключения. Нажмите кнопку **Создать**.


1. Укажите название подключения и нажмите кнопку **Создать**.


## Дополнительные настройки {#additional-settings}

{% include [datalens-db-connection-export-settings](../../../_includes/datalens/operations/datalens-db-connection-export-settings.md) %}
