---
sourcePath: ru/tracker/api-ref/concepts/entities/checklists/patch-checklist-item.md
---
# Изменить пункт чеклиста

Запрос позволяет обновить информацию об отдельном пункте [чеклиста](../../../user/checklist.md) в [сущности](../about-entities.md).

## Формат запроса {#query}

Перед выполнением запроса [получите доступ к API](../../access.md).

Чтобы изменить пункт в чеклисте, используйте HTTP-запрос с методом `PATCH`. Параметры запроса передаются в его теле в формате JSON.

```json
PATCH /{{ ver }}/entities/<тип_сущности>/<идентификатор_сущности>/checklistItems/<идентификатор_пункта_чеклиста>
Host: {{ host }}
Authorization: OAuth <OAuth-токен>
{{ org-id }}

{
  "text": "<текст_пункта>",
  "checked": true,
  "assignee": "<логин_или_идентификатор_исполнителя>",
  "deadline": {
    "date": "2021-05-09T00:00:00.000+0000",
    "deadlineType": "date"
  },
}
```

{% include [headings](../../../../_includes/tracker/api/headings.md) %}

{% include [resource-checklist](../../../../_includes/tracker/api/resource-checklist-id.md) %}

{% include [query-params](../../../../_includes/tracker/api/query-params-checklist.md) %}

{% cut "Параметры тела запроса" %}

Тело запроса содержит информацию, необходимую для внесения изменений в пункт чеклиста:

**Дополнительные параметры**

Параметр | Описание | Тип данных
----- | ----- | -----
text | Текст пункта чеклиста. | Строка
checked | Отметка о выполнении пункта: <ul><li>`true` — пункт отмечен как выполненный;</li><li>`false` — пункт не отмечен как выполненный.</li></ul> | Логический
assignee | Идентификатор или логин пользователя, который является исполнителем пункта чеклиста. | Число или строка.
deadline | Дедлайн пункта чеклиста. | Объект

**Поля объекта** `deadline` {#deadline-checklist}

Параметр | Описание | Тип данных
----- | ----- | -----
date | Дата дедлайна в формате `YYYY-MM-DDThh:mm:ss.sss±hhmm`. | Дата
deadlineType | Тип данных параметра `deadline`. | Строка

{% endcut %}

> Пример: Изменить информацию о пункте в чеклисте
>
> - Используется HTTP-метод PATCH.
> - В пункте чеклиста меняется название и ставится отметка о выполнении.
> - В ответе выводится информация о всех пунктах чеклиста (`fields=checklistItems`).
>
> ```
> PATCH /v2/entities/project/<идентификатор_проекта>/checklistItems/<идентификатор_пункта_чеклиста>?fields=checklistItems
> Host: {{ host }}
> Authorization: OAuth <OAuth-токен>
> {{ org-id }}
> 
> {
>    "text":"<измененный_пункт_чеклиста>",
>    "checked": true
> }
> ```

## Формат ответа {#answer}

{% list tabs %}

- Запрос выполнен успешно

  {% include [answer-200](../../../../_includes/tracker/api/answer-200.md) %}

  Тело ответа содержит информацию о сущности, о вложениях сущности и о пунктах чеклиста в формате JSON.

  ```json
  {
      "self": "https://api.tracker.yandex.net/v2/entities/project/6586d6fee2b9ef74********", 
      "id": "6586d6fee2b9ef74********",
      "version": 133,
      "shortId": 0,
      "entityType": "project",
      "createdBy": {
          "self": "{{ host }}/v2/users/19********",
          "id": "19********",
          "display": "Имя Фамилия",
          "cloudUid": "ajeppa7dgp53********",
          "passportUid": "15********"
      },
      "createdAt": "2023-12-13T15:06:27.231Z",
      "updatedAt": "2023-12-13T15:06:27.231Z",
      "fields": {
          "checklistItems": [
             {
                 "id": "6586d91f99a40477********", 
                 "text": "Измененный пункт чеклиста.", 
                 "checked": true, 
                 "checklistItemType": "standard"
             },
             {
                 "id": "6586d91f99a40472********", 
                 "text": "Второй пункт чеклиста.", 
                 "checked": true, 
                 "checklistItemType": "standard"
             }
          ]
      }
  }
  ```

  {% cut "Параметры ответа" %}

  Параметр | Описание | Тип данных
  ----- | ----- | -----
  self | Адрес ресурса API, который содержит информацию о сущности. | Строка
  id | Идентификатор сущности. | Строка
  version | Версия сущности. Каждое изменение параметров увеличивает номер версии. | Число
  shortId | Идентификатор проекта или портфеля. | Число
  entityType | Тип сущности:<ul><li>project — проект;</li><li>portfolio — портфель.</li></ul> | Строка
  createdBy | Объект с информацией о создателе сущности. | Объект
  createdAt | Дата создания сущности в формате `YYYY-MM-DDThh:mm:ss.sss±hhmm`. | Строка
  updatedAt | Дата последнего обновления сущности в формате `YYYY-MM-DDThh:mm:ss.sss±hhmm`. | Строка
  fields | Дополнительные поля. | Объект

  **Поля объекта** `createdBy` {#created-by}

  Параметр | Описание | Тип данных
  ----- | ----- | -----
  self | Адрес ресурса API, который содержит информацию о пользователе. | Строка
  id | Идентификатор пользователя. | Число
  display | Отображаемое имя пользователя. | Строка
  cloudUid | Уникальный идентификатор пользователя в {{ org-full-name }}. | Строка
  passportUid | Уникальный идентификатор аккаунта пользователя в организации {{ ya-360 }} и Яндекс ID. | Строка

  **Поля объекта** `fields` {#fields}

  Параметр | Описание | Тип данных
  ----- | ----- | -----
  checklistItems | Информация о пунктах чеклиста. | Массив объектов

  **Поля объекта** `checklistItems` {#checklist-items}

  Параметр | Описание | Тип данных
  ----- | ----- | -----
  id | Идентификатор пункта чеклиста. | Число
  text | Текст пункта чеклиста. | Строка
  checked | Отметка о выполнении пункта: <ul><li>`true` — пункт отмечен как выполненный;</li><li>`false` — пункт не отмечен как выполненный.</li></ul> | Логический
  assignee | Исполнитель пункта чеклиста | Объект
  checklistItemType | Тип пункта чеклиста:<ul><li>standard;</li><li>metric;</li><li>criterion;</li><li>filter.</li></ul> | Строка

  {% endcut %}

- Запрос выполнен с ошибкой

  Если запрос не был успешно обработан, API возвращает ответ с кодом ошибки:

  {% include [error-400](../../../../_includes/tracker/api/answer-error-400.md) %}
  
  {% include [error-404](../../../../_includes/tracker/api/answer-error-404.md) %}
  
  {% include [error-422](../../../../_includes/tracker/api/answer-error-422.md) %}

{% endlist %}
