---
sourcePath: ru/tracker/api-ref/patch-column.md
---
# Редактировать колонку

Запрос позволяет изменить параметры колонки.

## Формат запроса {#query}

Перед выполнением запроса [получите доступ к API](concepts/access.md).

Чтобы изменить параметры колонки, используйте HTTP-запрос с методом `PATCH`. Параметры запроса передаются в его теле в формате JSON.

```
PATCH /{{ ver }}/boards/<board-id>/columns/<column-id>
Host: {{ host }}
Authorization: OAuth <токен>
{{ org-id }}
If-Match: "<номер версии>"

<новые параметры колонки в формате JSON>
```

{% cut "Заголовки" %}

- **Host**
    
    Адрес узла, предоставляющего API:

    ```
    {{ host }}
    ```

- **Authorization**

    OAuth-токен в формате `OAuth <значение токена>`, например:

    ```
    OAuth 0c4181a7c2cf4521964a72ff57a34a07
    ```


- **X-Org-ID** или **X-Cloud-Org-ID**

    Идентификатор организации. Если у вас только организация {{ org-full-name }}, используйте заголовок `X-Cloud-Org-ID`, если только {{ ya-360 }} или оба типа организаций — `X-Org-ID`.


- **If-Match**

    Номер текущей версии доски. При указании неактуальной версии доски в ответ на HTTP-запрос придет ответ с ошибкой `412 Precondition Failed`.

{% endcut %}

{% cut "Ресурс" %}

Параметр | Описание | Тип данных
----- | ----- | -----
\<board-id\> | Идентификатор доски | Число
\<column-id\> | Идентификатор колонки | Число

{% endcut %}

{% cut "Параметры тела запроса" %}

Тело запроса содержит параметры колонки, которые нужно изменить.

**Дополнительные параметры**

Параметр | Описание | Тип данных
-------- | -------- | ----------
name | Название колонки. | Строка
statuses | Массив содержит ключи возможных статусов задач, которые попадут в колонку.<br/>Список всех статусов задачи: [{{ link-tracker-statuses }}]({{ link-tracker-statuses }}) | Массив

{% endcut %}

> Пример: Изменить параметры колонки с идентификатором `1` на доске с идентификатором `5`.
>
> - Используется HTTP-метод `POST`.
>
> ```
> PATCH /v2/boards/5/columns/1
> Host: {{ host }}
> Authorization: OAuth <токен>
> X-Org-ID или X-Cloud-Org-ID: <идентификатор организации>
> If-Match: "<номер версии>"
>
> {
>   "name": "Согласовать",
>   "statuses":
>       [
>         "needInfo", "needAcceptance"
>       ]
> }
> ```
> {% note info %}
>
> Если у вас только организация {{ org-full-name }}, используйте заголовок `X-Cloud-Org-ID`, если только {{ ya-360 }} или оба типа организаций — `X-Org-ID`.
>
> {% endnote %}

## Формат ответа {#answer}

{% list tabs %}

- Запрос выполнен успешно

    {% include [answer-200](../_includes/tracker/api/answer-200.md) %}

    Тело ответа содержит JSON-объект со всеми параметрами колонки, включая измененные.

    ```json
    {
        "self": "https://{{ host }}/v2/boards/73/columns/5",
        "id": 5,
        "name": "Согласовать",
        "statuses":
         [
            {
               "self": "https://{{ host }}/v2/statuses/2",
               "id": "2",
               "key": "needInfo",
               "display": "Требуется информация"
            },
             ...
          ]
    }
    ```

    {% cut "Параметры ответа" %}

    Параметр | Описание | Тип данных
    -------- | -------- | ----------
    self | Адрес ресурса API, который содержит информацию о колонке доски | Строка
    id | Идентификатор колонки | Число
    name | Название колонки | Строка
    [statuses](#statuses) | Массив содержит информацию о статусах задач, которые находятся в колонке | Массив

    **Поля объекта** `statuses` {#statuses}

    {% include [status](../_includes/tracker/api/status.md) %}

    {% endcut %}

- Запрос выполнен с ошибкой

    Если запрос не был успешно обработан, API возвращает ответ с кодом ошибки:

    {% include [answer-error-400](../_includes/tracker/api/answer-error-400.md) %}

    {% include [answer-error-403](../_includes/tracker/api/answer-error-403.md) %}

    {% include [answer-error-404](../_includes/tracker/api/answer-error-404.md) %}

    {% include [answer-error-412](../_includes/tracker/api/answer-error-412.md) %}

    {% include [answer-error-422](../_includes/tracker/api/answer-error-422.md) %}

    {% include [answer-error-428](../_includes/tracker/api/answer-error-428.md) %}

    {% include [answer-error-500](../_includes/tracker/api/answer-error-500.md) %}

    {% include [answer-error-503](../_includes/tracker/api/answer-error-503.md) %}

{% endlist %}
