---
title: "Как получить параметры поля задачи с помощью {{ tracker-full-name }} API"
description: "Из статьи вы узнаете, как получить параметры поля задачи в {{ tracker-name }}."
sourcePath: ru/tracker/api-ref/concepts/issues/get-issue-fields.md
---

# Получить параметры поля задачи

## Формат запроса {#section_nrf_1vp_4gb}

Чтобы получить возможные значения поля задачи, используйте HTTP-запрос с методом `GET`:

```json
GET /{{ ver }}/fields/<идентификатор_поля>
Host: {{ host }}
Authorization: OAuth <OAuth-токен> 
{{ org-id }}
```

{% include [headings](../../../_includes/tracker/api/headings.md) %}

{% cut "Ресурс" %}

Параметр | Описание | Тип данных
--- | --- | ---
\<идентификатор_поля\> | Идентификатор поля задачи. | Строка

{% endcut %}

## Формат ответа {#section_qqm_y1q_4gb}

{% list tabs %}

- Запрос выполнен успешно

    {% include [answer-200](../../../_includes/tracker/api/answer-200.md) %} 
 
    Тело ответа содержит JSON-объект со всеми параметрами поля задачи.

    ```json
    {
        "self": "https://{{ host }}/v2/fields/ruName",
        "id": "ruName",
        "name": "ru_name",
        "description": "текст описания",
        "version": 3,
        "schema": {
            "type": "array",
            "items": "string",
            "required": false
        },
        "readonly": false,
        "options": true,
        "suggest": true,
        "suggestProvider": {
            "type": "UserSuggestProvider"
        },
        "optionsProvider": {
            "type": "FixedListOptionsProvider",
            "values": [
                "значение 1",
                "значение 2"
            ]
        },
        "queryProvider": {
            "type": "StringOptionalQueryProvider"
        },
        "order": 14,
        "category": {
            "self": "https://{{ host }}/v2/fields/categories/58bc3b921d9c********",
            "id": "58bc3b921d9c********",
            "display": "Системные"
        }
    }
    ```

    {% cut "Параметры ответа" %}

    Параметр | Описание | Тип данных
    -------- | -------- | ----------
    self | Адрес ресурса API, который содержит информацию о поле задачи. | Строка
    id | Идентификатор поля. | Строка
    name | Название поля. | Строка
    description | Описание поля. | Строка
    version | Версия поля. Каждое изменение поля увеличивает номер версии. | Число
    [schema](#schema) | Объект с информацией о типе данных значения поля. | Объект
    readonly | Возможность редактировать значение поля:<ul><li>`true` — значение поля нельзя изменить;</li><li>`false` — значение поля можно изменить.</li></ul> | Логический
    options | Ограничение списка значений:<ul><li>`true` — список значений не ограничен, можно задать любое значение;</li><li>`false` — список значений ограничен настройками организации.</li></ul> | Логический
    suggest | Наличие подсказки при вводе значения поля:<ul><li>`true` — при вводе значения появляется поисковая подсказка;</li><li>`false` — функция поисковой подсказки отключена.</li></ul> | Логический
    [suggestProvider](#suggestProvider) | Объект с информацией о классе поисковой подсказки.<br/>Класс подсказки невозможно изменить с помощью API. | Объект
    [optionsProvider](#optionsProvider) | Объект с информацией о допустимых значениях поля. | Объект
    [queryProvider](#queryProvider) | Объект с информацией о классе языка запроса.<br/>Класс невозможно изменить с помощью API. | Объект
    order | Порядковый номер в списке полей организации: [{{ link-admin-fields }}]({{ link-admin-fields }}) | Число
    [category](#category) | Объект с информацией о категории поля.<br/>Чтобы получить список всех категорий, используйте HTTP запрос:<br/>`GET /v2/fields/categories` | Объект

    **Поля объекта** `schema` {#schema}

    Параметр | Описание | Тип данных
    -------- | -------- | ----------
    type | Тип значения поля. Возможные типы данных:<ul><li>`string` — строка. Присутствует у полей с единственным значением.</li><li>`array` — массив. Присутствует у полей с несколькими значениями.</li></ul> | Строка
    items | Тип значений. Присутствует у полей с несколькими значениями. | Строка
    required | Обязательность заполнения поля:<ul><li>`true` — поле обязательно для заполнения;</li><li>`false` — поле не обязательно для заполнения.</li></ul> | Логический

    **Поля объекта** `suggestProvider` {#suggestProvider}

    Параметр | Описание | Тип данных
    -------- | -------- | ----------
    type | Класс поисковой подсказки. | Строка

    **Поля объекта** `optionsProvider` {#optionsProvider}

    Параметр | Описание | Тип данных
    -------- | -------- | ----------
    type | Тип значений поля. | Строка
    values | Массив со значениями поля. | Массив

    **Поля объекта** `queryProvider` {#queryProvider}

    Параметр | Описание | Тип данных
    -------- | -------- | ----------
    type | Тип языка запроса. | Строка

    **Поля объекта** `category` {#category}

    Параметр | Описание | Тип данных
    -------- | -------- | ----------
    self | Адрес ресурса API, который содержит информацию о категории поля. | Строка
    id | Идентификатор категории поля. | Строка
    display | Отображаемое название категории. | Строка

    {% endcut %}

- Запрос выполнен с ошибкой

    Если запрос не был успешно обработан, ответное сообщение содержит информацию о возникших ошибках:

    {% include [error](../../../_includes/tracker/api/answer-error-400.md) %}

    {% include [error](../../../_includes/tracker/api/answer-error-403.md) %}

    {% include [error](../../../_includes/tracker/api/answer-error-404.md) %}

    {% include [error](../../../_includes/tracker/api/answer-error-500.md) %}

    {% include [error](../../../_includes/tracker/api/answer-error-503.md) %}

{% endlist %}
