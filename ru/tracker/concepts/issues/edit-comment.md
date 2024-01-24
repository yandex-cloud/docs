---
sourcePath: ru/tracker/api-ref/concepts/issues/edit-comment.md
---
# Редактировать комментарий

Запрос позволяет редактировать комментарий.

## Формат запроса {#section_rkq_bhl_dfb}

Перед выполнением запроса [получите доступ к API](../access.md).

Чтобы изменить комментарий, который был [добавлен к задаче](add-comment.md) ранее, используйте HTTP-запрос с методом `PATCH`. Параметр запроса передается в его теле в формате JSON:

```json
PATCH /{{ ver }}/issues/<issue-id>/comments/<comment-id>
Host: {{ host }}
Authorization: OAuth <OAuth-токен>
{{ org-id }}

{
   "text": "<новый текст комментария>"
}
```

{% include [headings](../../../_includes/tracker/api/headings.md) %}

{% cut "Ресурс" %}

Параметр | Описание | Тип данных
-------- | -------- | ----------
\<issue-id> | Идентификатор или ключ текущей задачи. | Строка
\<comment-id> | [Уникальный идентификатор комментария](get-comments.md#section_xc3_53j_p1b) в числовом формате (id) или формате строки (longId). | Строка или число

{% endcut %} 


{% cut "Параметры тела запроса" %}

**Обязательные параметры**

Параметр | Значение | Тип данных
----- | ----- | -----
text | Скорректированный комментарий к задаче. | Строка

**Дополнительные параметры**

Параметр | Значение | Тип данных
----- | ----- | -----
attachmentIds | Список [идентификаторов вложений](temp-attachment.md). | Массив строк

{% endcut %}

## Формат ответа {#section_rcd_ysf_2fb}

{% list tabs %}

- Запрос выполнен успешно

    {% include [answer-200](../../../_includes/tracker/api/answer-200.md) %}
  
    Тело ответа содержит информацию о добавленном комментарии в формате JSON.

  ```json
  [ 
  {
    "self" : "https://{{ host }}/v2/issues/TREK-1/comments/684",
    "id" : "684",  
    "longId" : "5fc4bc634e121b12f44a0488",  
    "text" : "<текст комментария>",
    "createBody" : {
     "self" : "https://{{ host }}/v2/users/1120000000016876",
     "id" : "<id пользователя>",
     "display" : "<отображаемое имя пользователя>"
    },
    "updateBody" : {
     "self" : "https://{{ host }}/v2/users/1120000000016876",
     "id" : "<id пользователя>",
     "display" : "<отображаемое имя пользователя>"
    },
    "createdAt" : "2020-11-30T09:33:23.638+0000",  
    "updatedAt" : "2020-11-30T09:39:07.631+0000",  
    "summonees" : [
     { 
      "self" : "https://{{ host }}/v2/users/1120000000016576",
      "id" : "<id пользователя>",
      "display" : "<отображаемое имя пользователя>"
     } 
    ],
   "maillistSummonees" : [
     { 
      "self" : "https://{{ host }}/v2/maillists/usertest@test.ru",
      "id" : "<адрес рассылки>",
      "display" : "<отображаемое имя рассылки>"
     } 
    ], 
    "version" : 2,  
    "type" : "standard",  
    "transport" : "internal"
  }
  ]
  ```

  {% cut "Параметры ответа" %}

  Параметр | Описание | Тип данных
  ----- | ----- | -----
  self | Ссылка на комментарий. | Строка
  id | Идентификатор комментария. | Строка
  longId | Идентификатор комментария в формате строки. | Строка
  text | Комментарий к задаче. | Строка
  [createdBy](#object-fields-createdBy) | Блок с информацией о пользователе, который добавил комментарий. | Объект
  [updatedBy](#object-fields-updatedBy) | Блок с информацией о пользователе, который последним изменил комментарий. | Объект
  createdAt | Дата и время создания комментария. | Строка
  updatedAt | Дата и время обновления комментария. | Строка
  [summonees](#object-fields-summonees) | Блок с информацией о пользователях, которые призваны в комментарии. | Объект
  [maillistsummonees](#object-fields-maillistsummonees) | Блок с информацией о рассылках, которые призваны в комментарии. | Объект
  version | Версия комментария. Каждое изменение комментария увеличивает номер версии. | Число
  type | Тип комментария:<ul><li>`standart` — отправлен через интерфейс {{ tracker-name }};</li><li>`incoming` — создан из входящего письма;</li><li>`outcoming` — создан из исходящего письма.</li></ul> | Строка
  transport | Способ добавления комментария:<ul><li>`internal` — через интерфейс {{ tracker-name }};</li><li>`email` — через письмо.</li></ul> | Строка
      
  **Поля объекта** `createdBy` {#object-fields-createdBy}

  {% include [user](../../../_includes/tracker/api/user.md) %}

  **Поля объекта** `updatedBy` {#object-fields-updatedBy}

  {% include [user](../../../_includes/tracker/api/user.md) %}
     
  **Поля объекта** `summonees` {#object-fields-summonees}

  {% include [user](../../../_includes/tracker/api/user.md) %}

  **Поля объекта** `maillistsummonees` {#object-fields-maillistsummonees}

  Параметр | Описание | Тип данных
  ----- | ----- | ----- 
  self | Ссылка на рассылку. | Строка
  id | Адрес рассылки. | Строка
  display | Отображаемое имя рассылки. | Строка

  {% endcut %}

- Запрос выполнен с ошибкой

  Если запрос не был успешно обработан, API возвращает ответ с кодом ошибки:

  {% include [answer-error-400](../../../_includes/tracker/api/answer-error-400.md) %}

  {% include [answer-error-404](../../../_includes/tracker/api/answer-error-404.md) %}

{% endlist %}

