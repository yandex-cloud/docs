---
title: "Как получить глобальные поля с помощью {{ tracker-full-name }} API"
description: "Из статьи вы узнаете, как получить глобальные поля в {{ tracker-name }}."
sourcePath: ru/tracker/api-ref/concepts/issues/get-global-fields.md
---

# Получить глобальные поля

## Формат запроса {#query}

Чтобы получить все глобальные поля организации, используйте HTTP-запрос с методом `GET`:

```json
GET /{{ ver }}/fields
Host: {{ host }}
Authorization: OAuth <токен> 
{{ org-id }}
```

{% include [headings](../../../_includes/tracker/api/headings.md) %}

## Формат ответа {#answer}

{% list tabs %}

- Запрос выполнен успешно

    {% include [answer-200](../../../_includes/tracker/api/answer-200.md) %} 
 
    Тело ответа содержит информацию о всех глобальных полях организации в формате JSON.

    ```json
    {
        "self": "https://{{ host }}/v2/fields/standard_field_key",
        "id": "standard_field_key",
        "name": "standard_field_name",
        "key": "standard_field_key",
        "version": 0,
        "schema": {
            "type": "string",
            "required": true
        },
        "readonly": true,
        "options": true,
        "suggest": true,
        "suggestProvider": {
            "type": "QueueSuggestProvider"
        },
        "optionsProvider": {
            "type": "QueueOptionsProvider"
        },
        "queryProvider": {
            "type": "QueueQueryProvider"
        },
        "order": 1,
        "category": {
            "self": "https://{{ host }}/v2/fields/categories/000000000000000000000001",
            "id": "000000000000000000000001",
            "display": "Системные"
        },
        "type": "standard"
    },
    ...
    ```

    {% cut "Параметры ответа" %}

    Параметр | Описание | Тип данных
    -------- | -------- | ----------
    self | Адрес ресурса API, который содержит информацию о поле. | Строка
    id | Идентификатор поля. | Строка
    name | Название поля. | Строка
    key | Ключ поля. | Строка
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
    type | Тип поля. | Строка

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
