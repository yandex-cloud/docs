---
sourcePath: ru/tracker/api-ref/concepts/issues/create-issue-field-category.md
---
# Создать категорию поля задачи

Запрос позволяет создать категорию поля задачи.

## Формат запроса {#query}

Перед выполнением запроса [получите доступ к API](../access.md).

Чтобы создать категорию для поля задачи используйте HTTP-запрос с методом `POST`. Параметры запроса передаются в его теле в формате JSON:

```json
POST /{{ ver }}/fields/categories
Host: {{ host }}
Authorization: OAuth <OAuth-токен>
{{ org-id }}

{
    "name": {
        "en": "Название на английском языке",
        "ru": "Название на русском языке"
        },
        "description": "Текстовое описание", 
    "order": 400
}
```

{% include [headings](../../../_includes/tracker/api/headings.md) %}

{% cut "Параметры тела запроса" %}

**Обязательные параметры**

Параметр | Описание | Тип данных
----- | ----- | -----
name | Название категории:<ul><li>`en` — на английском языке;</li><li>`ru` — на русском языке.</li></ul>| Строка
order | Вес поля при отображении в интерфейсе. Поля с меньшим весом отображаются выше полей с большим весом. | Число

**Дополнительные параметры**

Параметр | Описание | Тип данных
----- | ----- | -----
description | Описание категории. | Строка

{% endcut %}

## Формат ответа {#answer}

{% list tabs %}

- Запрос выполнен успешно

    {% include [answer-201](../../../_includes/tracker/api/answer-201.md) %}

    Тело ответа содержит информацию об измененном проекте в формате JSON.

    ```json
    {
        "id" : "604f9920d23cd5e1697ee3",
        "name" : "category_name",
        "self" : "https://{{ host }}/v2/fields/categories/604f9920d23cd5e1697ee3",
        "version" : 1
    }
    ```

    {% cut "Параметры ответа" %}

    Параметр | Описание | Тип данных
    ----- | ----- | -----
    id | Уникальный идентификатор категории. | Строка
    name | Название категории на русском языке. | Строка
    self | Адрес ресурса API, который содержит информацию о категории. | Строка
    version | Версия категории. Каждое изменение поля увеличивает номер версии. | Число

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