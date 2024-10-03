---
sourcePath: ru/tracker/api-ref/get-user-info.md
---
# Получить информацию о текущем пользователе

Запрос позволяет получить информацию об учетной записи пользователя, от имени которого выполняется обращение к API.

## Формат запроса {#query}

Перед выполнением запроса [получите доступ к API](concepts/access.md).

Для получения информации о текущем пользователе используйте HTTP-запрос с методом `GET`:

```json
GET /v2/myself
Host: {{ host }}
Authorization: OAuth <OAuth-токен>
{{ org-id }}
```

{% include [headings](../_includes/tracker/api/headings.md) %}

Например, с помощью `curl`:

```bash
curl --request GET "{{ host }}/v2/myself" \
     --header "Authorization: OAuth <OAuth-токен>" \
     --header "X-Cloud-Org-Id: <идентификатор_организации>"
```

## Формат ответа {#answer}

{% list tabs %}

- Запрос выполнен успешно

    {% include [answer-200](../_includes/tracker/api/answer-200.md) %}
   
    Тело ответа содержит JSON-массив с параметрами текущего пользователя.


    ```json
       [
          {
          "self": "https://{{ host }}/v2/users/12********",
          "uid": 12********,
          "login": "<логин_пользователя>",
          "trackerUid": 12********,
          "passportUid": 12********,
          "cloudUid": "bfbdrb1aa248********",
          "firstName": "<имя>",
          "lastName": "<фамилия>",
          "display": "<отображаемое_имя>",
          "email": "<электронная_почта>",
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


    {% cut "Параметры ответа" %}

    {% include [new-default-id-type](../_includes/tracker/api/new-default-id-type.md) %}

    Параметр | Описание | Тип данных
    -------- | -------- | ----------
    self | Адрес ресурса API, который содержит информацию об учетной записи пользователя. | Строка
    uid | Уникальный идентификатор учетной записи пользователя в {{ tracker-name }}. | Число
    login | Логин пользователя. | Строка
    trackerUid | Уникальный идентификатор аккаунта пользователя в {{ tracker-name }}. | Число
    passportUid | Уникальный идентификатор аккаунта пользователя в организации {{ ya-360 }} и Яндекс ID. | Число
    cloudUid | Уникальный идентификатор пользователя в {{ org-full-name }}. | Строка
    firstName | Имя пользователя. | Строка
    lastName | Фамилия пользователя. | Строка
    display | Отображаемое имя пользователя. | Строка
    email | Электронная почта пользователя. | Строка    
    external | Служебный параметр. | Логический
    hasLicense | Признак наличия у пользователя полного доступа к {{ tracker-name }}:<ul><li>`true` — полный доступ;</li><li>`false` — только чтение.</li></ul> | Логический
    dismissed | Статус пользователя в организации:<ul><li>`true` — пользователь удален из организации;</li><li>`false` — действующий сотрудник организации.</li></ul> | Логический
    useNewFilters | Служебный параметр. | Логический
    disableNotifications | Признак принудительного отключения уведомлений для пользователя:<ul><li>`true` — уведомления отключены;</li><li>`false` — уведомления включены.</li></ul> | Логический
    firstLoginDate | Дата и время первой авторизации пользователя в формате `YYYY-MM-DDThh:mm:ss.sss±hhmm`. | Строка
    lastLoginDate | Дата и время последней авторизации пользователя в формате `YYYY-MM-DDThh:mm:ss.sss±hhmm`. | Строка
    welcomeMailSent | Способ добавления пользователя: <ul><li>`true` — с помощью приглашения на почту;</li><li>`false` — другим способом.</li></ul>. | Логический    
    
    {% endcut %}
    
- Запрос выполнен с ошибкой

    {% include [answer-error-401](../_includes/tracker/api/answer-error-401.md) %}

    {% include [answer-error-403](../_includes/tracker/api/answer-error-403.md) %}

    {% include [answer-error-404](../_includes/tracker/api/answer-error-404.md) %}

{% endlist %}