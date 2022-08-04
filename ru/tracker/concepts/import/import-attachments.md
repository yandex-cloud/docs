---
sourcePath: ru/tracker/api-ref/concepts/import/import-attachments.md
---
# Импортировать файлы

{% note warning %}

Запрос может быть выполнен только если у пользователя есть право на изменение задачи, к которой прикреплены файлы.

{% endnote %}

С помощью запроса вы можете вы можете импортировать в {{ tracker-name }} файлы, прикрепленные к задаче и комментариям под ней.

## Формат запроса {#section_i14_lyb_p1b}

Чтобы импортировать файл, используйте HTTP-запрос с методом `POST`. Файл передается в теле запроса с использованием `multipart/form-data`[RFC-7578]({{ link-rfc7578 }}). Размер файла не должен превышать 1024 Мбит.

{% list tabs %}

- Прикрепить файл к задаче
   
    ```json
    POST /{{ ver }}/issues/<issue_id>/attachments/_import?filename={filename}&createdAt={createdAt}&createdBy={createdBy} 
    Host: {{ host }}
    Authorization: OAuth <токен>
    {{ org-id }}
    Content-Type: multipart/form-data
    <file_data>
    ```
    {% include [headings-content-multi-data](../../../_includes/tracker/api/headings-content-multi-data.md) %}

    {% cut "Ресурс" %}
       
    Параметр | Описание | Тип данных
    --- | --- | ---
    \<issues-id\> | Ключ задачи, к которой будет прикреплен файл. | Строка
    \<comment_id\> | Идентификатор комментария, к которому будет прикреплен файл. | Строка

    {% endcut %}

    {% cut "Параметры запроса" %}

    **Обязательные параметры**

    Параметр | Описание | Тип данных
    --- | --- | ---
    filename | Имя файла, максимальная длина - 255 символов. | Строка
    createdAt | Дата и время прикрепления файла в формате `YYYY-MM-DDThh:mm:ss.sss±hhmm`. Вы можете указать любое значение в интервале времени от создания до последнего обновления задачи. | Строка
    createdBy | Логин или идентификатор автора прикрепленного файла. | Строка

    {% endcut %}

    {% cut "Параметры тела запроса" %}

    **Обязательные параметры**

    Параметр | Описание | Тип данных
    --- | --- | ---
    file_data | Файл в бинарном формате. Размер файла не должен превышать 1024 Мбит. | Строка

    {% endcut %}

- Прикрепить файл к комментарию

    ```json
    POST /{{ ver }}/issues/<issue_id>/comments/<comment_id>/attachments/_import?filename={filename}&createdAt={createdAt}&createdBy={createdBy} 
    Host: {{ host }}
    Authorization: OAuth <токен>
    {{ org-id }}
    Content-Type: multipart/form-data
    <file_data>
    ```

    {% include [headings-content-multi-data](../../../_includes/tracker/api/headings-content-multi-data.md) %}

    {% cut "Ресурс" %}

    Параметр | Описание | Тип данных
    --- | --- | ---
    \<issues-id\> | Ключ задачи, к которой будет прикреплен файл. | Строка
    \<comment_id\> | Идентификатор комментария, к которому будет прикреплен файл. | Строка

    {% endcut %}

    {% cut "Параметры запроса" %}

    **Обязательные параметры**

    Параметр | Описание | Тип данных
    --- | --- | ---
    filename | Имя файла, максимальная длина - 255 символов. | Строка
    createdAt | Дата и время прикрепления файла в формате `YYYY-MM-DDThh:mm:ss.sss±hhmm`. Вы можете указать любое значение в интервале времени от создания до последнего обновления задачи. | Строка
    createdBy | Логин или идентификатор автора прикрепленного файла. | Строка

    {% endcut %}

    {% cut "Параметры тела запроса" %}

    **Обязательные параметры**

    Параметр | Описание | Тип данных
    --- | --- | ---
    \<file_data\> | Файл в бинарном формате. Размер файла не должен превышать 1024 Мбит. | Строка

    {% endcut %}

{% endlist %}

## Формат ответа {#section_xc3_53j_p1b}

{% list tabs %}

- Запрос выполнен успешно

    {% include [answer-200](../../../_includes/tracker/api/answer-200.md) %} 
    
    Тело ответа содержит параметры прикрепленного файла в формате JSON:

    ```json
	{
	  "self" : "{{ host }}/v2/issues/JUNE-2/attachments/123",
      "id" : "123",
      "name" : "pic.png",
      "content" : "{{ host }}/v2/issues/JUNE-2/attachments/123/pic.png",
      "thumbnail" : "{{ host }}/v2/issues/JUNE-2/thumbnails/123",
	  "createdBy" : {
		"self" : "{{ host }}/v2/users/12314567890",
		"id" : "1234567890",
		"display" : "<отображаемое имя сотрудника>"
	  },
	  "createdAt" : "2017-06-11T05:16:01.339+0000",
	  "mimetype" : "image/png",
	  "size" : 5678
	  "metadata" : {
		"size" : "128x128"
	  }
	}
    ```
    
    {% cut "Параметры ответа" %}
    
    Параметр | Описание | Тип данных
    -------- | -------- | ----------
    self | Адрес ресурса API, который соответствует прикрепленному файлу. | Строка
    id | Уникальный идентификатор файла. | Строка
    name | Имя файла. | Строка
    content | Адрес ресурса для скачивания файла. | Строка
    thumbnail | Адрес ресурса для скачивания миниатюры предпросмотра. Доступно только для графических файлов. | Строка
    [createdBy](#createdBy) | Объект с информацией о пользователе, прикрепившем файл. | JSON-объект
    createdAt | Дата и время загрузки файла в формате:<br/>``` YYYY-MM-DDThh:mm:ss.sss±hhmm ``` | Строка
    mimetype | Тип файла, например:<ul><li>`text/plain` — текстовый файл;</li><li>`image/png` — изображение в формате png.</li></ul> | Строка
    size | Размер файла в байтах. | Целое число
    [metadata](#metadata) | Объект с метаданными файла. | JSON-объект

    **Поля объекта** `createdBy` {#createdBy}
    
    Параметр | Описание | Тип данных
    -------- | -------- | ----------
    self | Адрес ресурса, соответствующего пользователю, загрузившему файл. | Строка
    id | Логин пользователя. | Строка
    display | Имя пользователя (как в интерфейсе). | Строка


    **Поля объекта** `metadata` {#metadata}

    Параметр | Описание | Тип данных
    -------- | -------- | ----------
    size | Размер изображения в пикселях. | Строка

    {% endcut %}

- Запрос выполнен с ошибкой

    Если запрос не был успешно обработан, ответное сообщение содержит информацию о возникших ошибках:

    {% include [error](../../../_includes/tracker/api/answer-error-400.md) %}

    {% include [error](../../../_includes/tracker/api/answer-error-403.md) %}

    {% include [error](../../../_includes/tracker/api/answer-error-404.md) %}
    
    {% include [error](../../../_includes/tracker/api/answer-error-413.md) %}

    {% include [error](../../../_includes/tracker/api/answer-error-422.md) %}

    {% include [error](../../../_includes/tracker/api/answer-error-500.md) %}

    {% include [error](../../../_includes/tracker/api/answer-error-503.md) %}

{% endlist %}