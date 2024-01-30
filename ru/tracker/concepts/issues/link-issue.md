---
sourcePath: ru/tracker/api-ref/concepts/issues/link-issue.md
---
# Связать задачи

Запрос позволяет создать связь между двумя задачами. Связь создается между текущей задачей (указывается в параметре `issue-id` запроса) и связываемой (указывается в поле `issue` тела запроса).

## Формат запроса {#section_rnm_x4j_p1b}

Перед выполнением запроса [получите доступ к API](../access.md).

Для создания связи используйте HTTP-запрос с методом `POST`:

```json
POST /{{ ver }}/issues/<ключ_или_идентификатор_задачи>/links
Host: {{ host }}
Authorization: OAuth <OAuth-токен>
{{ org-id }}

{
    "relationship": "<тип_связи>",
    "issue": "<задача>"
}
```
{% include [headings](../../../_includes/tracker/api/headings.md) %} 

{% include [resource-issue-id](../../../_includes/tracker/api/resource-issue-id.md) %}  

{% cut "Параметры тела запроса" %}

**Обязательные параметры**

Параметр | Описание | Формат
----- | ----- | -----
relationship | Тип связи между задачами:<ul><li>`relates` — простая связь.</li><li>`is dependent by` — текущая задача является блокером.</li><li>`depends on` — текущая задача зависит от связываемой.</li><li>`is subtask for` — текущая задача является подзадачей связываемой.</li><li>`is parent task for` — текущая задача является родительской для связываемой задачи.</li><li>`duplicates` — текущая задача дублирует связываемую.</li><li>`is duplicated by` — связываемая задача дублирует текущую.</li><li>`is epic of` — текущая задача является эпиком связываемой. Связь такого типа можно установить только для задач типа "Эпик".</li><li>`has epic` — связываемая задача является эпиком текущей. Связь такого типа можно установить только для задач типа "Эпик".</li></ul> | Строка
issue {#issue} | Идентификатор или ключ связываемой задачи. | Строка

{% endcut %}

> Создание связи:
> 
> - Используется HTTP-метод POST.
> 
> ```
> POST /v2/issues/TEST-1/?links HTTP/1.1
> Host: {{ host }}
> Authorization: OAuth <OAuth-токен>
> {{ org-id }}
> 
> {
>     "relationship": "relates",
>     "issue": "TREK-2"
> }
> ```

## Формат ответа {#section_xpm_q1y_51b}

{% list tabs %}

- Запрос выполнен успешно

    {% include [answer-201](../../../_includes/tracker/api/answer-201.md) %}

    Тело ответа содержит результаты в формате JSON.

  ```json
    {
      "self" : "https://{{ host }}/v2/issues/TEST-1/links/10*****",
      "id" : 10*****,
      "type" : {
        "self" : "https://{{ host }}/v2/linktypes/relates",
        "id" : "relates",
        "inward" : "relates",
        "outward" : "relates"
      },
      "direction" : "inward",
      "object" : {
        "self" : "https://{{ host }}/v2/issues/STARTREK-2",
        "id" : "4ff3e8dae4b0e2ac********",
        "key" : "TREK-2",
        "display" : "NEW!!!"
      },
      "createdBy" : {
        "self" : "https://{{ host }}/v2/users/44********",
        "id": "44********",
        "display": "Иван Иванов"
      },
      "updatedBy" : {
        "self": "https://{{ host }}/v2/users/44********",
        "id": "44********",
        "display": "Иван Иванов"
      },
      "createdAt" : "2014-06-18T12:06:02.401+0000",
      "updatedAt" : "2014-06-18T12:06:02.401+0000"
    }
  ```

  {% cut "Параметры ответа" %}

  Параметр | Описание | Тип данных
  ----- | ----- | -----
  self | Адрес ресурса API, который содержит информацию о связи. | Строка
  id | Идентификатор связи. | Число
  [type](#type) | Блок с информацией о типе связи. | Объект
  direction | Тип связи задачи, указанной в запросе, по отношению к задаче в поле [object](#object-param). Возможны следующие значения:<ul><li>`outward` — задача, указанная в запросе, является основной для задачи в поле [object](#object-param).</li><li>`inward` — задача в поле [object](#object-param) является основной для задачи, указанной в запросе.</li></ul> | Строка
  [object](#object) {#object-param} | Блок с информацией о связанной задаче. | Объект
  [createdBy](#created-by) | Блок с информацией о создателе связи. | Объект
  [updatedBy](#updated-by) | Блок с информацией о последнем изменившем связанную задачу пользователе. | Объект
  createdAt | Дата и время создания связи. | Строка
  updatedAt | Дата и время изменения связи. | Строка
  [assignee](#assignee) | Исполнитель связанной задачи. | Объект
  [status](#status) | Статус связанной задачи. | Объект

  **Поля объекта** `type` {#type}

  Параметр | Описание | Тип данных
  ----- | ----- | -----
  self | Ссылка на тип связи. | Строка
  id | Идентификатор типа связи. | Строка
  inward | Название типа связи задачи в поле [object](#object-param) по отношению к задаче, указанной в запросе. | Строка
  outward | Название типа связи задачи, указанной в запросе, по отношению к задаче в поле [object](#object-param). | Строка

  **Поля объекта** `object` {#object}

  {% include [issue](../../../_includes/tracker/api/issue.md) %}

  **Поля объекта** `createdBy` {#created-by}

  {% include [user](../../../_includes/tracker/api/user.md) %}

  **Поля объекта** `updatedBy` {#updated-by}

  {% include [user](../../../_includes/tracker/api/user.md) %}

  **Поля объекта** `assignee` {#assignee}

  {% include [user](../../../_includes/tracker/api/user.md) %}

  **Поля объекта** `status` {#status}

  {% include [status](../../../_includes/tracker/api/status.md) %}

  {% endcut %}

- Запрос выполнен с ошибкой

  Если запрос не был успешно обработан, API возвращает ответ с кодом ошибки:

  {% include [answer-error-404](../../../_includes/tracker/api/answer-error-404.md) %}

{% endlist %}
