# Получить информацию о пользователе

Запрос позволяет получить информацию об учетной записи пользователя организации.

## Формат запроса {#query}

Перед выполнением запроса [получите доступ к API](concepts/access.md).

Для получения информации о пользователе используйте HTTP-запрос с методом `GET`:

```json
GET /v2/users/<uid/login>
Host: {{ host }}
Authorization: OAuth <OAuth-токен>
{{ org-id }}
```

{% include [headings](../_includes/tracker/api/headings.md) %}

{% cut "Ресурс" %}

Параметр | Описание | Тип данных
--- | --- | ---
\<uid/login\> | Уникальный идентификатор учетной записи или логин пользователя. | Строка

{% endcut %}

## Формат ответа {#answer}

{% list tabs %}

- Запрос выполнен успешно

    {% include [answer-200](../_includes/tracker/api/answer-200.md) %}
   
    Тело ответа содержит JSON-массив с параметрами пользователя.

    {% if audience == "external" %}

    ```json
       [
          {
          "self": "{{ host }}/v2/users/1234567890",
          "uid": 1234567890,
          "login": "<user_login>",
          "trackerUid": 1234567890,
          "passportUid": 1234567890,
          "firstName": "<Имя>",
          "lastName": "<Фамилия>",
          "display": "<Имя Фамилия>",
          "email": "<login@yandex.ru>",
          "external": false,
          "hasLicense": true,
          "dismissed": false,
          "useNewFilters": true,
          "disableNotifications": false,
          "firstLoginDate": "2020-10-27T13:06:21.787+0000",
          "lastLoginDate": "2022-07-25T17:12:33.787+0000",
          "welcomeMailSent": true
          }
       ]
    ```

    {% else %}

    ```json
       [
          {
          "self": "{{ host }}/v2/users/1234567890",
          "uid": 1234567890,
          "login": "<user_login>",
          "trackerUid": 1234567890,
          "passportUid": 1234567890,
          "firstName": "<Имя>",
          "lastName": "<Фамилия>",
          "display": "<Имя Фамилия>",
          "email": "<login@yandex-team.ru>",
          "office": {
             "self": "https://st-api.yandex-team.ru/v2/offices/1",
             "id": "1",
             "display": "Москва, БЦ Морозов"
          },
          "external": false,
          "hasLicense": true,
          "dismissed": false,
          "useNewFilters": true,
          "disableNotifications": false,
          "firstLoginDate": "2020-10-27T13:06:21.787+0000",
          "lastLoginDate": "2022-07-25T17:12:33.787+0000",
          "activeExperiments": [
             <список экспериментов>
          ]
          }
       ]
    ```

    {% endif %}

    {% cut "Параметры ответа" %}

    Параметр | Описание | Тип данных
    -------- | -------- | ----------
    self | Адрес ресурса API, который содержит информацию об учетной записи пользователя. | Строка
    uid | Уникальный идентификатор учетной записи пользователя. | Число
    login | Логин пользователя. | Строка
    trackerUid | Уникальный идентификатор аккаунта пользователя в {{ tracker-name }}. | Число
    passportUid | Уникальный идентификатор аккаунта пользователя на Яндексе. | Число
    firstName | Имя пользователя. | Строка
    lastName | Фамилия пользователя. | Строка
    display | Отображаемое имя пользователя. | Строка
    email | Электронная почта пользователя. | Строка
    {% if audience == "internal" %}[office](#office)| Объект с информацией об офисе, в котором числится сотрудник. | Объект{% endif %}
    external | Служебный параметр. | Логический
    hasLicense | Признак наличия у пользователя полного доступа к {{ tracker-name }}:<ul><li>`true` — полный доступ;</li><li>`false` — только чтение.</li></ul> | Логический
    dismissed | Статус пользователя в организации:<ul><li>`true` — пользователь удален из организации;</li><li>`false` — действующий сотрудник организации.</li></ul> | Логический
    useNewFilters | Служебный параметр. | Логический
    disableNotifications | Признак принудительного отключения уведомлений для пользователя:<ul><li>`true` — уведомления отключены;</li><li>`false` — уведомления включены.</li></ul> | Логический
    firstLoginDate | Дата и время первой авторизации пользователя в формате `YYYY-MM-DDThh:mm:ss.sss±hhmm`. | Строка
    lastLoginDate | Дата и время последней авторизации пользователя в формате `YYYY-MM-DDThh:mm:ss.sss±hhmm`. | Строка
    {% if audience == "external" %}welcomeMailSent | Способ добавления пользователя: <ul><li>`true` — с помощью приглашения на почту;</li><li>`false` — другим способом.</li></ul>. | Логический{% endif %}
    {% if audience == "internal" %}activeExperiments| Список экспериментов, в которых пользователь принимает участие. | Массив элементов

    **Поля объекта** `office` {#office}

    Параметр | Описание | Тип данных
    -------- | -------- | ----------
    self | Адрес ресурса API, который содержит информацию об офисе. | Строка
    id | Идентификатор офиса. | Строка
    display | Отображаемое имя офиса. | Строка

    {% endif %}
    
    {% endcut %}
    
- Запрос выполнен с ошибкой

    {% include [answer-error-401](../_includes/tracker/api/answer-error-401.md) %}

    {% include [answer-error-403](../_includes/tracker/api/answer-error-403.md) %}

    {% include [answer-error-404](../_includes/tracker/api/answer-error-404.md) %}

{% endlist %}