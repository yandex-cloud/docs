---
sourcePath: ru/tracker/api-ref/get-macros.md
---
# Получить макрос

Запрос позволяет получить параметры макроса.

## Формат запроса {#section_wls_kl2_sfb}

Перед выполнением запроса [получите доступ к API](concepts/access.md).

Чтобы получить параметры макроса, используйте HTTP-запрос с методом `GET`:

```json
GET /{{ ver }}/queues/<queue-id>/macros/<macros-id>
Host: {{ host }}
Authorization: OAuth <токен>
{{ org-id }}
```

{% include [headings](../_includes/tracker/api/headings.md) %}

{% cut "Ресурс" %}

Параметр | Описание | Тип данных
-------- | -------- | ----------
\<queue-id> | Идентификатор или ключ очереди. Ключ очереди чувствителен к регистру символов. | Строка
\<macros-id> | Идентификатор макроса. | Строка

{% endcut %} 
  
## Формат ответа {#section_bhn_lv2_sfb}

{% list tabs %}

- Запрос выполнен успешно
  
    {% include [answer-200](../_includes/tracker/api/answer-200.md) %}
  
    Тело ответа содержит JSON-объект с параметрами макроса.
  
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
                    "tag1", "tag2"
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
    body | [Сообщение](manager/create-macroses.md), которое будет создано при выполнении макроса. Формат: ``` <Текст сообщение>\n<переменная> ```<br/>где:<ul><li> `<Текст сообщения>`— текст, который будет создан в поле **Комментарий** при выполнении макроса.</li><li> ``\n`` — символ переноса строки.</li><li> Переменная, которая может содержать:<br/>`not_var{{currentUser}}` — имя пользователя, который выполнил макрос;<br/> `not_var{{currentDateTime.date}}` — дату выполнения макроса; <br/>`not_var{{currentDateTime}}` — дату и время выполнения макроса;<br/>`{{issue.<ключ_поля>}}` — ключ поля задачи, значение которого отразится в сообщении. Полный список полей задачи: [https://tracker.yandex.ru/admin/fields]({{ link-admin-fields }})</li></ul>Чтобы удалить сообщение, используйте конструкцию `"body": {"unset":1}` | Строка
    [fieldChanges](#fieldChanges) | Массив с информацией о полях задачи, изменения которых запустит макрос. | Массив объектов
    
    **Поля объекта** `queue` {#queue}
    
    {% include [queue](../_includes/tracker/api/queue.md) %}
    
    **Объекты массива** `fieldChanges` {#fieldChanges}

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

    {% include [answer-error-500](../_includes/tracker/api/answer-error-500.md) %}

    {% include [answer-error-503](../_includes/tracker/api/answer-error-503.md) %}

{% endlist %}