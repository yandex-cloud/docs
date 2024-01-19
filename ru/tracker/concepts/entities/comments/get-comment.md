---
sourcePath: ru/tracker/api-ref/concepts/entities/comments/get-comment.md
---
# Получить комментарий сущности

Запрос позволяет получить комментарий [сущности](../about-entities.md).

## Формат запроса {#query}

Перед выполнением запроса [получите доступ к API](../../access.md).

Для получения комментария используйте HTTP-запрос с методом `GET`.

```json
GET /{{ ver }}/entities/<entityType>/<id>/comments/<commentId>
Host: {{ host }}
Authorization: OAuth <OAuth-токен>
{{ org-id }}
```

{% include [headings](../../../../_includes/tracker/api/headings.md) %}

{% include [resource](../../../../_includes/tracker/api/resource-entity-comment.md) %}

{% cut "Параметры запроса" %}

**Дополнительные параметры**

Параметр | Описание | Тип данных
-------- | -------- | ----------
expand | Дополнительная информация, которая будет включена в ответ: <ul><li>`all` — все;</li><li>`html` — HTML-разметка комментария;</li><li>`attachments` — вложенные файлы;</li><li>`reactions` — реакции на комментарий.</li></ul> | Строка

{% endcut %}

> Пример: Получить комментарий
>
> - Используется HTTP-метод GET.
> - В ответе выводится информация о комментарии.
>
> ```
> GET /v2/entities/project/6586d6fee2b9ef74********/comments/15?expand=all
> Host: {{ host }}
> Authorization: OAuth <OAuth-токен>
> {{ org-id }}
> ```

## Формат ответа {#answer}

{% list tabs %}

