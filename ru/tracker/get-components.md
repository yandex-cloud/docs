---
sourcePath: ru/tracker/api-ref/get-components.md
---
# Получить список компонентов

Запрос позволяет получить список всех [компонентов](manager/components.md), созданных пользователями организации.

## Формат запроса {#query}

Перед выполнением запроса [получите доступ к API](concepts/access.md).

Чтобы получить все компоненты, используйте HTTP-запрос с методом `GET`.

```http
GET /v2/components
Host: {{ host }}
Authorization: OAuth <OAuth-токен>
{{ org-id }}
```

{% include [headings](../_includes/tracker/api/headings.md) %}

## Формат ответа {#answer}

{% list tabs %}

- Запрос выполнен успешно

    {% include [answer-200](../_includes/tracker/api/answer-200.md) %} 

    Тело ответа содержит JSON-массив с параметрами всех компонентов, созданных пользователями организации.

    ```json
    [
      {
        "self": "https://{{ host }}/v2/components/1",
        "id": 1,
        "version": 3,
        "name": "Test",
        "queue": {
            "self": "https://{{ host }}/v2/queues/ORG",
            "id": "1",
            "key": "ORG",
            "display": "Организация"
        },
        "description": "<описание_компонента>",
        "lead": {
               "self": "https://{{ host }}/v2/users/11********",
               "id": "11********",
               "display": "Иван Иванов"
            },
        "assignAuto": false
      },
    ...
    ]  
    ```

    {% cut "Параметры ответа" %}

    Параметр | Описание | Тип данных
    ----- | ----- | -----
    self | Ссылка на компонент. | Строка
    id | Идентификатор компонента. | Число
    version | Версия компонента. Каждое изменение компонента увеличивает номер версии. | Число
    name | Название компонента. | Строка
    [queue](#queue) | Объект с информацией об очереди компонента.| Объект
    description | Текстовое описание компонента. | Строка
    [lead](#lead) | Блок с информацией о владельце компонента. | Объект
    assignAuto | Автоматически назначить владельца компонента исполнителем для новых задач с этим компонентом:<ul><li>`true`— назначить;</li><li>`false`— не назначать.</li></ul> | Логический

    **Поля объекта** `queue` {#queue}
        
    {% include [queue](../_includes/tracker/api/queue.md) %}

    **Поля объекта** `lead` {#lead}

    {% include [user](../_includes/tracker/api/user.md) %}

    {% endcut %}

- Запрос выполнен с ошибкой

    Если запрос не был успешно обработан, API возвращает ответ с кодом ошибки:

    {% include [error](../_includes/tracker/api/answer-error-400.md) %}

    {% include [error](../_includes/tracker/api/answer-error-401.md) %}

    {% include [error](../_includes/tracker/api/answer-error-403.md) %}

    {% include [error](../_includes/tracker/api/answer-error-500.md) %}

    {% include [error](../_includes/tracker/api/answer-error-503.md) %}

{% endlist %}