---
sourcePath: ru/tracker/api-ref/concepts/dashboards/create-dashboard.md
---
# Создать дашборд

Запрос позволяет создать дашборд. Чтобы добавить виджет «Время цикла», используйте запрос [{#T}](./create-widget.md).

## Формат запроса {#query}

Перед выполнением запроса [получите доступ к API](../access.md).

Чтобы создать дашборд, используйте HTTP-запрос с методом `POST`. Параметры запроса передаются в его теле в формате JSON.

```
POST /{{ ver }}/dashboards/
Host: {{ host }}
Authorization: OAuth <OAuth-токен>
{{ org-id }}

{
    "name": "<название_дашборда>",
    "layout": "<режим_отображения_виджетов>>",
    "owner": {
       "id": "<логин_или_идентификатор_пользователя>"
       }
}
```

{% include [headings](../../../_includes/tracker/api/headings.md) %}

{% cut "Параметры тела запроса" %}

Тело запроса содержит параметры дашборда.

**Обязательные параметры**

Параметр | Описание | Тип данных
-------- | -------- | ----------
name | Название дашборда. | Строка

**Дополнительные параметры**

Параметр | Описание | Тип данных
-------- | -------- | ----------
layout | Режим отображения виджетов на дашборде.<br/>Возможные режимы:<ul><li>`one-column` — одна колонка — режим по умолчанию;</li><li>`two-columns`— две колонки;</li><li>`three-columns`— три колонки;</li><li>`narrow-left-wide-right` — узкая колонка слева и широкая справа;</li><li>`one-top-two-bottom`— одна колонка сверху и две снизу.</li></ul> | Строка
owner | Логин или идентификатор владельца дашборда. Если параметр не указан, владельцем становится создатель дашборда. | Строка

{% endcut %}

## Формат ответа {#answer}

{% list tabs %}

- Запрос выполнен успешно

    {% include [answer-201](../../../_includes/tracker/api/answer-201.md) %}

    Тело ответа содержит JSON-объект с параметрами нового дашборда.

    ```json
    {
       "id": 10,
       "version": 1,
       "name": "New Dashboard",
       "createdBy": {
          "self": "https://{{ host }}/v2/users/44********",
          "id": "44********",
          "display": "Иван Иванов",
          "passportUid": 12********
       },
       "createdAt": "2024-04-15T19:38:42.074+0000",
       "layout": "one-column",
       "owner": {
          "self": "https://{{ host }}t/v2/users/44********",
          "id": "44********",
          "display": "Иван Иванов",
          "passportUid": 12********
       },
       "self": "https://{{ host }}/v2/dashboards/10"
    }
    ```

    {% cut "Параметры ответа" %}

    Параметр | Описание | Тип данных
    -------- | -------- | ----------
    id | Идентификатор дашборда. | Число
    version | Версия дашборда. Каждое изменение дашборда увеличивает номер версии. | Число
    name | Название дашборда. | Строка
    [createdBy](#user) | Объект с информацией о создателе дашборда. | Объект
    createdAt | Дата и время создания дашборда в формате: ```YYYY-MM-DDThh:mm:ss.sss±hhmm```. | Строка
    layout | Режим отображения виджетов на дашборде. | Строка
    [owner](#user) | Объект с информацией о владельце дашборда. | Объект
    self | Адрес ресурса API, который содержит параметры дашборда. | Строка
   
    **Поля объекта** `createdBy` и `owner` {#user}

    {% include [user](../../../_includes/tracker/api/user.md) %}

    {% endcut %}

- Запрос выполнен с ошибкой

    Если запрос не был успешно обработан, API возвращает ответ с кодом ошибки:

    {% include [answer-error-400](../../../_includes/tracker/api/answer-error-400.md) %}

    {% include [answer-error-403](../../../_includes/tracker/api/answer-error-403.md) %}

    {% include [answer-error-404](../../../_includes/tracker/api/answer-error-404.md) %}

    {% include [answer-error-422](../../../_includes/tracker/api/answer-error-422.md) %}

    {% include [answer-error-500](../../../_includes/tracker/api/answer-error-500.md) %}

    {% include [answer-error-503](../../../_includes/tracker/api/answer-error-503.md) %}

{% endlist %}