- Запрос выполнен успешно

  {% include [answer-200](../../../../_includes/tracker/api/answer-200.md) %}

  Тело ответа содержит информацию о комментарии сущности в формате JSON.

  ```json
  {
      "self": "{{ host }}/v2/entities/project/6586d6fee2b9ef74********/comments/15", 
      "id": 15, 
      "longId": "65a156a29d5d2000********",
      "text": "Комментарий **номер один.**",
      "textHtml": "<p>Комментарий <strong>номер один.</strong></p>\n",
      "attachments": [
          {
              "self": "{{ host }}/v2/entities/project/6586d6fee2b9ef74********/attachments/25", 
              "id": "25", 
              "display": "image.jpg"
          }
      ], 
      "createdBy": {
          "self": "{{ host }}/v2/users/1990********",
          "id": "id_сотрудника",
          "display": "Имя_Фамилия",
          "cloudUid": "ajeppa7dgp53********",
          "passportUid": "15********"
      },
      "updatedBy": {
          "self": "{{ host }}/v2/users/1990********",
          "id": "id_сотрудника",
          "display": "Имя_Фамилия",
          "cloudUid": "ajeppa7dgp53********",
          "passportUid": "15********"
      },
      "createdAt": "2024-01-12T15:11:30.278+0000", 
      "updatedAt": "2024-01-12T16:33:35.988+0000", 
      "usersReacted": {
          "like": [
              {
                  "self": "{{ host }}/v2/users/1993********",
                  "id": "id_сотрудника",
                  "display": "Имя_Фамилия",
                  "cloudUid": "ajeppa7dgp71********",
                  "passportUid": "16********"
              }
          ]
      }, 
      "ownReactions": ["like"], 
      "summonees": [
          {
              "self": "{{ host }}/v2/users/1972********",
              "id": "id_сотрудника",
              "display": "Имя_Фамилия",
              "cloudUid": "ajeppa7dgp32********",
              "passportUid": "12********"
          }
      ],
      "version": 3, 
      "type": "standard", 
      "transport": "internal"
  }
  ```

  {% cut "Параметры ответа" %}

  Параметр | Описание | Тип данных
  ----- | ----- | -----
  self | Ссылка на объект комментария. | Строка
  id | Идентификатор комментария. | Число
  longId | Идентификатор комментария в виде строки. | Строка
  text | Текст комментария. | Строка
  textHtml | HTML-разметка комментария. | Строка
  attachments | Вложения. | Строка
  [createdBy](#created-by) | Объект с информацией о создателе комментария. | Объект
  [updatedBy](#updated-by) | Объект с информацией о сотруднике, внесшем последнее изменение в комментарий. | Объект
  createdAt | Дата и время создания комментария в формате:<br/>``` YYYY-MM-DDThh:mm:ss.sss±hhmm ```. | Строка
  updatedAt | Дата и время обновления комментария в формате:<br/>``` YYYY-MM-DDThh:mm:ss.sss±hhmm ```. | Строка
  usersReacted | Реакции пользователей (присутствует в ответе, если в запросе для параметра `expand` указано значение `all` или `reactions`):<ul><li>`like`;</li><li>`dislike`;</li><li>`laugh`;</li><li>`tada`;</li><li>`hooray`;</li><li>`confused`;</li><li>`heart`;</li><li>`rocket`;</li><li>`eyes`;</li><li>`fire`;</li><li>`ok`;</li><li>`facepalm`;</li><li>`check`.</li></ul> | Объект со списком реакций и отреагировавших
  reactionsCount | Количество реакций (присутствует в ответе, если в запросе для параметра `expand` не указано значение `all` или `reactions`). | Объект со списком и количеством реакций
  ownReactions | Реакции автора комментария:<ul><li>`like`;</li><li>`dislike`;</li><li>`laugh`;</li><li>`tada`;</li><li>`hooray`;</li><li>`confused`;</li><li>`heart`;</li><li>`rocket`;</li><li>`eyes`;</li><li>`fire`;</li><li>`ok`;</li><li>`facepalm`;</li><li>`check`.</li></ul> | Список строк
  summonees | Список вызываемых в комментарии пользователей. | Список объектов
  version | Версия комментария. Каждое изменение комментария увеличивает номер версии. | Число
  type | Тип комментария:<ul><li>`standart` — отправлен через интерфейс {{ tracker-name }};</li><li>`incoming` — создан из входящего письма;</li><li>`outcoming` — создан из исходящего письма.</li></ul> | Строка
  transport | Способ добавления комментария:<ul><li>`internal` — через интерфейс {{ tracker-name }};</li><li>`email` — через письмо.</li></ul> | Строка

  **Поля объекта** `createdBy` {#created-by}

  Параметр | Описание | Тип данных
  ----- | ----- | -----
  self | Адрес ресурса API, который содержит информацию о пользователе. | Строка
  id | Идентификатор пользователя. | Число
  display | Отображаемое имя пользователя. | Строка
  cloudUid | Уникальный идентификатор пользователя в {{ org-full-name }}. | Строка
  passportUid | Уникальный идентификатор аккаунта пользователя в организации {{ ya-360 }} и Яндекс ID. | Строка
        
  **Поля объекта** `updatedBy` {#updated-by}

  Параметр | Описание | Тип данных
  ----- | ----- | -----
  self | Адрес ресурса API, который содержит информацию о пользователе. | Строка
  id | Идентификатор пользователя. | Число
  display | Отображаемое имя пользователя. | Строка
  cloudUid | Уникальный идентификатор пользователя в {{ org-full-name }}. | Строка
  passportUid | Уникальный идентификатор аккаунта пользователя в организации {{ ya-360 }} и Яндекс ID. | Строка
        
  **Поля объекта** `usersReacted` {#users-reacted}

  Параметр | Описание | Тип данных
  ----- | ----- | -----
  self | Адрес ресурса API, который содержит информацию о пользователе. | Строка
  id | Идентификатор пользователя. | Число
  display | Отображаемое имя пользователя. | Строка
  cloudUid | Уникальный идентификатор пользователя в {{ org-full-name }}. | Строка
  passportUid | Уникальный идентификатор аккаунта пользователя в организации {{ ya-360 }} и Яндекс ID. | Строка

  {% endcut %}  
  
- Запрос выполнен с ошибкой

  Если запрос не был успешно обработан, API возвращает ответ с кодом ошибки:

  {% include [error-400](../../../../_includes/tracker/api/answer-error-400.md) %}
  
  {% include [error-404](../../../../_includes/tracker/api/answer-error-404.md) %}
  
  {% include [error-422](../../../../_includes/tracker/api/answer-error-422.md) %}

{% endlist %}
