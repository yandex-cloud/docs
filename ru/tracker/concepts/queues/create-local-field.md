---
sourcePath: ru/tracker/api-ref/concepts/queues/create-local-field.md
---
# Создать локальное поле очереди

Запрос позволяет создать [локальное поле](../../local-fields.md) задачи, привязанное к заданной очереди.

## Формат запроса {#query}

Перед выполнением запроса [получите доступ к API](../access.md).

Чтобы создать локальное поле, используйте HTTP-запрос с методом `POST`. Параметры запроса передаются в его теле в формате JSON:

```json
POST /{{ ver }}/queues/<queue-id>/localFields
Host: {{ host }}
Authorization: OAuth <OAuth-токен>
{{ org-id }}

{
    "name":
    {
        "en": "Название на английском языке",
        "ru": "Название на русском языке"
    },
    "id": "loc_field_key",
    "category": "000000000000000000000003",
    "type": "ru.yandex.startrek.core.fields.StringFieldType"
}

```

{% include [headings](../../../_includes/tracker/api/headings.md) %}

{% cut "Ресурс" %}

Параметр | Описание | Тип данных
-------- | -------- | ----------
\<queue-id\> | Идентификатор или ключ очереди. Ключ очереди чувствителен к регистру символов. | Строка

{% endcut %}

{% cut "Параметры тела запроса" %}

**Обязательные параметры**

Параметр | Описание | Тип данных
----- | ----- | -----
name | Название локального поля:<ul><li>`en` — на английском языке;</li><li>`ru` — на русском языке.</li></ul>| Строка
id | Идентификатор локального поля. | Строка
category | Объект с информацией о категории поля.<br/>Чтобы получить список всех категорий, используйте HTTP запрос:<br/>`GET /v2/fields/categories` | Строка
type | Тип локального поля:<ul><li>`ru.yandex.startrek.core.fields.DateFieldType` — Дата;</li><li>`ru.yandex.startrek.core.fields.DateTimeFieldType` — Дата/Время;</li><li>`ru.yandex.startrek.core.fields.StringFieldType` — Текстовое однострочное поле;</li><li>`ru.yandex.startrek.core.fields.TextFieldType` — Текстовое многострочное поле;</li><li>`ru.yandex.startrek.core.fields.FloatFieldType` — Дробное число;</li><li>`ru.yandex.startrek.core.fields.IntegerFieldType` — Целое число;</li><li>`ru.yandex.startrek.core.fields.UserFieldType` — Имя пользователя;</li><li>`ru.yandex.startrek.core.fields.UriFieldType` — Ссылка.</li>| Строка

**Дополнительные параметры**

Параметр | Описание | Тип данных
----- | ----- | -----
[optionsProvider](#optionsProvider1) | Объект с информацией об элементах списка. | Объект
order | Порядковый номер в списке полей организации: [{{ link-admin-fields }}]({{ link-admin-fields }}).  | Число
description | Описание локального поля. | Строка
readonly | Возможность редактировать значение поля:<ul><li>`true` — значение поля нельзя изменить;</li><li>`false` — значение поля можно изменить.</li></ul> | Логический
visible | Признак отображения поля в интерфейсе:<ul><li>`true` — всегда отображать поле в интерфейсе;</li><li>`false` — не отображать поле в интерфейсе.</li></ul>| Логический
hidden | Признак видимости поля в интерфейсе:<ul><li>`true` — скрывать поле даже в том случае, если оно заполнено;</li><li>`false` — не скрывать поле.</li></ul> | Логический
container | Признак возможности указать в поле одновременно несколько значений (например, как в поле **Теги**):<ul><li>`true` — в поле можно указать несколько значений;</li><li>`false` — в поле можно указать только одно значение.</li></ul>Этот параметр допустимо использовать для полей следующих типов:<ul><li>`ru.yandex.startrek.core.fields.StringFieldType` — Текстовое однострочное поле;</li><li>`ru.yandex.startrek.core.fields.UserFieldType` — Имя пользователя;</li><li>выпадающий список (см. описание объекта `optionsProvider`).</li></ul> | Логический

**Поля объекта** `optionsProvider` {#optionsProvider1}
    
Параметр | Описание | Тип данных
-------- | -------- | ----------
type | Тип выпадающего списка: <ul><li>`FixedListOptionsProvider` — список строковых или числовых значений (для полей с типом `ru.yandex.startrek.core.fields.StringFieldType` или `ru.yandex.startrek.core.fields.IntegerFieldType`);</li><li>`FixedUserListOptionsProvider` — список пользователей (для полей с типом `ru.yandex.startrek.core.fields.UserFieldType`).</li></ul> | Строка
values | Значения для выпадающего списка. | Массив строк

{% endcut %}

>Пример: Создать локальное поле типа <q>Выпадающий список</q> с фиксированным набором строковых значений:
>
>- Используется HTTP-метод POST.
>- Создается локальное поле для очереди DESIGN.
>- Тип поля: `FixedListOptionsProvider`.
>- Значения в выпадающем списке: <q>первый элемент списка</q>, <q>второй элемент списка</q>, <q>третий элемент списка</q>.
>
>```json
>POST /v2/queues/DESIGN/localFields
>Host: {{ host }}
>Authorization: OAuth <OAuth-токен>
>{{ org-id }}
>
>{
>"name":
>{
>    "en": "Название на английском языке",
>    "ru": "Название на русском языке"
>},
>"id": "loc_field_key",
>"category": "000000000000000000000003",
>"type": "ru.yandex.startrek.core.fields.StringFieldType",
>"optionsProvider": {
>    "type": "FixedListOptionsProvider",
>    "values": [
>        "первый элемент списка",
>        "второй элемент списка",
>        "третий элемент списка"
>    ]
>}
>}
>```

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
        "name": "Название поля на русском языке",
        "description": "Описание локального поля",
        "key": "loc_field_key",
        "version": 1,
        "schema": {
            "type": "string",
            "required": false
        },
        "readonly": true,
        "options": false,
        "suggest": false,
        "queryProvider": {
            "type": "StringOptionalQueryProvider"
        },
        "order": 100, 
        "category": {
            "self": "https://{{ host }}/v2/fields/categories/000000000000000000000003",
            "id": "000000000000000000000003",
            "display": "category_name"
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
    [optionsProvider](#optionsProvider) | Объект с информацией об элементах выпадающего списка. | Объект
    [queryProvider](#queryProvider) | Объект с информацией о классе языка запроса.<br/>Класс невозможно изменить с помощью API. | Объект
    order | Порядковый номер в списке полей организации: [{{ link-admin-fields }}]({{ link-admin-fields }}) | Число
    [category](#category) | Объект с информацией о категории поля.<br/>Чтобы получить список всех категорий, используйте HTTP запрос:<br/>`GET /v2/fields/categories` | Объект


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
    values | Элементы списка | Массив строк

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

    Если запрос не был успешно обработан, API возвращает ответ с кодом ошибки:

    {% include [error](../../../_includes/tracker/api/answer-error-400.md) %}

    {% include [error](../../../_includes/tracker/api/answer-error-401.md) %}

    {% include [error](../../../_includes/tracker/api/answer-error-403.md) %}

    {% include [error](../../../_includes/tracker/api/answer-error-404.md) %}

    {% include [error](../../../_includes/tracker/api/answer-error-422.md) %}

    {% include [error](../../../_includes/tracker/api/answer-error-500.md) %}

    {% include [error](../../../_includes/tracker/api/answer-error-503.md) %}

{% endlist %}