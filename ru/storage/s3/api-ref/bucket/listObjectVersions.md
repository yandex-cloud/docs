# Метод listObjectVersions

Возвращает метаданные обо всех версиях объектов в бакете. 
Также можно использовать параметры запроса в качестве критерия выбора для возврата метаданных о подмножестве версий объекта.

{% include [s3-api-intro-include](../../../../_includes/storage/s3-api-intro-include.md) %}

## Запрос {#request}

```http
GET /{bucket}?versions&delimiter=Delimiter&encoding-type=EncodingType&key-marker=KeyMarker&max-keys=MaxKeys&prefix=Prefix&version-id-marker=VersionIdMarker HTTP/2
```

### Path параметры {#path-parameters}

Параметр | Описание
----- | -----
`bucket` | Имя бакета.

### Query параметры {#parameters}

Все перечисленные в таблице параметры необязательные.

Параметр | Описание
----- | -----
`delimiter` | Символ-разделитель.<br/><br/>Если параметр указан, то {{ objstorage-name }} рассматривает ключ как путь к файлу, где каталоги разделяются символом `delimiter`. В ответе на запрос пользователь увидит перечень <q>файлов</q> и <q>каталогов</q> в бакете. <q>Файлы</q> будут выведены в элементах `Contents`, а <q>каталоги</q> в элементах `CommonPrefixes`.<br/><br/>Если в запросе указан еще и параметр `prefix`, то {{ objstorage-name }} вернет перечень <q>файлов</q> и <q>каталогов</q> в <q>каталоге</q> `prefix`.
`encoding-type` | Кодировка ответа от сервера.<br/><br/>{{ objstorage-name }} по требованию клиента может закодировать ответ в требуемом виде.<br/><br/>Возможные значения: `url`.
`key-marker` | Ключ, с которого начнется выдача.<br/><br/>В результирующей выдаче {{ objstorage-name }} оставит ключи, начиная со следующего за `key-marker`.
`max-keys` | Максимальное количество элементов в ответе.<br/><br/>По умолчанию {{ objstorage-name }} выдает не более 1000 элементов `Contents` и `CommonPrefixes`. Параметр следует использовать, если вам нужно получать менее 1000 элементов в одном ответе.<br/><br/>Если под критерии отбора попадает больше ключей, чем поместилось в выдаче, то ответ содержит `<IsTruncated>true</IsTruncated>`.<br/><br/>Чтобы получить все элементы выдачи, если их больше `max-keys`, необходимо выполнить несколько последовательных запросов к {{ objstorage-name }} с параметром `key-marker`, где для каждого запроса `key-marker` и `version-id-marker` равны значениям элементов `NextKeyMarker` и `NextVersionIdMarker` из предыдущего ответа.
`prefix` | Строка, с которой должен начинаться ключ.<br/><br/>{{ objstorage-name }} выберет только те ключи, которые начинаются с `prefix`.<br/><br/>Может использоваться одновременно с параметром `delimiter`. В этом случае логика выдачи становится той, что указана в описании параметра `delimiter`.
`version-id-marker` | Версия объекта, с которой начинается выдача.<br/><br/>В результирующей выдаче {{ objstorage-name }} оставит версии, начиная со следующей за `version-id-marker`.

### Заголовки {#request-headers}
Используйте в запросе только [общие заголовки](../common-request-headers.md).

## Ответ {#response}

### Заголовки {#response-headers}

Ответ может содержать только [общие заголовки](../common-response-headers.md).

### Коды ответов {#response-codes}

Перечень возможных ответов смотрите в разделе [{#T}](../response-codes.md).

Успешный ответ содержит дополнительные данные в формате XML, схема которого описана ниже.

### Схема данных {#structure}

```xml
<?xml version="1.0" encoding="UTF-8"?>
<ListVersionsResult>
   <IsTruncated>boolean</IsTruncated>
   <KeyMarker>string</KeyMarker>
   <VersionIdMarker>string</VersionIdMarker>
   <NextKeyMarker>string</NextKeyMarker>
   <NextVersionIdMarker>string</NextVersionIdMarker>
   <Version>
      <ETag>string</ETag>
      <IsLatest>boolean</IsLatest>
      <Key>string</Key>
      <LastModified>timestamp</LastModified>
      <Owner>
         <DisplayName>string</DisplayName>
         <ID>string</ID>
      </Owner>
      <Size>integer</Size>
      <StorageClass>string</StorageClass>
      <VersionId>string</VersionId>
   </Version>
   ...
   <DeleteMarker>
      <IsLatest>boolean</IsLatest>
      <Key>string</Key>
      <LastModified>timestamp</LastModified>
      <Owner>
         <DisplayName>string</DisplayName>
         <ID>string</ID>
      </Owner>
      <VersionId>string</VersionId>
   </DeleteMarker>
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
</ListVersionsResult>
```

Элемент | Описание
----- | -----
`ListVersionsResult` | Корневой элемент
`CommonPrefixes` | Часть имени ключа, которая определяется при обработке query параметров `delimiter` и `prefix`.<br/><br/>Путь: `/ListVersionsResult/CommonPrefixes`.
`DeleteMarker` | Контейнер для объекта, который является маркером удаления.<br/><br/>Путь: `/ListVersionsResult/DeleteMarker`.
`Delimiter` | Значение query параметра `delimiter`.<br/><br/>Путь: `/ListVersionsResult/Delimiter`.
`EncodingType` | Кодировка, в которой {{ objstorage-name }} представляет ключ в XML-ответе.<br/><br/>Появляется, если клиент при запросе передал параметр `encoding-type`.<br/><br/>Путь: `/ListVersionsResult/EncodingType`.
`IsTruncated` | Признак неполноты списка.<br/><br/>Если `IsTruncated` — `true`, то это означает, что {{ objstorage-name }} вернул не полный список частей.<br/><br/>Путь: `/ListVersionsResult/IsTruncated`.
`KeyMarker` | Последний ключ, возвращенный в неполном ответе.<br/><br/>Путь: `/ListVersionsResult/KeyMarker`.
`MaxKeys` | Значение query параметра `max-keys`.<br/><br/>Путь: `/ListBucketResult/MaxKeys`.
`Name` | Название бакета.<br/><br/>Путь: `/ListBucketResult/Name`.
`NextKeyMarker` | Значение, которое надо подставить в query параметр `key-marker` для получения следующей части списка, если весь список не поместился в текущий ответ.<br/><br/>Путь: `/ListBucketResult/NextMarker`.
`NextVersionIdMarker` | Значение, которое надо подставить в query параметр `version-id-marker` для получения следующей части списка, если весь список не поместился в текущий ответ.<br/><br/>Путь: `/ListBucketResult/NextVersionIdMarker`.
`Prefix` | Значение query параметра `prefix`.<br/><br/>Путь: `/ListBucketResult/Prefix`.
`Version` | Версия объекта.<br/><br/>Путь: `/ListBucketResult/Version`.
`VersionIdMarker` | Отмечает последнюю версию ключа, возвращенную в усеченном ответе. <br/><br/>Путь: `/ListBucketResult/VersionIdMarker`.

{% include [the-s3-api-see-also-include](../../../../_includes/storage/the-s3-api-see-also-include.md) %}