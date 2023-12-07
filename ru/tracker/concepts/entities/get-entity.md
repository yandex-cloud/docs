---
sourcePath: ru/tracker/api-ref/concepts/entities/get-entity.md
---
# Получить параметры сущности

Запрос позволяет получить информацию о сущности — [проекте](../../manager/project-new.md) или [портфеле проектов](../../manager/portfolio.md).

Запрос представляет унифицированный метод для получения информации о проектах и портфелях, расширяющий возможности API [получения информации о проектах](../projects/get-project.md).

## Формат запроса {#query}

Перед выполнением запроса [получите доступ к API](../access.md).

Чтобы получить параметры сущности, используйте HTTP-запрос с методом `GET`.

```
GET /{{ ver }}/entities/<entityType>/<entityId>?expand=attachments&fields=summary,teamAccess
Host: {{ host }}
Authorization: OAuth <OAuth-токен>
{{ org-id }}
```

{% include [headings](../../../_includes/tracker/api/headings.md) %}

{% cut "Ресурс" %}

**Ресурс**

Параметр | Описание | Тип данных
-------- | -------- | ----------
\<entityType> | Идентификатор сущности:<ul><li>project — проект;</li><li>portfolio — портфель.</li></ul>| Строка
\<entityId> | Идентификатор сущности. | Строка

{% note warning %}

Идентификатор сущности не совпадает с идентификатором проекта или портфеля.

{% endnote %}  

{% endcut %}  

{% cut "Параметры запроса" %}

**Дополнительные параметры**

Параметр | Описание | Тип данных
-------- | -------- | ----------
expand | Дополнительная информация, которая будет включена в ответ:<ul><li>`attachments` – вложенные файлы.</li></ul> | Строка
fields |  Дополнительные поля сущности, которые будут включены в ответ. | Строка

{% endcut %}

> Пример: Получить информацию о портфеле
> 
> - Используется HTTP-метод GET.
> - В ответе включено отображение вложений.
> - В ответ включено поле `teamAccess`.
>
> ```
> GET /v2/entities/portfolio/655f328da834c763********?expand=attachments,fields=teamAccess HTTP/1.1
> Host: {{ host }}
> Authorization: OAuth <OAuth-токен>
> {{ org-id }}
> 
> ```

## Формат ответа {#answer}

{% list tabs %}

- Запрос выполнен успешно

   {% include [answer-200](../../../_includes/tracker/api/answer-200.md) %}

   Тело ответа содержит информацию о сущности в формате JSON.

   ```json
   {
      "self": "{{ host }}/{{ ver }}/entities/project/655f328da834c763********",
      "id": "655f328da834c763********",
      "version": 3,
      "shortId": 2,
      "entityType": "project",
      "createdBy": { "self": "{{ host }}/{{ ver }}/users/1111111117", "id": "1111111117", "display": "Имя Фамилия", "cloudUid": "ajevuhegoggf********", "passportUid": 1111111117 },
      "createdAt": "2023-11-23T11:07:57.298+0000",
      "updatedAt": "2023-11-23T15:46:26.391+0000",
      "attachments": [
         {
            "self": "{{ host }}/{{ ver }}/attachments/8",
            "id": "8",
            "name": "file1.docx",
            "content": "{{ host }}/{{ ver }}/attachments/8/file1.docx",
            "createdBy": { "self": "{{ host }}/{{ ver }}/users/1111111117", "id": "1111111117", "display": "Имя Фамилия", "cloudUid": "ajevuhegoggf********", "passportUid": 1111111117 },
            "createdAt": "2023-11-23T15:46:20.617+0000",
            "mimetype": "application/vnd.openxmlformats-officedocument.wordprocessingml.document",
            "size": 18585
         },
         {
            "self": "{{ host }}/{{ ver }}/attachments/9",
            "id": "9",
            "name": "file2.pdf",
            "content": "{{ host }}/{{ ver }}/attachments/9/file2.pdf",
            "createdBy": { "self": "{{ host }}/{{ ver }}/users/1111111117", "id": "1111111117", "display": "Имя Фамилия", "cloudUid": "ajevuhegoggf********", "passportUid": 1111111117 },
            "createdAt": "2023-11-23T15:46:25.932+0000",
            "mimetype": "application/pdf",
            "size": 175656
         }
      ],
      "fields":
      {
         "teamAccess":null
      }
   }
   ```

   {% cut "Параметры ответа" %}

   Параметр | Описание | Тип данных
   -------- | -------- | ----------
   self | Адрес ресурса API, который содержит информацию о проекте. | Строка
   id | Идентификатор сущности. | Строка
   version | Версия сущности. Каждое изменение параметров увеличивает номер версии. | Число
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
    
   {% include [answer-error-404](../../../_includes/tracker/api/answer-error-404.md) %}

{% endlist %}