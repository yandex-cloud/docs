# Создание подключения к MS SQL Server

{% include [connection-note](../../../_includes/datalens/datalens-connection-note.md) %}

## Подключение к MS SQL Server {#ms-sql-server-connection}

Чтобы создать подключение к MS SQL Server:

{% if audience == "internal" %}

1. Перейдите на [страницу подключений](https://datalens.yandex-team.ru/connections).

{% else %}

1. Перейдите на [страницу подключений](https://datalens.yandex.ru/connections).

{% endif %}

1. Нажмите кнопку **Создать подключение**.
1. Выберите подключение **MS SQL Server**.
1. Укажите параметры подключения:
    - **Имя подключения**. Задайте имя подключения. Имя может быть произвольным.
    - **Имя хоста или IP**. Укажите путь до хоста MS SQL Server.
    - **Порт**. Укажите порт подключения к MS SQL Server.
    - **Имя базы данных**. Укажите имя подключаемой базы данных.
    - **Имя пользователя**. Укажите имя пользователя для подключения к MS SQL Server.
    - **Пароль**. Укажите пароль для указанного пользователя.
1. Нажмите **Подключить**. Подключение появится в списке.

{% include [datalens-check-host](../../../_includes/datalens/operations/datalens-check-host.md) %}
