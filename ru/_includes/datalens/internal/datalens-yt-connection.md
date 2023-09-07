Чтобы создать подключение к CHYT:


{% include [datalens-workbooks-collections-note](../../../_includes/datalens/operations/datalens-workbooks-collections-note.md) %}


1. Перейдите на [страницу подключений](https://datalens.yandex.ru/connections).
1. Нажмите кнопку **Создать подключение**.
1. Выберите подключение **CHYT**.


1. Укажите параметры подключения:
   
   * **Токен {{ ytsaurus-name }}**. Укажите вручную OAuth-токен для работы с {{ ytsaurus-name }}. Подробнее см. в [документации {{ ytsaurus-name }}](https://ytsaurus.tech/docs/ru/user-guide/storage/auth).
   * **Имя хоста**. Укажите адрес прокси серверов {{ ytsaurus-name }}.
   * **Порт**. Укажите порт подключения к CHYT.
   * **Клика**. Укажите алиас запущенной клики. По умолчанию используется публичная клика `*ch_public`.
   * **Время жизни кеша в секундах**. Укажите время жизни кеша или оставьте значение по умолчанию. Рекомендованное значение — 300 секунд (5 минут).
   * **Уровень доступа SQL запросов**. Выберите уровень доступа к SQL-запросам для пользователя.


1. Нажмите кнопку **Создать подключение**.
1. Укажите название подключения и нажмите кнопку **Создать**.

{% include [datalens-check-host](../../../_includes/datalens/operations/datalens-check-host.md) %}


## Дополнительные настройки {#additional-settings}

{% include [datalens-db-connection-export-settings](../../../_includes/datalens/operations/datalens-db-connection-export-settings.md) %}
