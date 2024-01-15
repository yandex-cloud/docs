---
sourcePath: ru/tracker/api-ref/concepts/issues/get-transitions.md
---
# Получить переходы

Запрос позволяет получить список возможных переходов задачи. Задача выбирается при указании идентификатора или ключа задачи.

## Формат запроса {#section_rnm_x4j_p1b}

Перед выполнением запроса [получите доступ к API](../access.md).

Для получения списка возможных переходов используйте HTTP-запрос с методом `GET`:

```json
GET /v2/issues/<issue-id>/transitions
Host: {{ host }}
Authorization: OAuth <OAuth-токен>
{{ org-id }}
```

{% include [headings](../../../_includes/tracker/api/headings.md) %}

{% include [resource-issue-id](../../../_includes/tracker/api/resource-issue-id.md) %} 

## Формат ответа {#section_xc3_53j_p1b}

{% list tabs %}

- Запрос выполнен успешно

    {% include [answer-200](../../../_includes/tracker/api/answer-200.md) %}

    Тело ответа содержит результаты в формате JSON.

    ```json
    [
        {
            "id": "resolve",
            "self": "https://{{ host }}/v2/issues/JUNE-2/transitions/resolve",
            "display": "Решить",
            "to": {
                "self": "https://{{ host }}/v2/statuses/1",
                "id": "1",
                "key": "open",
                "display": "Открыт"
            }
        },
        ...
    ]
    ```

  {% cut "Параметры ответа" %}

    Параметр | Описание | Тип данных
    ----- | ----- | -----
    id | Идентификатор перехода. | Строка
    self |  Адрес ресурса API, который содержит информацию о переходе. | Строка
    display | Отображаемое имя перехода. Соответствует названию кнопки в интерфейсе {{ tracker-name }}. | Строка
    [to](#to) | Объект с информацией о новом статусе задачи. | Объект
    	
    **Поля объекта** `to` {#to}

    {% include [status](../../../_includes/tracker/api/status.md) %}
  
  {% endcut %}

- Запрос выполнен с ошибкой

    {% include [answer-error-404](../../../_includes/tracker/api/answer-error-404.md) %}

{% endlist %}
