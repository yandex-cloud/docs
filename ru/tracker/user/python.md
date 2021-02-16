# Python клиент

Чтобы вам было проще начать пользоваться [API {{ tracker-name }}]{% if locale == "ru" %}(https://tech.yandex.ru/connect/tracker/){% else %}(https://tech.yandex.com/connect/tracker/){% endif %}, мы подготовили [yandex_tracker_client](https://github.com/yandex/yandex_tracker_client) — пакет, позволяющий легко добавлять вызовы API в программы, написанные на языке Python.

Чтобы начать пользоваться клиентом:

1. Скачайте и установите на свой компьютер актуальную версию Python с сайта [https://www.python.org/downloads/](https://www.python.org/downloads/).

1. В командной строке вашей ОС выполните команду:
    ```
    pip install yandex_tracker_client
    ```
    
1. Получите OAuth-токен и идентификатор организации для доступа к API. Подробнее о том, как это сделать, читайте в [документации API {{ tracker-name }}]{% if locale == "ru" %}(https://tech.yandex.ru/connect/tracker/api/concepts/access-docpage/){% else %}(https://tech.yandex.com/connect/tracker/api/concepts/access-docpage/){% endif %}.

1. Инициализируйте клиент в коде вашей программы:
    ```
    from yandex_tracker_client import TrackerClient
    client = TrackerClient(token=<token>, org_id=<org_id>)
    ```
    Здесь `<token>` — ваш OAuth-токен, а `<org_id>` — идентификатор организации.

Подробнее о работе клиента и условиях использования читайте на его странице в GitHub: [https://github.com/yandex/yandex_tracker_client](https://github.com/yandex/yandex_tracker_client).

