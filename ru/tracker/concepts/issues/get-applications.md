---
sourcePath: ru/tracker/api-ref/concepts/issues/get-applications.md
---
# Получить список внешних приложений

Запрос позволяет получить список внешних приложений, с которыми можно [создать связь](../../external-links.md).

## Формат запроса {#query}

Чтобы получить список доступных внешних приложений, используйте HTTP-запрос с методом `GET`:

```json
GET /{{ ver }}/applications
Host: {{ host }}
Authorization: OAuth <OAuth-токен>
{{ org-id }}
```

{% include [headings](../../../_includes/tracker/api/headings.md) %}


## Формат ответа {#answer}

{% list tabs %}

- Запрос выполнен успешно

    {% include [200](../../../_includes/tracker/api/answer-200.md) %}

    Тело ответа содержит информацию о внешних приложениях в формате JSON.

    ```json
    [
        {
            "self": "https://{{ host }}/{{ ver }}/applications/my-application",
            "id": "my-application",
            "type": "my-application",
            "name": "Имя Приложения"
        },
        ...
    ]
    ```

    {% cut "Параметры ответа" %}

    Параметр | Описание | Тип данных
    ----- | ----- | -----
    self | Адрес ресурса API, который содержит информацию о приложении. | Строка
    id | Идентификатор приложения. | Строка
    type | Тип приложения. Значение совпадает со значением параметра `id`.| Строка
    name | Имя приложения. | Строка

    {% endcut %}

- Запрос выполнен с ошибкой

    {% include [400](../../../_includes/tracker/api/answer-error-400.md) %}

    {% include [401](../../../_includes/tracker/api/answer-error-401.md) %}

    {% include [500](../../../_includes/tracker/api/answer-error-500.md) %}

    {% include [500](../../../_includes/tracker/api/answer-error-503.md) %}

{% endlist %}