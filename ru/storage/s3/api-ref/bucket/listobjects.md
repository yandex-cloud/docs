# Метод listObjects

Возвращает список объектов в бакете. 

Не возвращает содержимое объектов. Чтобы получить его, воспользуйтесь методом [get](../object/get.md).

При выдаче используется пагинация, за один запрос можно получить список не длиннее 1000 объектов. Если объектов больше, то необходимо выполнить несколько запросов подряд.

{% note info %}

У этого метода есть две версии. 
- `listObjectsV2` — актуальная версия, более удобная в использовании.
- `listObjectsV1` — предыдущая версия.

Для вызова обоих методов используется один и тот же `URL`, но он отличается query-параметром. Чтобы вызвать `listObjectsV2`, используйте параметр [`list-type=2`](#requestV2).

{% endnote %}

## listObjectsV2 {#listObjectsV2}

### Запрос {#requestV2}

```http
GET /{bucket}?list-type=2&continuation-token=ContinuationToken&delimiter=Delimiter&encoding-type=EncodingType&max-keys=MaxKeys&prefix=Prefix&start-after=StartAfter HTTP/2
```

#### Path параметры {#path-parametersV2}

Параметр | Описание
----- | -----
`bucket` | Имя бакета.

#### Query параметры {#parametersV2}

Все перечисленные в таблице параметры необязательные.

Параметр | Описание
----- | -----
`continuation-token` | Используется для получения следующей части списка, если все результаты не помещаются в один ответ.<br/>Чтобы получить следующую часть списка, используйте значение `NextContinuationToken` из предыдущего ответа.
`delimiter` | Символ-разделитель.<br/><br/>Если параметр указан, то {{ objstorage-name }} рассматривает ключ как путь к файлу, где каталоги разделяются символом `delimiter`. В ответе на запрос пользователь увидит перечень <q>файлов</q> и <q>каталогов</q> в бакете. <q>Файлы</q> будут выведены в элементах `Contents`, а <q>каталоги</q> в элементах `CommonPrefixes`.<br/><br/>Если в запросе указан еще и параметр `prefix`, то {{ objstorage-name }} вернет перечень <q>файлов</q> и <q>каталогов</q> в <q>каталоге</q> `prefix`.
`encoding-type` | Кодировка ответа от сервера.<br/><br/>{{ objstorage-name }} по требованию клиента может закодировать ответ в требуемом виде.<br/><br/>Возможные значения: `url`.
`max-keys` | Максимальное количество элементов в ответе.<br/><br/>По умолчанию {{ objstorage-name }} выдает не более 1000 элементов `Contents` и `CommonPrefixes`. Параметр следует использовать, если вам нужно получать менее 1000 элементов в одном ответе.<br/><br/>Если под критерии отбора попадает больше ключей, чем поместилось в выдаче, то ответ содержит `<IsTruncated>true</IsTruncated>`.<br/><br/>Чтобы получить все элементы выдачи, если их больше `max-keys`, необходимо выполнить несколько последовательных запросов к {{ objstorage-name }} с параметром `continuation-token`, где для каждого запроса `continuation-token` равен значению элемента `NextContinuationToken` из предыдущего ответа.
`prefix` | Строка, с которой должен начинаться ключ.<br/><br/>{{ objstorage-name }} выберет только те ключи, которые начинаются с `prefix`.<br/><br/>Может использоваться одновременно с параметром `delimiter`. В этом случае логика выдачи определяется параметром `delimiter`.
`start-after` | Ключ, с которого нужно начать листинг.

#### Заголовки {#request-headersV2}
Используйте в запросе только [общие заголовки](../common-request-headers.md).

### Ответ {#responseV2}

#### Заголовки {#response-headersV2}

Ответ может содержать только [общие заголовки](../common-response-headers.md).

#### Коды ответов {#response-codesV2}

Перечень возможных ответов смотрите в разделе [{#T}](../response-codes.md).

Успешный ответ содержит дополнительные данные в формате XML, схема которого описана ниже.

#### Схема данных {#structureV2}

```xml
<?xml version="1.0" encoding="UTF-8"?>
<ListBucketResult>
   <IsTruncated>boolean</IsTruncated>
   <Contents>
      <ETag>string</ETag>
      <Key>string</Key>
      <LastModified>timestamp</LastModified>
      <Size>integer</Size>
      <StorageClass>string</StorageClass>
   </Contents>
   ...
   <Name>string</Name>
   <Prefix>string</Prefix>
   <Delimiter>string</Delimiter>
   <MaxKeys>integer</MaxKeys>
   <CommonPrefixes>
      <Prefix>string</Prefix>
   </CommonPrefixes>
   ...
   <EncodingType>string</EncodingType>
   <KeyCount>integer</KeyCount>
   <ContinuationToken>string</ContinuationToken>
   <NextContinuationToken>string</NextContinuationToken>
   <StartAfter>string</StartAfter>
</ListBucketResult>
```

Элемент | Описание
----- | -----
`ListBucketResult` | Корневой элемент.
`IsTruncated` | Флаг, показывающий все ли результаты возвращены в этом ответе.<br/><br/>`True` — не все. `False` — все.<br/><br/>Путь: `/ListBucketResult/IsTruncated`.
`Contents` | Описание объекта.<br/><br/>Ответ будет содержать столько элементов `Contents`, сколько ключей попало под условия запроса.<br/><br/>Путь: `/ListBucketResult/Contents`.
`ETag` | MD5-хэш объекта. Метаданные в расчете хэша не участвуют.<br/><br/>Путь: `/ListBucketResult/Contents/ETag`.
`Key` | Ключ объекта.<br/><br/>Путь: `/ListBucketResult/Contents/Key`.
`LastModified` | Дата и время последнего изменения объекта.<br/><br/>Путь: `/ListBucketResult/Contents/LastModified`.
`Size` | Размер объекта в байтах.<br/><br/>Путь: `/ListBucketResult/Contents/Size`.
`StorageClass` | [Класс хранилища](../../../concepts/storage-class.md) объекта: `STANDARD`, `COLD` или `ICE`.<br/><br/>Путь: `/ListBucketResult/Contents/StorageClass`.
`Name` | Имя бакета.<br/><br/>Путь: `/ListBucketResult/Name`.
`Prefix` | Значение query-параметра `prefix`.<br/><br/>Путь: `/ListBucketResult/Prefix`.
`Delimiter` | Значение query-параметра `delimiter`.<br/><br/>Путь: `/ListBucketResult/Delimiter`.
`MaxKeys` | Значение query-параметра `max-keys`.<br/><br/>Путь: `/ListBucketResult/MaxKeys`.
`CommonPrefixes` | Часть имени ключа, которая определяется при обработке query-параметров `delimiter` и `prefix`.<br/><br/>Путь: `/ListBucketResult/CommonPrefixes`.
`EncodingType` | Кодировка, в которой {{ objstorage-name }} представляет ключ в XML-ответе.<br/><br/>Появляется, если клиент при запросе передал параметр `encoding-type`.<br/><br/>Путь: `/ListBucketResult/EncodingType`.
`KeyCount` | Количество ключей, возвращенных запросом.<br/>Количество ключей всегда будет меньше или равно `MaxKeys`.<br/><br/>Путь: `/ContinuationToken/KeyCount`.
`ContinuationToken` | Значение query-параметра `continuation-token`.<br/><br/>Путь: `/ContinuationToken/ContinuationToken`.
`NextContinuationToken` | Значение, которое надо подставить в query-параметр `continuation-token` для получения следующей части списка, если весь список не поместился в текущий ответ.<br/>Возвращается только в том случае, если `IsTruncated = true`.<br/><br/>Путь: `/ListBucketResult/NextContinuationToken`.
`StartAfter` | Значение query-параметра `start-after`.<br/><br/>Путь: `/ListBucketResult/StartAfter`.

## listObjectsV1 {#listObjectsV1}

### Запрос {#requestV1}

```http
GET /{bucket}?delimiter=Delimiter&encoding-type=EncodingType&marker=Marker&max-keys=MaxKeys&prefix=Prefix HTTP/2
```

#### Path параметры {#path-parametersV1}

Параметр | Описание
----- | -----
`bucket` | Имя бакета.

#### Query параметры {#parametersV1}

Все перечисленные в таблице параметры необязательные.

Параметр | Описание
----- | -----
`delimiter` | Символ-разделитель.<br/><br/>Если параметр указан, то {{ objstorage-name }} рассматривает ключ как путь к файлу, где каталоги разделяются символом `delimiter`. В ответе на запрос пользователь увидит перечень <q>файлов</q> и <q>каталогов</q> в бакете. <q>Файлы</q> будут выведены в элементах `Contents`, а <q>каталоги</q> в элементах `CommonPrefixes`.<br/><br/>Если в запросе указан еще и параметр `prefix`, то {{ objstorage-name }} вернет перечень <q>файлов</q> и <q>каталогов</q> в <q>каталоге</q> `prefix`.
`encoding-type` | Кодировка ответа от сервера.<br/><br/>{{ objstorage-name }} по требованию клиента может закодировать ответ в требуемом виде.<br/><br/>Возможные значения: `url`.
`marker` | Ключ, с которого начнется выдача.<br/><br/>В результирующей выдаче {{ objstorage-name }} оставит ключи, начиная со следующего за `marker`.
`max-keys` | Максимальное количество элементов в ответе.<br/><br/>По умолчанию {{ objstorage-name }} выдает не более 1000 элементов `Contents` и `CommonPrefixes`. Параметр следует использовать, если вам нужно получать менее 1000 элементов в одном ответе.<br/><br/>Если под критерии отбора попадает больше ключей, чем поместилось в выдаче, то ответ содержит `<IsTruncated>true</IsTruncated>`.<br/><br/>Чтобы получить все элементы выдачи, если их больше `max-keys`, необходимо выполнить несколько последовательных запросов к {{ objstorage-name }} с параметром `marker`, где для каждого запроса `marker` равен значению элемента `NextMarker` из предыдущего ответа.
`prefix` | Строка, с которой должен начинаться ключ.<br/><br/>{{ objstorage-name }} выберет только те ключи, которые начинаются с `prefix`.<br/><br/>Может использоваться одновременно с параметром `delimiter`. В этом случае логика выдачи определяется параметром `delimiter`.

#### Заголовки {#request-headersV1}
Используйте в запросе только [общие заголовки](../common-request-headers.md).

### Ответ {#responseV1}

#### Заголовки {#response-headersV1}

Ответ может содержать только [общие заголовки](../common-response-headers.md).

#### Коды ответов {#response-codesV1}

Перечень возможных ответов смотрите в разделе [{#T}](../response-codes.md).

Успешный ответ содержит дополнительные данные в формате XML, схема которого описана ниже.

#### Схема данных {#structureV1}

```xml
<?xml version="1.0" encoding="UTF-8"?>
<ListBucketResult>
   <IsTruncated>boolean</IsTruncated>
   <Marker>string</Marker>
   <NextMarker>string</NextMarker>
   <Contents>
      <ETag>string</ETag>
      <Key>string</Key>
      <LastModified>timestamp</LastModified>
      <Size>integer</Size>
      <StorageClass>string</StorageClass>
   </Contents>
   ...
   <Name>string</Name>
   <Prefix>string</Prefix>
   <Delimiter>string</Delimiter>
   <MaxKeys>integer</MaxKeys>
   <CommonPrefixes>
      <Prefix>string</Prefix>
   </CommonPrefixes>
   ...
   <EncodingType>string</EncodingType>
</ListBucketResult>
```

Элемент | Описание
----- | -----
`ListBucketResult` | Корневой элемент.
`IsTruncated` | Флаг, показывающий все ли результаты возвращены в этом ответе.<br/><br/>`True` — не все. `False` — все.<br/><br/>Путь: `/ListBucketResult/IsTruncated`.
`Marker` | Значение query-параметра `marker`.<br/><br/>Путь: `/ListBucketResult/Marker`.
`NextMarker` | Значение, которое надо подставить в query-параметр `marker` для получения следующей части списка, если весь список не поместился в текущий ответ.<br/><br/>Путь: `/ListBucketResult/NextMarker`.
`Contents` | Описание объекта.<br/><br/>Ответ будет содержать столько элементов `Contents`, сколько ключей попало под условия запроса.<br/><br/>Путь: `/ListBucketResult/Contents`.
`ETag` | MD5-хэш объекта. Метаданные в расчете хэша не участвуют.<br/><br/>Путь: `/ListBucketResult/Contents/ETag`.
`Key` | Ключ объекта.<br/><br/>Путь: `/ListBucketResult/Contents/Key`.
`LastModified` | Дата и время последнего изменения объекта.<br/><br/>Путь: `/ListBucketResult/Contents/LastModified`.
`Size` | Размер объекта в байтах.<br/><br/>Путь: `/ListBucketResult/Contents/Size`.
`StorageClass` | [Класс хранилища](../../../concepts/storage-class.md) объекта: `STANDARD`, `COLD` или `ICE`.<br/><br/>Путь: `/ListBucketResult/Contents/StorageClass`.
`Name` | Имя бакета.<br/><br/>Путь: `/ListBucketResult/Name`.
`Prefix` | Значение query-параметра `prefix`.<br/><br/>Путь: `/ListBucketResult/Prefix`.
`Delimiter` | Значение query-параметра `delimiter`.<br/><br/>Путь: `/ListBucketResult/Delimiter`.
`MaxKeys` | Значение query-параметра `max-keys`.<br/><br/>Путь: `/ListBucketResult/MaxKeys`.
`CommonPrefixes` | Часть имени ключа, которая определяется при обработке query-параметров `delimiter` и `prefix`.<br/><br/>Путь: `/ListBucketResult/CommonPrefixes`.
`EncodingType` | Кодировка, в которой {{ objstorage-name }} представляет ключ в XML-ответе.<br/><br/>Появляется, если клиент при запросе передал параметр `encoding-type`.<br/><br/>Путь: `/ListBucketResult/EncodingType`.

{% include [the-s3-api-see-also-include](../../../../_includes/storage/the-s3-api-see-also-include.md) %}