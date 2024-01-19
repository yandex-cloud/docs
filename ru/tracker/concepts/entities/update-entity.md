---
sourcePath: ru/tracker/api-ref/concepts/entities/update-entity.md
---
# Изменить сущность

Запрос позволяет обновить информацию о сущности — [проекте](../../manager/project-new.md) или [портфеле проектов](../../manager/portfolio.md).

Запрос представляет унифицированный метод обновления информации о проектах и портфелях, более гибкий и функциональный, чем API [обновления информации о проектах](../projects/update-project.md).

## Формат запроса {#query}

Перед выполнением запроса [получите доступ к API](../access.md).

Чтобы изменить сущность, используйте HTTP-запрос с методом `PATCH`. Параметры запроса передаются в его теле в формате JSON.

```json
PATCH /{{ ver }}/entities/<entityType>/<entityId>
Host: {{ host }}
Authorization: OAuth <OAuth-токен>
{{ org-id }}

{
   "fields": 
   {
      "summary": "<новое_название>",
      "teamAcceess": true
   },
   "comment":"<комментарий>",
   "links":
   [
      {
         "relationship": "<связь>", 
         "entity": "<идентификатор_связанной_сущности>"
      }
   ]
}
```

{% include [headings](../../../_includes/tracker/api/headings.md) %}

{% include [resource](../../../_includes/tracker/api/resource-entity.md) %}

{% cut "Параметры запроса" %}

**Дополнительные параметры**

