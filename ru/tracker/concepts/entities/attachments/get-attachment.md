---
sourcePath: ru/tracker/api-ref/concepts/entities/attachments/get-attachment.md
---
# Получить информацию о прикрепленном файле

Запрос позволяет получить информацию о файле, прикрепленному к [сущности](../about-entities.md).

## Формат запроса {#query}

Перед выполнением запроса [получите доступ к API](../../access.md).

Чтобы получить информацию о прикрепленном файле, используйте HTTP-запрос с методом `GET`.

```json
GET /{{ ver }}/entities/<entityType>/<id>/attachments/<attachmentId>
Host: {{ host }}
Authorization: OAuth <OAuth-токен>
{{ org-id }}
```

{% include [headings](../../../../_includes/tracker/api/headings.md) %}

{% include [resource](../../../../_includes/tracker/api/resource-entity-attach.md) %}

> Пример: Получить информацию о прикрепленном файле
>
> - Используется HTTP-метод GET.
> - В ответе выводится информация о прикрепленном файле сущности.
>
> ```
> GET /v2/entities/project/6586d6fee2b9ef74********/attachments/5
> Host: {{ host }}
> Authorization: OAuth <OAuth-токен>
> {{ org-id }}
> ```

## Формат ответа {#answer}

{% list tabs %}

- Запрос выполнен успешно

  {% include [answer-200](../../../../_includes/tracker/api/answer-200.md) %}

  Тело ответа содержит информацию о прикрепленном файле сущности в формате JSON.

  ```json
  {
      "self": "{{ host }}/v2/attachments/5", 
      "id": "5", 
      "name": "flowers.jpg", 
      "content": "{{ host }}/v2/attachments/5/flowers.jpg",
      "createdBy": {
          "self": "{{ host }}/v2/users/1990********",
          "id": "id_сотрудника",
          "display": "Имя_Фамилия",
          "cloudUid": "ajeppa7dgp53********",
          "passportUid": "15********"
      },
      "createdAt": "2024-01-11T06:24:57.635+0000", 
      "mimetype": "image/jpeg", 
      "size": 20466, 
      "metadata": {
          "size": "236x295"
      }
  }
  ```

  {% cut "Параметры ответа" %}

  Параметр | Описание | Тип данных
  ----- | ----- | -----
  self | Адрес ресурса API, который содержит информацию о прикрепленных файлах сущности. | Строка
  id | Идентификатор файла. | Строка
  name | Имя файла. | Строка
  content | Адрес ресурса для скачивания файла. | Строка
  thumbnail | Адрес ресурса для скачивания миниатюры предпросмотра. Доступно только для графических файлов. | Строка
  [createdBy](#created-by) | Объект с информацией о пользователе, прикрепившем файл. | Объект
  createdAt | Дата и время загрузки файла в формате `YYYY-MM-DDThh:mm:ss.sss±hhmm`. | Строка
  mimetype | Тип файла, например:<ul><li>`text/plain` — текстовый файл;</li><li>`image/png` — изображение в формате png.</li></ul> | Строка
  size | Размер файла в байтах. | Целое число
  [metadata](#metadata) | Объект с метаданными файла. | Объект

  **Поля объекта** `createdBy` {#created-by}

  Параметр | Описание | Тип данных
  ----- | ----- | -----
  self | Адрес ресурса API, который содержит информацию о пользователе. | Строка
  id | Идентификатор пользователя. | Число
  display | Отображаемое имя пользователя. | Строка
  cloudUid | Уникальный идентификатор пользователя в {{ org-full-name }}. | Строка
  passportUid | Уникальный идентификатор аккаунта пользователя в организации {{ ya-360 }} и Яндекс ID. | Строка

  **Поля объекта** `metadata` {#metadata}

  Параметр | Описание | Тип данных
  ----- | ----- | -----
  size | Размер изображения в пикселях. | Строка

  {% endcut %}

- Запрос выполнен с ошибкой

  Если запрос не был успешно обработан, API возвращает ответ с кодом ошибки:

  {% include [error-400](../../../../_includes/tracker/api/answer-error-400.md) %}
  
  {% include [error-404](../../../../_includes/tracker/api/answer-error-404.md) %}
  
  {% include [error-422](../../../../_includes/tracker/api/answer-error-422.md) %}

{% endlist %}
