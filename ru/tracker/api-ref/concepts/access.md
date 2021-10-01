# Доступ к API

Для доступа приложений к {{ api-name }} используется авторизация по протоколу OAuth 2.0.

Если ваше приложение написано на языке Python, для вызова API вы можете использовать Python-клиент.

## Получить доступ к API {#section_about_OAauth}

Протокол OAuth 2.0 позволяет приложениям работать с сервисами Яндекса от имени пользователя. С базовыми принципами OAuth, а также с особенностями реализации протокола в Яндексе вы можете ознакомиться в [документе "OAuth-авторизация. Руководство Разработчика"]({{ link-OAuth-dev-guide }}).

Чтобы получить доступ к {{ api-name }}:
{% if audience == "external" %}
1. [Зарегистрируйте]({{ link-register-application }}) приложение и настройте для него доступ к чтению и записи в {{ tracker-name }}.
{% endif %}
1. [Получите]({{ link-get-token }}) OAuth-токен для авторизации.

2. В запросах к {{ api-short-name }} указывайте заголовки:

    - `Host: {{ host }}`
    - `Authorization: OAuth <ваш OAuth-токен>`

    {% if audience == "external" %}

    - `X-Org-ID: <идентификатор организации>`
    
    Чтобы узнать идентификатор организации, перейдите на [страницу настроек {{ tracker-name }}]({{ link-settings }}). Идентификатор указан в поле **ID организации для API**.
    
    {% endif %}

3. Чтобы проверить наличие доступа к API, выполните [запрос информации о текущем пользователе](../get-user-info.md).
   Если доступ не был получен, запрос вернет ответ с кодом `401 Unauthorized`.


Полученный токен предоставляет те же права, что есть у аккаунта пользователя в {{ tracker-name }}. Например, если у пользователя нет прав на изменение настроек очереди, соответствующие запросы к API будут недоступны.

## Python-клиент {#section_about_python_client}

При разработке приложений на языке Python вы можете использовать пакет {% if audience == "external" %}[yandex_tracker_client](https://github.com/yandex/yandex_tracker_client){% else %}[startrek_client](https://pypi.yandex-team.ru/dashboard/repositories/default/packages/startrek_client/){% endif %} — клиент, который облегчает работу с {{ api-short-name }}.

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

В клиенте используйте такой же формат данных, как в API {{ tracker-name }}.

Подробнее о работе клиента и условиях использования читайте на его странице в GitHub: [https://github.com/yandex/yandex_tracker_client](https://github.com/yandex/yandex_tracker_client).

{% else %}

1. Получите OAuth-токен. Для этого перейдите по ссылке и авторизуйтесь: [https://oauth.yandex-team.ru/authorize?response_type=token&client_id=5f671d781aca402ab7460fde4050267b](https://oauth.yandex-team.ru/authorize?response_type=token&client_id=5f671d781aca402ab7460fde4050267b).

1. Инициализируйте клиент в коде вашей программы:
    ```
    from startrek_client import Startrek
    client = Startrek(token=<token>)
    ```
    Здесь `<token>` — ваш OAuth-токен.

В клиенте используйте такой же формат данных, как в API {{ tracker-name }}.

Дополнительная информация:

- [https://a.yandex-team.ru/arc/trunk/arcadia/library/python/startrek_python_client](https://a.yandex-team.ru/arc/trunk/arcadia/library/python/startrek_python_client)

- [https://pypi.yandex-team.ru/dashboard/repositories/default/packages/startrek_client/](https://pypi.yandex-team.ru/dashboard/repositories/default/packages/startrek_client/)

{% endif %}