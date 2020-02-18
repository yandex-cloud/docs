# Метод listUploads

Возвращает список текущих составных загрузок.

Ответ не может содержать более 1000 элементов. Если загрузок больше, то {{ objstorage-name }} возвращает элемент `IsTruncated`, а также элементы `NextKeyMarker` и `NextUploadIdMarker`, которые необходимо использовать для параметров `key-marker` и `upload-id-​marker` последующего запроса.


## Запрос {#request}

```
GET /{bucket}?uploads HTTP/1.1
```

### Path параметры {#path-parameters}

Параметр | Описание
----- | -----
`bucket` | Имя бакета.


### Query параметры {#request-parameters}

Параметр | Описание
----- | -----
`delimiter` | Символ-разделитель.<br/><br/>Если параметр указан, то {{ objstorage-name }} рассматривает ключ как путь к файлу, где имена каталогов разделяются символом `delimiter`. На выходе пользователь увидит перечень <q>файлов</q> и <q>каталогов</q> в <q>корне</q> бакета. <q>Файлы</q> будут выведены в элементах `Uploads`, а <q>каталоги</q> в элементах `CommonPrefixes`.<br/><br/>Если в запросе указан еще и параметр `prefix`, то {{ objstorage-name }} вернет перечень <q>файлов</q> и <q>каталогов</q> в <q>каталоге</q>`prefix`.
`max-uploads` | Максимальное количество загрузок в ответе.<br/><br/>По умолчанию {{ objstorage-name }} выдает не более 1000 ключей. Этот параметр следует использовать, если вам нужно получать менее 1000 ключей в одном ответе.<br/><br/>Если под критерии отбора попадает больше ключей, чем поместилось в выдаче, то ответ содержит `<IsTruncated>true</IsTruncated>`.<br/><br/>Чтобы получить все объекты выдачи, если их больше `max-keys`, необходимо выполнить несколько последовательных запросов к {{ objstorage-name }} с параметром `key-marker`, где для каждого запроса `key-marker` равен значению элемента `NextKeyMarker` предыдущего ответа.
`key-marker` | Ключ. Выдача начнется с ключа, следующего за указанным в значении параметра.<br/><br/>Используется вместе с `upload-id-marker` для фильтрации выдачи.<br/><br/>Если `upload-id-marker` указан, то в выдачу попадет и `key-marker` тоже.
`prefix` | Строка, с которой должен начинаться ключ.<br/><br/>{{ objstorage-name }} выберет только те ключи, которые начинаются с `prefix`.
`upload-id-​marker` | Идентификатор загрузки.<br/><br/>Выдача начнется с той загрузки, идентификатор которой следует за указанной в параметре. При обработке учитывается `key-marker`, т.е. в выдачу попадут те загрузки для которых пересекутся фильтр по `upload-id-​marker` и фильтр по `key-marker`.<br/><br/>Если `key-marker` не указан, то `upload-id-​marker` игнорируется.
`uploads` | Флаг, обозначающий операцию составной загрузки.


### Заголовки {#request-headers}

Используйте в запросе необходимые [общие заголовки](../common-request-headers.md).


## Ответ {#response}

### Заголовки {#response-headers}

Ответ может содержать только [общие заголовки](../common-response-headers.md).

### Коды ответов {#response-codes}

