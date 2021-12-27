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

## Формат ответа {#answer}

{% list tabs %}

- Запрос выполнен успешно

    {% include [answer-200](../_includes/tracker/api/answer-200.md) %}
   
    Тело ответа содержит JSON-массив с параметрами текущего пользователя.

    
      ```json
         [
            {
            "self": "{{ host }}/v2/users/1234567890",
            "uid": 1234567890,
            "login": "<user_login>",
            "trackerUid": 1234567890>,
            "passportUid": 1234567890,
            "firstName": "<Имя>",
            "lastName": "<Фамилия>",
            "display": "<Имя Фамилия>",
            "email": "<login@yandex.ru>",
            "external": false,
            "hasLicense": true,
            "dismissed": false,
            "useNewFilters": true,
            "disableNotifications": false
            }
         ]
      ```

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
    external | Служебный параметр. | Логический
    hasLicense | Признак наличия у пользователя полного доступа к {{ tracker-name }}:<ul><li>`true` — полный доступ;</li><li>`false` — только чтение.</li></ul> | Логический
    dismissed | Статус пользователя в организации:<ul><li>`true` — пользователь удален из организации;</li><li>`false` — действующий сотрудник организации.</li></ul> | Логический
    useNewFilters | Служебный параметр. | Логический
    disableNotifications | Признак принудительного отключения уведомлений для пользователя:<ul><li>`true` — уведомления отключены;</li><li>`false` — уведомления включены.</li></ul> | Логический
    
    {% endcut %}
    
- Запрос выполнен с ошибкой

    {% include [answer-error-401](../_includes/tracker/api/answer-error-401.md) %}

    {% include [answer-error-403](../_includes/tracker/api/answer-error-403.md) %}

    {% include [answer-error-404](../_includes/tracker/api/answer-error-404.md) %}

{% endlist %}