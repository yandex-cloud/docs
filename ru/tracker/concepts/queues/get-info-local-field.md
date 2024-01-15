---
sourcePath: ru/tracker/api-ref/concepts/queues/get-info-local-field.md
---
# Получить информацию о локальном поле очереди

Запрос позволяет получить информацию о [локальном поле](../../local-fields.md) задачи, привязанном к заданной очереди.

## Формат запроса {#query}

Перед выполнением запроса [получите доступ к API](../access.md).

Чтобы получить информацию о локальном поле очереди, используйте HTTP-запрос с методом `GET`:

```json
GET /{{ ver }}/queues/<queue-id>/localFields/<field-key>
Host: {{ host }}
Authorization: OAuth <OAuth-токен>
{{ org-id }}
```

{% include [headings](../../../_includes/tracker/api/headings.md) %}

{% cut "Ресурс" %}

Параметр | Описание | Тип данных
-------- | -------- | ----------
\<queue-id\> | Идентификатор или ключ очереди. Ключ очереди чувствителен к регистру символов. | Строка
\<field-key> | Ключ локального поля. <br/>Чтобы получить ключ, используйте HTTP [запрос](get-local-fields.md):<br/>`GET /v2/queues/<queue-id>/localFields`| Строка

{% endcut %}

## Формат ответа {#answer}

{% list tabs %}

- Запрос выполнен успешно

    {% include [answer-200](../../../_includes/tracker/api/answer-200.md) %} 

    Тело ответа содержит информацию о локальном поле очереди в формате JSON.

    ```json
     {
        "type": "local",
        "self": "https://{{ host }}/v2/queues/ORG/localFields/loc_field_key",
        "id": "6054ae3a2b6b2c7f80bb9a93--loc_field_key",
        "name": "loc_field_name",
        "description": "описание локального поля",
        "key": "loc_field_key",
        "version": 1,
        "schema": {
            "type": "string",
            "required": false
        },
        "readonly": true,
        "options": true,
        "suggest": false,
        "optionsProvider": {
           "type": "FixedListOptionsProvider",
           "needValidation": true,
           "values": [
              "Первый элемент списка",
              "Второй элемент списка",
              "Третий элемент списка"
             ]
          },
        "queryProvider": {
            "type": "StringOptionalQueryProvider"
        },
        "order": 3,
        "category": {
            "self": "https://{{ host }}/v2/fields/categories/000000000000000000000001",
            "id": "000000000000000000000001",
            "display": "Системные"
        },
        "queue": {
            "self": "https://{{ host }}/v2/queues/ORG",
            "id": "1",
            "key": "ORG",
            "display": "Организация"
        }

     }
    ```

    {% cut "Параметры ответа" %}

    Параметр | Описание | Тип данных
    ----- | ----- | -----
    type | Тип поля. | Строка
    self | Адрес ресурса API, который содержит информацию о поле. | Строка
    id | Уникальный идентификатор поля. | Строка
    name | Название поля. | Строка
    description | Описание поля. | Строка
    key | Ключ поля. | Строка
    version | Версия поля. Каждое изменение поля увеличивает номер версии. | Число
    [schema](#schema) | Объект с информацией о типе данных значения поля. | Объект
    readonly | Возможность редактировать значение поля:<ul><li>`true` — значение поля нельзя изменить;</li><li>`false` — значение поля можно изменить.</li></ul> | Логический
    options | Ограничение списка значений:<ul><li>`true` — список значений не ограничен, можно задать любое значение;</li><li>`false` — список значений ограничен настройками организации.</li></ul> | Логический
    suggest | Наличие подсказки при вводе значения поля:<ul><li>`true` — при вводе значения появляется поисковая подсказка;</li><li>`false` — функция поисковой подсказки отключена.</li></ul> | Логический
    [optionsProvider](#optionsProvider) | Объект с информацией о допустимых значениях поля. | Объект
    [queryProvider](#queryProvider) | Объект с информацией о классе языка запроса.<br/>Класс невозможно изменить с помощью API. | Объект
    order | Порядковый номер в списке полей организации: [{{ link-admin-fields }}]({{ link-admin-fields }}) | Число
    [category](#category) | Объект с информацией о категории поля.<br/>Чтобы получить список всех категорий, используйте HTTP запрос:<br/>`GET /v2/fields/categories` | Объект
    [queue](#queue) | Объект с информацией об очереди задачи.| Объект


    **Поля объекта** `schema` {#schema}
    
    Параметр | Описание | Тип данных
    -------- | -------- | ----------
    type | Тип значения поля. Возможные типы данных:<ul><li>`string` — строка. Присутствует у полей с единственным значением.</li><li>`array` — массив. Присутствует у полей с несколькими значениями.</li></ul> | Строка
    items | Тип значений. Присутствует у полей с несколькими значениями. | Строка
    required | Обязательность заполнения поля:<ul><li>`true` — поле обязательно для заполнения;</li><li>`false` — поле не обязательно для заполнения.</li></ul> | Логический

    **Поля объекта** `optionsProvider` {#optionsProvider}
    
    Параметр | Описание | Тип данных
    -------- | -------- | ----------
    type | Тип выпадающего списка. | Строка
    needValidation | Проверка значения на валидность:<ul><li>`true` — проверять значение списка на валидность;</li><li>`false` — не проверять значение списка на валидность.</li></ul> | Логический
    values | Значения для выпадающего списка. | Массив строк


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

    **Поля объекта** `queue` {#queue}
    
    {% include [queue](../../../_includes/tracker/api/queue.md) %} 
    
    {% endcut %}
 

 - Запрос выполнен с ошибкой

    Если запрос не был успешно обработан, API возвращает ответ с кодом ошибки:

    {% include [error](../../../_includes/tracker/api/answer-error-400.md) %}

    {% include [error](../../../_includes/tracker/api/answer-error-401.md) %}

    {% include [error](../../../_includes/tracker/api/answer-error-403.md) %}

    {% include [error](../../../_includes/tracker/api/answer-error-404.md) %}

    {% include [error](../../../_includes/tracker/api/answer-error-500.md) %}

    {% include [error](../../../_includes/tracker/api/answer-error-503.md) %}

{% endlist %}