Параметр | Описание | Тип данных
-------- | -------- | ----------
[fields](./about-entities.md#query-params) |  Дополнительные поля сущности, которые будут включены в ответ. | Строка
expand | Дополнительная информация, которая будет включена в ответ:<ul><li>`attachments` – вложенные файлы.</li></ul> | Строка

{% endcut %}

{% cut "Параметры тела запроса" %}

**Дополнительные параметры**

Параметр | Описание | Тип данных
-------- | -------- | ----------
[fields](./about-entities.md#query-body-params) | Объект с настройками сущности. | Объект
comment | Комментарий. | Строка
links | Массив объектов с настройками связей с другими сущностями. | Массив объектов

**Поля объекта** `fields`

Параметр | Описание | Тип данных
-------- | -------- | ----------
summary | Название (обязательное поле). | Строка
queues | Очередь (обязательное для проекта, если не указано поле `teamAccess`). | Строка
teamAccess | Доступ (обязательное для проекта, если не указано поле `queues`). | Логический
description | Описание. | Строка
author | Автор (идентификатор пользователя). | Число
lead | Ответственный (идентификатор пользователя). | Число
teamUsers | Участники (массив идентификаторов пользователей). | Массив чисел
clients | Заказчики (массив идентификаторов пользователей). | Массив чисел
followers | Наблюдатели (массив идентификаторов пользователей). | Массив чисел
start | Дата начала в формате `YYYY-MM-DDThh:mm:ss.sss±hhmm`. | Дата
end | Дедлайн в формате `YYYY-MM-DDThh:mm:ss.sss±hhmm`. | Дата
tags | Теги. | Массив строк
parentEntity | Идентификатор родительской сущности (портфеля). | Число
entityStatus | Статус:<ul><li>draft — Черновик;</li><li>in_progress — В работе;</li><li>launched — Новый;</li><li>postponed — Отложен;</li><li>at_risk — Есть риски;</li><li>blocked — Заблокирован;</li><li>according_to_plan — По плану.</li></ul>| Строка

**Поля объектов массива** `links`

Параметр | Описание | Тип данных
-------- | -------- | ----------
relationship | Тип связи. Например:<ul><li>`relates`;</li><li>`is dependent by`;</li><li>`depends on`.</li></ul>. | Строка
entity | Идентификатор связанной сущности. | Строка

{% endcut %}

> Пример: Изменить название проекта и оставить комментарий
> 
> - Используется HTTP-метод PATCH.
> - Название проекта меняется на <q>Test 2</q>.
> - В комментарии проекта добавляется запись <q>Проект переименован</q>.
> - В ответе включено отображение вложений.
> 
> ```
> PATCH /v2/entities/project/655f8cc523db213********?expand=attachments HTTP/1.1
> Host: {{ host }}
> Authorization: OAuth <OAuth-токен>
> {{ org-id }}
> 
> {
>     "fields":
>     {
>        "summary":"Test 2", 
>     },
>     "comment":"Проект переименован"
> }
> ```

## Формат ответа {#answer}

{% list tabs %}

- Запрос выполнен успешно

   {% include [answer-200](../../../_includes/tracker/api/answer-200.md) %}

   Тело ответа содержит информацию об измененной сущности в формате JSON.

   ```json
   {
      "self": "https://{{ host }}/{{ ver }}/entities/project/655f328da834c763********",
      "id": "655f328da834c763********",
      "version": 3,
      "shortId": 2,
      "entityType": "project",
      "createdBy": { "self": "https://{{ host }}/{{ ver }}/users/1111111117", "id": "1111111117", "display": "Имя Фамилия", "cloudUid": "ajevuhegoggf********", "passportUid": 1111111117 },
      "createdAt": "2023-11-23T11:07:57.298+0000",
      "updatedAt": "2023-11-23T15:46:26.391+0000",
      "attachments": [
         {
            "self": "https://{{ host }}/{{ ver }}/attachments/8",
            "id": "8",
            "name": "file1.docx",
            "content": "{{ host }}/{{ ver }}/attachments/8/file1.docx",
            "createdBy": { "self": "https://{{ host }}/{{ ver }}/users/1111111117", "id": "1111111117", "display": "Имя Фамилия", "cloudUid": "ajevuhegoggf********", "passportUid": 1111111117 },
            "createdAt": "2023-11-23T15:46:20.617+0000",
            "mimetype": "application/vnd.openxmlformats-officedocument.wordprocessingml.document",
            "size": 18585
         },
         {
            "self": "https://{{ host }}/{{ ver }}/attachments/9",
            "id": "9",
            "name": "file2.pdf",
            "content": "{{ host }}/{{ ver }}/attachments/9/file2.pdf",
            "createdBy": { "self": "https://{{ host }}/{{ ver }}/users/1111111117", "id": "1111111117", "display": "Имя Фамилия", "cloudUid": "ajevuhegoggf********", "passportUid": 1111111117 },
            "createdAt": "2023-11-23T15:46:25.932+0000",
            "mimetype": "application/pdf",
            "size": 175656
         }
      ]
   }
   ```

   {% cut "Параметры ответа" %}

   Параметр | Описание | Тип данных
   -------- | -------- | ----------
   self | Адрес ресурса API, который содержит информацию о проекте. | Строка
   id | Идентификатор сущности. | Строка
   version | Версия проекта. Каждое изменение параметров увеличивает номер версии. | Число
   shortId | Идентификатор проекта или портфеля. | Строка
   entityType | Тип сущности. | Строка
   createdBy | Блок с информацией о создателе сущности. | Объект
   createdAt | Дата создания сущности в формате `YYYY-MM-DDThh:mm:ss.sss±hhmm`. | Строка
   updatedAt | Дата последнего обновления сущности в формате `YYYY-MM-DDThh:mm:ss.sss±hhmm`. | Строка
   attachments | Массив объектов с информацией о вложении. | Массив объектов
   
   **Поля объекта** `createdBy`
    
   Параметр | Описание | Тип данных
   -------- | -------- | ----------
   self | Адрес ресурса API, который содержит информацию о создателе сущности. | Строка
   id | Идентификатор пользователя. | Число
   display | Отображаемое имя пользователя. | Строка
   cloudUid | Уникальный идентификатор пользователя в {{ org-full-name }}. | Строка
   passportUid | Уникальный идентификатор аккаунта пользователя в организации {{ ya-360 }} и Яндекс ID. | Строка

   {% endcut %}

- Запрос выполнен с ошибкой

    Если запрос не был успешно обработан, API возвращает ответ с кодом ошибки:

    {% include [answer-error-400](../../../_includes/tracker/api/answer-error-400.md) %}

    {% include [answer-error-401](../../../_includes/tracker/api/answer-error-401.md) %}

    {% include [answer-error-403](../../../_includes/tracker/api/answer-error-403.md) %}
    
    {% include [answer-error-412](../../../_includes/tracker/api/answer-error-412.md) %}

    {% include [answer-error-428](../../../_includes/tracker/api/answer-error-428.md) %}


{% endlist %}