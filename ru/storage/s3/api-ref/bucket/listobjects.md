# Метод listObjects

Возвращает перечень объектов в бакете.

При выдаче используется пагинация, за один запрос можно получить список не длиннее 1000 объектов. Если объектов больше, то необходимо выполнить несколько запросов подряд.


## Запрос {#request}

```
GET /{bucket} HTTP/1.1
```

### Path параметры {#path-parameters}

Параметр | Описание
----- | -----
`bucket` | Имя бакета.


### Query параметры {#parameters}

Все перечисленные в таблице параметры необязательные.

Параметр | Описание
----- | -----
`delimiter` | Символ-разделитель.<br/><br/>Если параметр указан, то [!KEYREF objstorage-name] рассматривает ключ как путь к файлу, где каталоги разделяются символом `delimiter`. В ответе на запрос пользователь увидит перечень <q>файлов</q> и <q>каталогов</q> в бакете. <q>Файлы</q> будут выведены в элементах `Contents`, а <q>каталоги</q> в элементах `CommonPrefixes`.<br/><br/>Если в запросе указан еще и параметр `prefix`, то [!KEYREF objstorage-name] вернет перечень <q>файлов</q> и <q>каталогов</q> в <q>каталоге</q> `prefix`.
`marker` | Ключ, с которого начнется выдача.<br/><br/>В результирующей выдаче [!KEYREF objstorage-name] оставит ключи, начиная со следующего за `marker`.
`max-keys` | Максимальное количество элементов в ответе.<br/><br/>По умолчанию [!KEYREF objstorage-name] выдает не более 1000 элементов `Contents` и `CommonPrefixes`. Параметр следует использовать если вам нужно получать менее 1000 элементов в одном ответе.<br/><br/>Если под критерии отбора попадает больше ключей, чем поместилось в выдаче, то ответ содержит `<IsTruncated>true</IsTruncated>`.<br/><br/>Чтобы получить все элементы выдачи, если их больше `max-keys`, необходимо выполнить несколько последовательных запросов к [!KEYREF objstorage-name] с параметром `marker`, где для каждого запроса `marker` равен значению элемента `MaxKeys` из предыдущего ответа.
`prefix` | Строка, с которой должен начинаться ключ.<br/><br/>[!KEYREF objstorage-name] выберет только те ключи, которые начинаются с `prefix`.<br/><br/>Может использоваться одновременно с параметром `delimiter`. В этом случает логика выдачи становится той, что указана в описании параметра `delimiter`.


### Заголовки {#request-headers}
Используйте в запросе только [общие заголовки](../common-request-headers.md).

## Ответ {#response}

### Заголовки {#response-headers}

Ответ может содержать только [общие заголовки](../common-response-headers.md).

### Коды ответов {#response-codes}

Перечень возможных ответов смотрите в разделе [[!TITLE]](../response-codes.md).

Успешный ответ содержит дополнительные данные в формате XML, схема которого описана ниже.

### Схема данных {#structure}

```
<?xml version="1.0" encoding="UTF-8"?>
<ListBucketResult>
    <Name>bucket</Name>
    <Prefix/>
    <Marker/>
    <MaxKeys>1000</MaxKeys>
    <IsTruncated>false</IsTruncated>
    <Contents>
        <Key>my-image.jpg</Key>
        <LastModified>2018-09-10T17:50:30.000Z</LastModified>
        <ETag>MD5</ETag>
        <Size>434234</Size>
        <StorageClass>STANDARD</StorageClass>
    </Contents>
</ListBucketResult>
```

Элемент | Описание
----- | -----
`Contents` | Описание объекта.<br/><br/>Ответ будет содержать столько элементов `Contents`, сколько ключей попало под условия запроса.<br/><br/>Путь: `/ListBucketResult/Contents`.
`CommonPrefixes` | Часть имени ключа, которая определяется при обработке path параметров `delimiter` и `prefix`.<br/><br/>Путь: `/ListBucketResult/CommonPrefixes`.
`Delimiter` | Значение path параметра `delimiter`.<br/><br/>Путь: `/ListBucketResult/Delimiter`.
`ETag` | MD5-хэш объекта. Метаданные в расчете хэша не участвуют.<br/><br/>Путь: `/ListBucketResult/Contents/ETag`.
`IsTruncated` | Флаг, показывающий все ли результаты возвращены в этом ответе.<br/><br/>`True` — все. `False` — не все.<br/><br/>Путь: `/ListBucketResult/IsTruncated`.
`Key` | Ключ объекта.<br/><br/>Путь: `/ListBucketResult/Contents/Key`.
`LastModified` | Дата и время последнего изменения объекта.<br/><br/>Путь: `/ListBucketResult/Contents/LastModified`.
`Marker` | Значение path параметра `marker`.<br/><br/>Путь: `/ListBucketResult/Marker`.
`MaxKeys` | Значение path параметра `max-keys`.<br/><br/>Путь: `/ListBucketResult/MaxKeys`.
`Name` | Имя бакета.<br/><br/>Путь: `/ListBucketResult/Name`.
`NextMarker` | Значение, которое надо подставить в path параметр `marker` для получения следующей части списка, если весь список не поместился в текущий ответ.<br/><br/>Путь: `/ListBucketResult/NextMarker`.
`Prefix` | Значение path параметра `prefix`.<br/><br/>Путь: `/ListBucketResult/Prefix`.
`Size` | Размер объекта в байтах.<br/><br/>Путь: `/ListBucketResult/Contents/Size`.
`StorageClass` | Класс хранения объекта: `STANDARD` или `COLD`.<br/><br/>Путь: `/ListBucketResult/Contents/StorageClass`.


