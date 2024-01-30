---
sourcePath: ru/tracker/api-ref/concepts/issues/get-checklist.md
---
# Получить параметры чеклиста

Запрос позволяет получить параметры [чеклиста](../../user/checklist.md) в задаче.

## Формат запроса {#query}

Перед выполнением запроса [получите доступ к API](../access.md).

Чтобы получить параметры чеклиста, используйте HTTP-запрос с методом `GET`:

```json
GET /{{ ver }}/issues/<ключ_или_идентификатор_задачи>/checklistItems
Host: {{ host }}
Authorization: OAuth <OAuth-токен>
{{ org-id }}
```

{% include [headings](../../../_includes/tracker/api/headings.md) %}

{% cut "Ресурс" %}

Параметр | Описание | Тип данных
--- | --- | ---
\<ключ_или_идентификатор_задачи\> | Идентификатор или ключ задачи | Строка

{% endcut %}

## Формат ответа {#answer}

{% list tabs %}

- Запрос выполнен успешно

    {% include [answer-200](../../../_includes/tracker/api/answer-200.md) %}

    Тело ответа содержит информацию о пунктах чеклиста в формате JSON.
    ```json
    {
        "id": "5fde5f0a1aee261d********",
        "text": "пункт чеклиста",
        "textHtml": "текст пункта в формате HTML",
        "checked": false,
        "assignee": {
            "id": 11********,
            "display": "Имя Фамилия",
            "passportUid": 11********,
            "login": "user_login",
            "firstName": "Имя",
            "lastName": "Фамилия",
            "email": "user_login@example.com",
            "trackerUid": 11********
        },
        "deadline": {
            "date": "2021-05-09T00:00:00.000+0000",
            "deadlineType": "date",
            "isExceeded": false
        },
        "checklistItemType": "standard"
    }
    ```

    {% cut "Параметры ответа" %}
    
    Параметр | Описание | Тип данных
    -------- | -------- | ----------
    id | Идентификатор пункта чеклиста. | Строка
    text | Текст пункта чеклиста. | Строка
    textHtml | Текст пункта чеклиста в формате HTML. | Строка
    checked | Признак выполнения пункта чеклиста:<ul><li>`true` — пункт отмечен как выполненный;</li><li>`false` — пункт не отмечен как выполненный.</li></ul> | Логический
    [assignee](#assignee) | Исполнитель пункта чеклиста. | Объект
    [deadline](#deadline) | Крайний срок исполнения пункта чеклиста. | Объект
    checklistItemType | Тип пункта чеклиста. | Строка


    **Поля объекта** `assignee` {#assignee}
    
    Параметр | Описание | Тип данных
    ----- | ----- | -----
    id | Идентификатор пользователя. | Число
    display | Отображаемое имя пользователя. | Строка
    passportUid | Уникальный идентификатор аккаунта пользователя на Яндексе. | Число
    login | Логин пользователя. | Строка
    firstName | Имя пользователя. | Строка
    lastName | Фамилия пользователя. | Строка
    email | Адрес пользователя. | Строка
    trackerUid | Уникальный идентификатор аккаунта пользователя в {{ tracker-name }}. | Число


    **Поля объекта** `deadline` {#deadline}
    
    Параметр | Описание | Тип данных
    ----- | ----- | -----
    date | Предельный срок в формате `YYYY-MM-DDThh:mm:ss.sss±hhmm`. | Дата
    deadlineType | Тип данных параметра `deadline`. | Строка
    isExceeded | Признак наступления дедлайна: <ul><li>`true` — предельный срок наступил;</li><li>`false` — предельный срок не наступил.</li></ul> | Логический
    
    {% endcut %}
    
- Запрос выполнен с ошибкой

    Если запрос не был успешно обработан, API возвращает ответ с кодом ошибки:
    
    {% include [error-400](../../../_includes/tracker/api/answer-error-400.md) %}

    {% include [error-401](../../../_includes/tracker/api/answer-error-401.md) %}
    
    {% include [error-403](../../../_includes/tracker/api/answer-error-403.md) %}
    
    {% include [error-404](../../../_includes/tracker/api/answer-error-404.md) %}

{% endlist %}