Перечень возможных ответов смотрите в разделе [{#T}](../response-codes.md).

Успешный ответ содержит дополнительные данные в формате XML, схема которого описана ниже.

### Схема данных {#response-scheme}

```
<ListMultipartUploadsResult xmlns="http://s3.amazonaws.com/doc/2006-03-01/">
  <Bucket>bucket</Bucket>
  <KeyMarker></KeyMarker>
  <UploadIdMarker></UploadIdMarker>
  <NextKeyMarker>my-movie.m2ts</NextKeyMarker>
  <NextUploadIdMarker>YW55IGlkZWEgd2h5IGVsdmluZydzIHVwbG9hZCBmYWlsZWQ</NextUploadIdMarker>
  <MaxUploads>3</MaxUploads>
  <IsTruncated>true</IsTruncated>
  <Upload>
    <Key>my-divisor</Key>
    <UploadId>XMgbGlrZSBlbHZpbmcncyBub3QgaGF2aW5nIG11Y2ggbHVjaw</UploadId>
    <Initiator>
      <ID>arn:aws:iam::111122223333:user/user1-11111a31-17b5-4fb7-9df5-b111111f13de</ID>
      <DisplayName>user1-11111a31-17b5-4fb7-9df5-b111111f13de</DisplayName>
    </Initiator>
    <StorageClass>STANDARD</StorageClass>
    <Initiated>2010-11-10T20:48:33.000Z</Initiated>
  </Upload>
  <Upload>
    <Key>my-movie.m2ts</Key>
    <UploadId>VXBsb2FkIElEIGZvciBlbHZpbmcncyBteS1tb3ZpZS5tMnRzIHVwbG9hZA</UploadId>
    <Initiator>
      <ID>b1d16700c70b0b05597d7acd6a3f92be</ID>
      <DisplayName>InitiatorDisplayName</DisplayName>
    </Initiator>
    <StorageClass>COLD</StorageClass>
    <Initiated>2010-11-10T20:48:33.000Z</Initiated>
  </Upload>
  <Upload>
    <Key>my-movie.m2ts</Key>
    <UploadId>YW55IGlkZWEgd2h5IGVsdmluZydzIHVwbG9hZCBmYWlsZWQ</UploadId>
    <Initiator>
      <ID>arn:aws:iam::444455556666:user/user1-22222a31-17b5-4fb7-9df5-b222222f13de</ID>
      <DisplayName>user1-22222a31-17b5-4fb7-9df5-b222222f13de</DisplayName>
    </Initiator>
    <StorageClass>STANDARD</StorageClass>
    <Initiated>2010-11-10T20:49:33.000Z</Initiated>
  </Upload>
</ListMultipartUploadsResult>
```

Тег | Описание
----- | -----
`ListMultipartUploadsResult` | Корневой тег ответа.<br/><br/>Путь: `/ListMultipartUploadsResult`.
`Bucket` | Бакет, к которому относится составная загрузка.<br/><br/>Путь: `/ListMultipartUploadsResult/Bucket`.
`KeyMarker` | Ключ.<br/><br/>Выдача начинается с ключа, следующего за указанным в значении элемента.<br/><br/>Смотрите описание параметра запроса `key-marker`.<br/><br/>Путь: `/ListMultipartUploadsResult/KeyMarker`.
`UploadIdMarker` | Идентификатор загрузки.<br/><br/>Выдача начнется с той загрузки, идентификатор которой следует за указанной в параметре.<br/><br/>Смотрите описание параметра запроса `upload-id-​marker`.<br/><br/>Путь: `/ListMultipartUploadsResult/UploadIdMarker`.
`NextKeyMarker` | Ключ.<br/><br/>Если выдача не вместила все элементы, которые должен получить пользователь, то это значение необходимо использовать в параметре `key-marker` для последующих запросов.<br/><br/>Присутствует в случае, когда в ответ не поместился все элементы.<br/><br/>Путь: `/ListMultipartUploadsResult/NextKeyMarker`.
`NextUploadIdMarker` | Идентификатор загрузки.<br/><br/>Если выдача не вместила все элементы, которые должен получить пользователь, то это значение необходимо использовать в параметре `upload-id-marker` для последующих запросов.<br/><br/>Присутствует в случае, когда в ответ не поместились все элементы.<br/><br/>Путь: `/ListMultipartUploadsResult/NextUploadMarker`.
`Encoding-Type` | Кодировка, в которой {{ objstorage-name }} представляет ключ в XML-ответе.<br/><br/>Смотрите описание параметра запроса `encoding-type`.<br/><br/>Путь: `/ListMultipartUploadsResult/Encoding-Type`.
`MaxUploads` | Максимальная длина списка для одного ответа.<br/><br/>Смотрите параметр запроса `max-uploads`.<br/><br/>Путь: `/ListMultipartUploadsResult/MaxUploads`.
`IsTruncated` | Признак неполноты списка.<br/><br/>Если `IsTruncated` — `true`, то это означает, что {{ objstorage-name }} вернуло не полный список загрузок.<br/><br/>Путь: `/ListMultipartUploadsResult/IsTruncated`.
`Upload` | Описание загрузки.<br/><br/>Путь: `/ListMultipartUploadsResult/Upload`.
`Key` | Ключ конечного объекта загрузки.<br/><br/>Путь: `/ListMultipartUploadsResult/Upload/Key`.
`UploadId` | Идентификатор составной загрузки.<br/><br/>Путь: `/ListMultipartUploadsResult/Upload/UploadId`.
`Initiator` | Инициатор составной загрузки.<br/><br/>Путь: `/ListMultipartUploadsResult/Upload/Initiator`.
`ID` | Идентификатор пользователя.<br/><br/>Возможные пути:<br/>- `/ListMultipartUploadsResult/Upload/Initiator/ID`
`DisplayName` | Отображаемое имя пользователя.<br/><br/>Возможные пути:<br/>- `/ListMultipartUploadsResult/Upload/Initiator/DisplayName`
`StorageClass` | Класс хранения объекта: `STANDARD` или `COLD`.<br/><br/>Путь: `/ListMultipartUploadsResult/Upload/StorageClass`.
`Initiated` | Дата и время запроса на [начало составной загрузки](startupload.md).
`/ListMultipartUploadsResult/Prefix` | Префикс ключа.<br/><br/>Смотрите параметр запроса `prefix`.<br/><br/>Путь: `/ListMultipartUploadsResult/Prefix`.
`Delimiter` | Символ-разделитель, который использовался при формировании выдачи.<br/><br/>Смотрите описание параметра запроса `delimiter`.<br/><br/>Путь: `/ListMultipartUploadsResult/Delimiter`.
`CommonPrefixes` | Содержит элемент `Prefix`.<br/><br/>Путь: `/ListMultipartUploadsResult/CommonPrefixes`.
`CommonPrefixes/Prefix` | Часть имени ключа, которая определяется при обработке параметров запроса `delimiter` и `prefix`.<br/><br/>Путь: `/ListMultipartUploadsResult/CommonPrefixes/Prefix`.
