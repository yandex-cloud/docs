# Метод completeUpload

Запрос завершает составную загрузку.

При получении запроса {{ objstorage-name }}:

- Собирает конечный объект из полученных в процессе загрузки частей в порядке их номеров
- Удаляет идентификатор загрузки, так что все последующие запросы с идентификатором загрузки вернут ошибку `NoSuchUpload`.

При завершении загрузки клиент должен предоставить список частей, которые он отправлял. Описание каждой части должно содержать `ETag`, который клиент получает в ответ на каждую загруженную часть. Смотрите раздел [{#T}](uploadpart.md).

В зависимости от размера объекта и количества частей операция может занять несколько минут.

Если запрос завершился с ошибкой, то клиентское приложение должно быть готово повторить запрос.


## Запрос {#request}

```
POST /{bucket}/{key}?uploadId=UploadId HTTP/2
```

### Path параметры {#path-parameters}

Параметр | Описание
----- | -----
`bucket` | Имя бакета.
`key` | Ключ объекта.


### Query параметры {#request-parameters}

Параметр | Описание
----- | -----
`uploadId` | Идентификатор составной загрузки, который {{ objstorage-name }} вернул при [инициализации](startupload.md).


### Заголовки {#request-headers}

Используйте в запросе необходимые [общие заголовки](../common-request-headers.md).

### Схема данных {#request-scheme}

Список частей составной загрузки передается в виде XML-файла следующего формата:

```
<CompleteMultipartUpload>
  <Part>
    <PartNumber>PartNumber</PartNumber>
    <ETag>ETag</ETag>
  </Part>
  ...
</CompleteMultipartUpload>
```

Тег | Описание
----- | -----
`CompleteMultipartUpload` | Данные запроса.<br/><br/>Путь: `/CompleteMultipartUpload`.
`Part` | Данные о загруженной части объекта.<br/><br/>Путь: `/CompleteMultipartUpload/Part`.
`PartNumber` | Номер части.<br/><br/>Уникальный идентификатор, определяющий положение части среди других частей в загрузке.<br/><br/>Путь: `/CompleteMultipartUpload/Part/PartNumber`.
`ETag` | Идентификатор, который клиент получил от {{ objstorage-name }} в ответ на загрузку части.<br/><br/>Путь: `/CompleteMultipartUpload/Part/ETag`.

## Ответ {#response}

### Заголовки {#response-headers}

Ответ может содержать только [общие заголовки](../common-response-headers.md).

### Коды ответов {#response-codes}

Перечень возможных ответов смотрите в разделе [{#T}](../response-codes.md).

Дополнительно, {{ objstorage-name }} может вернуть ошибки, описанные в таблице ниже.

Ошибка | Описание | HTTP-код
----- | ----- | -----
`NoSuchUpload` | Указанная загрузка не существует. Возможно указан неверный идентификатор загрузки или загрузка была завершена или удалена. | 404 Not Found
`InvalidPart` | Некоторые из указанных частей не найдены.<br/><br/>Возможные причины:<br/>- Части не загружены.<br/>- Переданный `ETag` не совпадает с сохраненным. | 400 Bad Request
`InvalidPartOrder` | Список частей передан не в упорядоченном по возрастанию виде.<br/><br/>Список должен быть отсортирован по возрастанию по номерам частей. | 400 Bad Request


Успешный ответ содержит дополнительные данные в формате XML, схема которого описана ниже.

### Схема данных {#request-scheme}

```
<CompleteMultipartUploadResult xmlns="http://s3.amazonaws.com/doc/2006-03-01/">
  <Location>http://Example-Bucket.{{ s3-storage-host }}/Example-Object</Location>
  <Bucket>Example-Bucket</Bucket>
  <Key>Example-Object</Key>
  <ETag>"3858f62230ac3c915f300c664312c11f-9"</ETag>
</CompleteMultipartUploadResult>
```

Тег | Описание
----- | -----
`CompleteMultipartUploadResult` | Данные ответа.<br/><br/>Путь: `/CompleteMultipartUploadResult`.
`Location` | URI созданного в результате загрузки объекта.<br/><br/>Путь: `/CompleteMultipartUploadResult/Location`.
`Bucket` | Имя бакета, в котором находится объект.<br/><br/>Путь: `/CompleteMultipartUploadResult/Bucket`.
`Key` | Ключ созданного объекта.<br/><br/>Путь: `/CompleteMultipartUploadResult/Key`.
`ETag` | Хэш объекта.<br/><br/>ETag может быть, а может и не быть MD5.<br/><br/>Путь: `/CompleteMultipartUploadResult/ETag`.

{% include [the-s3-api-see-also-include](../../../../_includes/storage/the-s3-api-see-also-include.md) %}