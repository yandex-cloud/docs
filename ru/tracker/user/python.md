# Python клиент

Чтобы вам было проще начать пользоваться [API {{ tracker-name }}](../about-api.md), мы подготовили [yandex_tracker_client](https://github.com/yandex/yandex_tracker_client) — пакет, позволяющий легко добавлять вызовы API в программы, написанные на языке Python.

Чтобы начать пользоваться клиентом:

1. Скачайте и установите на свой компьютер актуальную версию Python с сайта [https://www.python.org/downloads/](https://www.python.org/downloads/).

1. В командной строке вашей ОС выполните команду:
    

    ```
    pip install yandex_tracker_client
    ```

    

1. Получите OAuth-токен и идентификатор организации для доступа к API. Подробнее о том, как это сделать, читайте в [Справочнике API](../concepts/access.md).

1. Инициализируйте клиент в коде вашей программы:
    ```
    from yandex_tracker_client import TrackerClient
    client = TrackerClient(token='<OAuth-токен>', org_id='<идентификатор_организации>')
    ```
    Здесь `<OAuth-токен>` — ваш OAuth-токен, а `<идентификатор_организации>` — идентификатор организации.

В клиенте используйте такой же формат данных, как в [API {{ tracker-name }}](../concepts/access.md).

Подробнее о работе клиента и условиях использования читайте на его странице в GitHub: [https://github.com/yandex/yandex_tracker_client](https://github.com/yandex/yandex_tracker_client).

