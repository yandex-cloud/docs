---
sourcePath: ru/tracker/api-ref/concepts/issues/new-transition.md
---
# Выполнить переход в статус

Запрос позволяет перевести задачу в новый статус.

## Формат запроса {#section_rkq_bhl_dfb}

Перед выполнением запроса [получите доступ к API](../access.md).

Чтобы перевести задачу в новый статус, используйте HTTP-запрос с методом `POST`. Если настройки перехода позволяют изменять параметры задачи, укажите их в теле запроса в формате JSON:

```json
POST /{{ ver }}/issues/<ключ_или_идентификатор_задачи>/transitions/<идентификатор_перехода>/_execute
Host: {{ host }}
Authorization: OAuth <OAuth-токен>
{{ org-id }}

{
  "<ключ_1>":"<значение_1>",
  "<ключ_2>":"<значение_2>",
  ...
  "comment":"<текст_комментария>"
}
```

{% include [headings](../../../_includes/tracker/api/headings.md) %}

{% cut "Ресурс" %}

Параметр | Описание | Тип данных
-------- | -------- | ----------
\<ключ_или_идентификатор_задачи> | Идентификатор или ключ текущей задачи. | Строка
\<идентификатор_перехода> | Идентификатор перехода. | Строка

{% endcut %} 

{% cut "Параметры тела запроса" %}

**Обязательные параметры**

Параметр | Значение | Тип данных
----- | ----- | -----
\<ключ\> | Поле задачи, доступное для изменения при переходе. Список ключей: [{{ link-admin-fields }}]({{ link-admin-fields }}) | Зависит от типа параметра.
comment | Комментарий к задаче. | Строка

{% endcut %}

## Формат ответа {#section_rcd_ysf_2fb}

{% list tabs %}

- Запрос выполнен успешно

    {% include [answer-200](../../../_includes/tracker/api/answer-200.md) %}
  
    Тело ответа содержит JSON-массив со списком переходов, доступных для задачи в новом статусе.
  
    ```json
    [ 
    {
      "self" : "https://{{ host }}/v2/issues/DESIGN-1/transitions/close",
      "id" : "close",
      "to" : {
      "self" : "https://{{ host }}/v2/statuses/3",
        "id" : "3",
        "key" : "closed",
        "display" : "Closed"
      },
      "screen" : {
        "self" : "https://{{ host }}/v2/screens/50c85b17e4b04b38********",
        "id" : "50c85b17e4b04b38********"
      }
     },
     ...
    ]
    ```

  {% cut "Параметры ответа" %}
	
  Параметр | Описание | Тип данных
  ----- | ----- | -----
  self | Адрес ресурса API, который содержит информацию о переходе. | Строка
  id | Идентификатор перехода. | Строка
  [to](#to) | Блок с информацией о статусе, в который можно перевести задачу. | Объект
  [screen](#screen) | Блок с информацией об экране перехода. | Объект
        
  **Поля объекта** `to` {#to}
		
  {% include [status](../../../_includes/tracker/api/status.md) %}
       
  **Поля объекта** `screen` {#screen}

  Параметр | Описание | Тип данных
  ----- | ----- | -----
  self | Адрес ресурса API, который содержит информацию об экране перехода. | Строка
  id | Идентификатор экрана перехода. | Строка

  {% endcut %}

- Запрос выполнен с ошибкой

  Если запрос не был успешно обработан, API возвращает ответ с кодом ошибки:

  {% include [answer-error-400](../../../_includes/tracker/api/answer-error-400.md) %}

  {% include [answer-error-403](../../../_includes/tracker/api/answer-error-403.md) %}

  {% include [answer-error-404](../../../_includes/tracker/api/answer-error-404.md) %}

  {% include [answer-error-409](../../../_includes/tracker/api/answer-error-409.md) %}

  {% include [answer-error-422](../../../_includes/tracker/api/answer-error-422.md) %}

  {% include [answer-error-500](../../../_includes/tracker/api/answer-error-500.md) %} 

  {% include [answer-error-503](../../../_includes/tracker/api/answer-error-503.md) %} 
	
{% endlist %}