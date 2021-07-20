# Python клиент

Чтобы вам было проще начать пользоваться [API {{ tracker-name }}](../about-api.md), мы подготовили {% if audience == "external" %}[yandex_tracker_client](https://github.com/yandex/yandex_tracker_client){% else %}[startrek_client](https://pypi.yandex-team.ru/dashboard/repositories/default/packages/startrek_client/){% endif %} — пакет, позволяющий легко добавлять вызовы API в программы, написанные на языке Python.

Чтобы начать пользоваться клиентом:

1. Скачайте и установите на свой компьютер актуальную версию Python с сайта [https://www.python.org/downloads/](https://www.python.org/downloads/).

1. В командной строке вашей ОС выполните команду:
    
    {% if audience == "external" %}

    ```
    pip install yandex_tracker_client
    ```

    {% else %}
    
    ```
    pip install -i https://pypi.yandex-team.ru/simple/ startrek_client
    ```

    или

    ```
    pip install git+git://github.yandex-team.ru/tools/startrek-python-client.git
    ```
    
    {% endif %}
    
{% if audience == "external" %}

1. Получите OAuth-токен и идентификатор организации для доступа к API. Подробнее о том, как это сделать, читайте в [Справочнике API](../concepts/access.md).

1. Инициализируйте клиент в коде вашей программы:
    ```
    from yandex_tracker_client import TrackerClient
    client = TrackerClient(token=<token>, org_id=<org_id>)
    ```
    Здесь `<token>` — ваш OAuth-токен, а `<org_id>` — идентификатор организации.

В клиенте используйте такой же формат данных, как в [API {{ tracker-name }}](../concepts/access.md).

Подробнее о работе клиента и условиях использования читайте на его странице в GitHub: [https://github.com/yandex/yandex_tracker_client](https://github.com/yandex/yandex_tracker_client).

{% else %}

1. Получите OAuth-токен. Для этого перейдите по ссылке и авторизуйтесь: [https://oauth.yandex-team.ru/authorize?response_type=token&client_id=5f671d781aca402ab7460fde4050267b](https://oauth.yandex-team.ru/authorize?response_type=token&client_id=5f671d781aca402ab7460fde4050267b).

1. Инициализируйте клиент в коде вашей программы:
    ```
    from startrek_client import Startrek
    client = Startrek(token=<token>)
    ```
    Здесь `<token>` — ваш OAuth-токен.

В клиенте используйте такой же формат данных, как в [API {{ tracker-name }}](../concepts/access.md).

Дополнительная информация:

- [https://a.yandex-team.ru/arc/trunk/arcadia/library/python/startrek_python_client](https://a.yandex-team.ru/arc/trunk/arcadia/library/python/startrek_python_client)

- [https://pypi.yandex-team.ru/dashboard/repositories/default/packages/startrek_client/](https://pypi.yandex-team.ru/dashboard/repositories/default/packages/startrek_client/)

{% endif %}