---
sourcePath: ru/tracker/api-ref/post-macros.md
---
# Создать макрос

Запрос позволяет создать [макрос](manager/create-macroses.md).

## Формат запроса {#section_sw2_w4f_sfb}

Перед выполнением запроса [получите доступ к API](concepts/access.md).

Чтобы создать макрос, используйте HTTP-запрос с методом `POST`:

```json
POST /{{ ver }}/queues/<ключ_или_идентификатор_очереди>/macros
Host: {{ host }}
Authorization: OAuth <OAuth-токен>
{{ org-id }}

{
  "name": "<имя_макроса>",
  "body": "<текст_комментария>\nnot_var{{currentDateTime}}\nnot_var{{issue.author}}",
  "fieldChanges": [
    {
      "field": "<идентификатор_поля_задачи>",
      "value": "<значение_поля_задачи>"
    }, 
     ...
  ]
}
```

{% include [headings](../_includes/tracker/api/headings.md) %}

{% cut "Ресурс" %}

Параметр | Описание | Тип данных
-------- | -------- | ----------
\<ключ_или_идентификатор_очереди> | Идентификатор или ключ очереди. Ключ очереди чувствителен к регистру символов. | Строка

{% endcut %} 

{% cut "Параметры тела запроса" %}

**Обязательные параметры**

Параметр | Значение | Тип данных
----- | ----- | -----
name | Название макроса.| Строка

**Дополнительные параметры**
  
Параметр | Описание | Тип данных
----- | ----- | -----
body | Сообщение, которое будет создано при выполнении макроса. Используйте [специальный формат](common-format.md#text-format) для оформления текста сообщения.<br/>Чтобы удалить сообщение, используйте конструкцию `"body": {"unset":1}` | Строка
[fieldChanges](#fieldChanges) | Массив с информацией о полях задачи, изменения которых запустит макрос. | Массив объектов

**Объекты массива** `fieldChanges` {#fieldChanges}

Параметр | Описание | Тип данных
-------- | -------- | ---------- 
field | Идентификатор поля задачи.<br/><br/>[Полный список полей задачи]({{ link-admin-fields }}) | Строка
value | Значение поля задачи. | Строка

{% endcut %}
 
## Формат ответа {#section_ibd_4yf_sfb}

{% list tabs %}

- Запрос выполнен успешно
  
    {% include [answer-200](../_includes/tracker/api/answer-200.md) %}
  
    Тело ответа содержит JSON-объект с параметрами созданного макроса.

    ```json
      {
        "self": "https://{{ host }}/v2/queues/TEST/macros/3",
        "id": 3,
        "queue": {
          "self": "https://{{ host }}/v2/queues/TEST", 
          "id": "1",
          "key": "TEST",
          "display": "Тестовая очередь"
           },
        "name": "Тестовый макрос",
        "body": "Тестовый комментарий\nnot_var{{currentDateTime}}\nnot_var{{issue.author}}",
        "fieldChanges": [
          {
            "field": {
               "self": "https://{{ host }}/v2/fields/tags", 
               "id": "tags",
               "display": "Теги"
              },
            "value": [
                    "tag1"
                     ]
          },
           ...
        ]
      }
    ```

    {% cut "Параметры ответа" %}

    Параметр | Описание | Тип данных
    ----- | ----- | -----
    self | Адрес ресурса API, который содержит параметры макроса. | Строка
    id | Идентификатор макроса. | Число
    [queue](#queue) | Объект с информацией об очереди, к задачам которой применяется макрос. | Объект
    name | Название макроса. | Строка
    body | Сообщение, которое будет создано при выполнении макроса. | Строка
    [fieldChanges](#fieldChanges) | Массив с информацией о полях задачи, изменения которых запустит макрос. | Массив объектов

    **Поля объекта** `queue`{#queue}

    {% include [queue](../_includes/tracker/api/queue.md) %}

    **Поля объекта** `fieldChanges` {#fieldChanges}

    Параметр | Описание | Тип данных
    -------- | -------- | ----------     
    [field](#field) | Объект с информацией о поле задачи. | Объект
    value | Массив со значениями поля задачи. | Массив объектов

    **Поля объекта** `field` {#field}
    
    Параметр | Описание | Тип данных
    -------- | -------- | ---------- 
    self | Адрес ресурса API, который содержит информацию о поле задачи. | Строка
    id | Идентификатор поля задачи. | Строка
    display | Отображаемое название поля задачи. | Строка

    {% endcut %}

- Запрос выполнен с ошибкой

    Если запрос не был успешно обработан, API возвращает ответ с кодом ошибки:

    {% include [answer-error-400](../_includes/tracker/api/answer-error-400.md) %}

    {% include [answer-error-403](../_includes/tracker/api/answer-error-403.md) %}

    {% include [answer-error-404](../_includes/tracker/api/answer-error-404.md) %}

    {% include [answer-error-409](../_includes/tracker/api/answer-error-409.md) %}

    {% include [answer-error-500](../_includes/tracker/api/answer-error-500.md) %}

    {% include [answer-error-503](../_includes/tracker/api/answer-error-503.md) %}
       
{% endlist %}