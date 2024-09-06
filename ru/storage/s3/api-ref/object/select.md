# Метод selectObjectContent

Фильтрует и возвращает содержимое объекта {{ objstorage-name }} на основе [запроса на языке S3 Select](../../../concepts/s3-select-language.md).

{% note warning %}

Чтобы получить возможность отправлять запросы на языке S3 Select, обратитесь в [техническую поддержку](../../../../support/overview.md). Также вы должны иметь разрешение на действие `s3:GetObject` — подробнее читайте в разделе [{#T}](../../../concepts/policy.md).

{% endnote %}

Особенности объектов, для которых можно применить запрос:

* Поддерживаются объекты в формате CSV, JSON и Parquet.

* Поддерживаются объекты в кодировке UTF-8.

* Для CSV-файлов поддерживаются методы сжатия GZIP и BZIP2. Для файлов в формате Parquet поддерживается столбчатое сжатие с помощью методов GZIP, Snappy и ZSTD.

* Объекты могут быть защищены шифрованием на стороне сервера.

Для объектов, которые зашифрованы с помощью управляемых ключей шифрования, хранящихся в YC Key Management Service (SSE-KMS), шифрование на стороне сервера выполняется прозрачно, поэтому вам не нужно дополнительно ничего указывать.

{% include [s3-api-intro-include](../../../../_includes/storage/s3-api-intro-include.md) %}

## Запрос {#request}

```
POST /{bucket}/{key}?select&select-type=2 HTTP/2
```

### Path параметры {#path-parameters}

Параметр | Описание
----- | -----
`bucket` | Имя бакета.
`key` | Ключ объекта.


### Query параметры {#request-params}

Параметр | Описание
----- | -----
`select` | Обязательный параметр для обозначения типа операции.
`select-type` | Необязательный параметр для обозначения типа запроса.


### Заголовки {#request-headers}

Используйте в запросе необходимые [общие заголовки](../common-request-headers.md).


### Схема данных {#request-scheme}

Параметры запроса передаются в XML формате:

```
<SelectObjectContentRequest xmlns="http://s3.amazonaws.com/doc/2006-03-01/">
   <Expression>string</Expression>
   <ExpressionType>string</ExpressionType>
   <RequestProgress>
      <Enabled>boolean</Enabled>
   </RequestProgress>
   <InputSerialization>
      <CompressionType>string</CompressionType>
      <CSV>
         <AllowQuotedRecordDelimiter>boolean</AllowQuotedRecordDelimiter>
         <Comments>string</Comments>
         <FieldDelimiter>string</FieldDelimiter>
         <FileHeaderInfo>string</FileHeaderInfo>
         <QuoteCharacter>string</QuoteCharacter>
         <QuoteEscapeCharacter>string</QuoteEscapeCharacter>
         <RecordDelimiter>string</RecordDelimiter>
      </CSV>
      <JSON>
         <Type>string</Type>
      </JSON>
      <Parquet>
      </Parquet>
   </InputSerialization>
   <OutputSerialization>
      <CSV>
         <FieldDelimiter>string</FieldDelimiter>
         <QuoteCharacter>string</QuoteCharacter>
         <QuoteEscapeCharacter>string</QuoteEscapeCharacter>
         <QuoteFields>string</QuoteFields>
         <RecordDelimiter>string</RecordDelimiter>
      </CSV>
      <JSON>
         <RecordDelimiter>string</RecordDelimiter>
      </JSON>
   </OutputSerialization>
   <ScanRange>
      <End>long</End>
      <Start>long</Start>
   </ScanRange>
</SelectObjectContentRequest>
```

Тег | Описание
----- | -----
`SelectObjectContentRequest` | Тег корневого уровня для передачи параметров запроса.<br/><br/>Обязательный: да.<br/><br/>Путь: `/SelectObjectContentRequest`.
`Expression` | SQL-выражение, используемое для запроса данных объекта.<br/><br/>Тип данных: строка.<br/><br/>Обязательный: да.<br/><br/>Путь: `/SelectObjectContentRequest/Expression`.
`ExpressionType` | Тип выражения, используемого для запроса.<br/><br/>Тип данных: строка.<br/><br/>Допустимые значения: `SQL`.<br/><br/>Обязательный: да.<br/><br/>Путь: `/SelectObjectContentRequest/ExpressionType`.
`InputSerialization` | Описание формата данных в запрашиваемом объекте.<br/><br/>Тип данных: `InputSerialization`.<br/><br/>Обязательный: да.<br/><br/>Путь: `/SelectObjectContentRequest/InputSerialization`.
`OutputSerialization` | Описание формата возвращаемых данных.<br/><br/>Тип данных: `OutputSerialization`.<br/><br/>Обязательный: да.<br/><br/>Путь: `/SelectObjectContentRequest/OutputSerialization`.
`RequestProgress` | Указывает, должно ли быть включено периодическое информирование о ходе выполнения запроса.<br/><br/>Тип данных: `RequestProgress`.<br/><br/>Обязательный: нет.<br/><br/>Путь: `/SelectObjectContentRequest/RequestProgress`.
`ScanRange` | Задает диапазон байтов объекта, из которого будут получены записи. Запись обрабатывается, когда ее первый байт содержится в диапазоне. Применяется только для объектов в формате CSV.<br/><br/>Тип данных: `ScanRange`.<br/><br/>Обязательный: нет.<br/><br/>Путь: `/SelectObjectContentRequest/ScanRange`.

## Ответ {#response}

### Заголовки {#response-headers}

Ответ может содержать только [общие заголовки](../common-response-headers.md).

### Коды ответов {#response-codes}

Перечень возможных ответов смотрите в разделе [{#T}](../response-codes.md).

Успешный ответ содержит дополнительные данные в формате XML, схема которого описана ниже.

### Схема данных {#response-scheme}

```
<Payload>
   <Records>
      <Payload>blob</Payload>
   </Records>
   <Stats>
      <Details>
         <BytesProcessed>long</BytesProcessed>
         <BytesReturned>long</BytesReturned>
         <BytesScanned>long</BytesScanned>
      </Details>
   </Stats>
   <Progress>
      <Details>
         <BytesProcessed>long</BytesProcessed>
         <BytesReturned>long</BytesReturned>
         <BytesScanned>long</BytesScanned>
      </Details>
   </Progress>
   <Cont>
   </Cont>
   <End>
   </End>
</Payload>
```

Тег | Описание
----- | -----
`Payload` | Тег корневого уровня для передачи параметров ответа.<br/><br/>Путь: `/Payload`.
`Cont` | Сообщение, указывающее, что запрос обрабатывается.<br/><br/>Путь: `/Payload/Cont`.
`End` | Сообщение, указывающее, что запрос обработан.<br/><br/>Путь: `/Payload/End`.
`Progress` | Информация о ходе выполнения запроса.<br/><br/>Путь: `/Payload/Progress`.
`Records` | Результат запроса.<br/>Путь: `/Payload/Records`.
`Stats` | Статистика по обработанным данным. Высылается один раз в конце запроса.<br/>Путь: `/Payload/Stats`.

{% include [the-s3-api-see-also-include](../../../../_includes/storage/the-s3-api-see-also-include.md) %}