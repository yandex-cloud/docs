# Метод listParts

Возвращает список уже загруженных частей для указанной составной загрузки.

Ответ не может содержать более 1000 элементов. Если в составной загрузке больше частей, то [!KEYREF objstorage-name] возвращает маркер `IsTruncated` и элемент `NextPartNumberMarker`. Оставшиеся элементы можно получить последовательными запросами, в которых параметр `part-number-marker` равен `NextPartNumberMarker` из предыдущего запроса.


## Запрос {#request}

```
GET /{bucket}/{key}?uploadId=UploadId HTTP/1.1
```

### Path параметры {#path-parameters}

Параметр | Описание
----- | -----
`bucket` | Имя корзины.
`key` | Ключ объекта.


### Query параметры {#request-parameters}

Изменить ответ от [!KEYREF objstorage-name] можно параметрами, описанными в таблице ниже.

Параметр | Описание
----- | -----
`encoding-type` | Кодировка ответа от сервера.<br/><br/>[!KEYREF objstorage-name] по требованию клиента может закодировать ответ в требуемом виде.
`max-parts` | Максимальное количество элементов в ответе за один запрос.<br/><br/>По умолчанию 1000.
`part-number​-marker` | Номер части, с которого должен начинаться ответ.<br/><br/>[!KEYREF objstorage-name] включит в ответ только части, номера которых больше указанного.
`uploadId` | Идентификатор составной загрузки.


Обязателен только параметр `uploadId`.

### Заголовки {#request-headers}

Используйте в запросе необходимые [общие заголовки](../common-request-headers.md).


## Ответ {#response}

### Заголовки {#response-headers}

Ответ может содержать только [общие заголовки](../common-response-headers.md).

### Коды ответов {#response-codes}

Перечень возможных ответов смотрите в разделе [[!TITLE]](../response-codes.md).

Успешный ответ содержит дополнительные данные в формате XML, схема которого описана ниже.

### Схема данных {#response-scheme}

```
<ListPartsResult xmlns="http://s3.amazonaws.com/doc/2006-03-01/">
  <Bucket>example-bucket</Bucket>
  <Key>example-object</Key>
  <UploadId>XXBsb2FkIElEIGZvciBlbHZpbmcncyVcdS1tb3ZpZS5tMnRzEEEwbG9hZA</UploadId>
  <Initiator>
      <ID>arn:aws:iam::111122223333:user/some-user-11116a31-17b5-4fb7-9df5-b288870f11xx</ID>
      <DisplayName>umat-user-11116a31-17b5-4fb7-9df5-b288870f11xx</DisplayName>
  </Initiator>
  <Owner>
    <ID>75aa57f09aa0c8caeab4f8c24e99d10f8e7faeebf76c078efc7c6caea54ba06a</ID>
    <DisplayName>someName</DisplayName>
  </Owner>
  <StorageClass>STANDARD</StorageClass>
  <PartNumberMarker>1</PartNumberMarker>
  <NextPartNumberMarker>3</NextPartNumberMarker>
  <MaxParts>2</MaxParts>
  <IsTruncated>true</IsTruncated>
  <Part>
    <PartNumber>2</PartNumber>
    <LastModified>2010-11-10T20:48:34.000Z</LastModified>
    <ETag>"7778aef83f66abc1fa1e8477f296d394"</ETag>
    <Size>10485760</Size>
  </Part>
  <Part>
    <PartNumber>3</PartNumber>
    <LastModified>2010-11-10T20:48:33.000Z</LastModified>
    <ETag>"aaaa18db4cc2f85cedef654fccc4a4x8"</ETag>
    <Size>10485760</Size>
  </Part>
</ListPartsResult>
```

Возможные теги ответа описаны в таблице ниже.

Тег | Описание
----- | -----
`ListPartsResult` | Корневой элемент ответа.<br/><br/>Путь: `/ListPartsResult`.
`Bucket` | Корзина, к которой относится составная загрузка.<br/><br/>Путь: `/ListPartsResult/Bucket`.
`Encoding-Type` | Кодировка, в которой [!KEYREF objstorage-name] представляет ключ в XML-ответе.<br/><br/>Появляется, если клиент при запросе передал параметр `encoding-type`.<br/><br/>Путь: `/ListPartsResult/Encoding-Type`.
`Key` | Ключ, для которого производится составная загрузка.<br/><br/>Путь: `/ListPartsResult/Key`.
`UploadId` | Идентификатор составной загрузки.<br/><br/>Путь: `/ListPartsResult/UploadId`.
`Initiator` | Информация о пользователе, инициировавшем загрузку.<br/><br/>Путь: `/ListPartsResult/Initiator`.
`ID` | Идентификатор пользователя.<br/><br/>Путь: `/ListPartsResult/Initiator/ID`.
`DisplayName` | Отображаемое имя пользователя.<br/><br/>Путь: `/ListPartsResult/Initiator/DisplayName`.
`Owner` | Владелец объекта.<br/><br/>Путь: `/ListPartsResult/Owner`.
`StorageClass` | Класс хранения объекта: `STANDARD` или `COLD`.<br/><br/>Путь: `/ListPartsResult/StorageClass`.
`PartNumberMarker` | Номер части, после которого начинается список.<br/><br/>Первый элемент списка имеет номер, следующий за `PartNumberMarker`.<br/><br/>Путь: `/ListPartsResult/PartNumberMarker`.
`NextPartNumberMarker` | Номер части, которым заканчивается текущий список.<br/><br/>Присутствует в случае, когда в ответ не поместился весь перечень частей.<br/><br/>Путь: `/ListPartsResult/NextPartNumberMarker`.
`MaxParts` | Максимальная длина списка для одного ответа.<br/><br/>Путь: `/ListPartsResult/MaxParts`.
`IsTruncated` | Признак неполноты списка.<br/><br/>Если `IsTruncated` — `true`, то это означает, что [!KEYREF objstorage-name] вернул не полный список частей.<br/><br/>Путь: `/ListPartsResult/IsTruncated`.
`Part` | Описание части загрузки.<br/><br/>Путь: `/ListPartsResult/Part`.
`PartNumber` | Номер части.<br/><br/>Уникальный целочисленный идентификатор, определяющий положение части в загрузке.<br/><br/>Путь: `/ListPartsResult/Part/PartNumber`.
`LastModified` | Дата и время загрузки части.<br/><br/>Путь: `/ListPartsResult/Part/LastModified`.
`ETag` | `ETag` загруженной части.<br/><br/>Путь: `/ListPartsResult/Part/ETag`.
`Size` | Размер загруженной части.<br/><br/>Путь: `/ListPartsResult/Part/Size`.
