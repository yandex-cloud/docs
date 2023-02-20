# Доступ к API

Для доступа приложений к {{ api-name }} используется авторизация по [протоколу OAuth 2.0](#section_about_OAauth) {% if audience == "external" %}или по [IAM-токену](#iam-token){% endif %}.

Если ваше приложение написано на языке Python, для вызова API вы можете использовать [Python-клиент](#section_about_python_client).

В запросах к {{ api-short-name }} указывайте заголовки:

 - `Host: {{ host }}`

 - `Authorization: OAuth <ваш OAuth-токен>`{% if audience == "external" %} — при доступе по [протоколу OAuth 2.0](#section_about_OAauth).

   `Authorization: Bearer <ваш IAM-TOKEN>` — при доступе по [IAM-токену](#iam-token).

 - `X-Org-ID: <идентификатор организации>`
    
   Чтобы узнать идентификатор организации, перейдите на [страницу настроек {{ tracker-name }}]({{ link-settings }}). Идентификатор указан в поле **ID организации для API**.
    
 {% endif %}

## Получить доступ к API по протоколу OAuth 2.0 {#section_about_OAauth}

Протокол OAuth 2.0 позволяет приложениям работать с сервисами Яндекса от имени пользователя. С базовыми принципами OAuth, а также с особенностями реализации протокола в Яндексе вы можете ознакомиться в [документе "OAuth-авторизация. Руководство Разработчика"]({{ link-OAuth-dev-guide }}).

Чтобы получить доступ, необходимо зарегистрировать приложение. Приложение перенаправляет пользователя на страницу запроса доступа OAuth-сервера Яндекса.  Пользователь авторизуется на Яндексе и подтверждает доступ приложения к своим данным. 

Чтобы получить доступ к {{ api-name }}:

{% if audience == "external" %}

1. [Зарегистрируйте]({{ link-register-application }}) приложение на OAuth-сервере:
  
   1. Перейдите на страницу [**Создание приложения**]({{ link-get-token }}client/new). Введите название приложения.
  
   1. Выберите платформу, на которой работает приложение, и укажите ее [настройки]({{ link-register-application-platforms }}#register-client__platform).

      Например, для отладочных запросов к API выберите **Веб-сервисы**, а в поле **Callback URL** подставьте значение по умолчанию с помощью ссылки **Подставить URL для разработки**.
  
   1. В блоке **Какие данные вам нужны?** откройте **Трекер (tracker)** и выберите опции:
      * **Запись в трекер (tracker:write)**.
      * **Чтение из трекера (tracker:read)**.
  
   1. Нажмите **Создать приложение**.

1. Получите OAuth-токен для авторизации:
  
   1. Выберите ваше приложение из [списка]({{ link-get-token }}).
  
   1. Скопируйте значение в поле **ClientID** и сформируйте ссылку для запроса токена:
     `{{ link-get-token }}authorize?response_type=token&client_id=<идентификатор приложения>`
     Вы можете указать [дополнительные параметры]({{ link-web-oauth }}) запроса токена.
  
   1. Перейдите по ссылке и скопируйте OAuth-токен. Полученный токен необходимо использовать в запросах к API {{ tracker-name }}.
   
     {% note info %}
     
     Яндекс&#160;OAuth перенаправляет пользователя на адрес, указанный в поле **Callback URL** на странице приложения. Адрес формируется автоматически в соответствии с настройками приложения и параметрами выбранной платформы. 
     Если ваше приложение еще в разработке, для доступа к {{ tracker-name }} вы можете вручную получить [отладочный токен]({{ link-oauth-token }}) от имени тестового пользователя.
     
     {% endnote %}

{% else %}

1. Перейдите по [ссылке]({{ link-get-token }}) и скопируйте OAuth-токен. Полученный токен необходимо использовать в запросах к API {{ tracker-name }}.

{% endif %}

1. Чтобы проверить наличие доступа к API, выполните [запрос информации о текущем пользователе](../get-user-info.md).
   Если доступ не был получен, запрос вернет ответ с кодом `401 Unauthorized`.

Полученный токен предоставляет те же права, что есть у аккаунта пользователя в {{ tracker-name }}. Например, если у пользователя нет прав на изменение настроек очереди, соответствующие запросы к API будут недоступны.

{% if audience == "external" %}

## Получить доступ к API по IAM-токену {#iam-token}

IAM-токен — уникальная последовательность символов, которая выдается пользователю после прохождения аутентификации. С помощью этого токена пользователь авторизуется в {{ api-name }} и выполняет операции с ресурсами. Подробнее об этом способе аутентификации читайте в [документации сервиса идентификации и контроля доступа](../../iam/concepts/authorization/iam-token.md).

IAM-токен действует не больше {{ iam-token-lifetime }} и ограничен временем жизни cookie у [федерации](../../organization/add-federation.md). После истечения срока жизни вернется ошибка с кодом `401 Unauthorized`. 

### Получить IAM-токен для аккаунта на Яндексе {#iam-token-yandex-account}

{% list tabs %}

- CLI

  1. {% include [cli-install](../../_includes/cli-install.md) %}

  1. Получите IAM-токен:

    ```
    $ yc iam create-token
    ```

- API
  
  1. Получите OAuth-токен по ссылке [https://oauth.yandex.ru/authorize?response_type=token&client_id=1a6990aa636648e9b2ef855fa7bec2fb](https://oauth.yandex.ru/authorize?response_type=token&client_id=1a6990aa636648e9b2ef855fa7bec2fb).

  1. Полученный токен обменяйте на IAM-токен. Для этого используйте HTTP-запрос с методом `POST`: 

     ```json
      POST https://iam.{{ api-host }}/iam/v1/tokens

       {
          "yandexPassportOauthToken": "<OAUTH-token>"
       }
      ```
  1. API возвращает ответ. Тело ответа содержит информацию в формате JSON. В атрибуте **iamToken** будет искомое значение. 

  > Пример ответа:
  > ```
  >  {
  >    "iamToken": "t1.9euelZqYksrMiYrGiY-TmpGUnZPHz-3rnpWay4-SjJCKnp7KlouMjJ3Kncrl9PcSLTl0-e8rTxrv3fT3Uls2dPnvK08a7w.vqGV8pzV84HGSmX9eLmvKaIBpRx9HDbKWEwN6ryIQ",
  >    "expiresAt": "2021-10-22T05:54:53.035215444Z"
  >  }
  > ```

{% endlist %}

### Получить IAM-токен для федеративного аккаунта {#iam-token-federation}

1. {% include [cli-install](../../_includes/cli-install.md) %}

1. Чтобы инициировать [федеративный аккаунт](../../iam/operations/iam-token/create-for-federation.md), выполните команду:

    ```
    yc init --federation-id=<ID федерации>
    ```

1. В браузере откроется страница, авторизуйтесь в федеративном аккаунте.

1. Чтобы получить IAM-токен, выполните команду:

    ```
    yc iam create-token
    ```
 {% endif %}

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
    Здесь `<token>` — ваш OAuth-токен, а `<org_id>` — идентификатор организации. Чтобы узнать идентификатор организации, перейдите на [страницу настроек {{ tracker-name }}]({{ link-settings }}). Идентификатор указан в поле **ID организации для API**.

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


