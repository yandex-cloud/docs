# Метод startUpload

Возвращает идентификатор, который следует использовать во всех дальнейших операциях по загрузке объекта.

Если вместе с объектом необходимо хранить пользовательские метаданные, то передавать их следует в этом запросе.


## Запрос {#request}

```
POST /{bucket}/{key}?uploads HTTP/2
```

### Path параметры {#path-parameters}

Параметр | Описание
----- | -----
`bucket` | Имя бакета.
`key` | Ключ объекта. Под указанным именем объект будет сохранен в {{ objstorage-name }}.


### Query параметры {#request-parameters}

Параметр | Описание
----- | -----
`uploads` | Флаг, обозначающий операцию составной загрузки.


### Заголовки {#request-headers}

Используйте в запросе необходимые [общие заголовки](../common-request-headers.md).

Дополнительно можно использовать заголовки, перечисленные в таблице ниже.

Заголовок | Описание
----- | -----
`X-Amz-Meta-*` | Пользовательские метаданные объекта.<br/><br/>Все заголовки, начинающиеся с `X-Amz-Meta-`, {{ objstorage-name }} преобразует по правилу: `X-Amz-Meta-foo-bar_baz` → `X-Amz-Meta-Foo-Bar_baz`.<br/><br/>Общий размер пользовательских заголовков не должен превышать 2 КБ. Размер пользовательских данных определяется как длина строки в кодировке UTF-8. В размере учитываются и названия заголовков и их значения.
`X-Amz-Storage-Class` | [Класс хранилища](../../../concepts/storage-class.md) объекта.<br/><br/>Может иметь любое из значений:<ul><li>`STANDARD` — стандартное хранилище.</li><li>`COLD`, `STANDARD_IA` или `NEARLINE` — холодное хранилище.</li>{% if audience != "internal" %}<li>`ICE` или `GLACIER` — ледяное хранилище.</li>{% endif %}</ul>Если заголовок не указан, то объект сохраняется в хранилище, установленном в настройках бакета.

С помощью заголовков, перечисленных ниже, можно установить [ACL](../../../concepts/acl.md) для загружаемого объекта.

{% include [storage-acl-headers](../../../_includes_service/storage-acl-object-headers.md) %}


## Ответ {#response}

### Заголовки {#response-headers}

Ответ может содержать только [общие заголовки](../common-response-headers.md).

### Коды ответов {#response-codes}

Перечень возможных ответов смотрите в разделе [{#T}](../response-codes.md).

Успешный ответ содержит дополнительные данные в формате XML, схема которого описана ниже.

### Схема данных {#response-scheme}

```
<InitiateMultipartUploadResult>
  <Bucket>bucket-name</Bucket>
  <Key>object-key</Key>
  <UploadId>upload-id</UploadId>
</InitiateMultipartUploadResult>
```

Тег | Описание
----- | -----
`InitiateMultipartUploadResult` | Корневой тег ответа.<br/><br/>Путь: `/InitiateMultipartUploadResult`.
`Bucket` | Имя бакета в который загружается объект.<br/><br/>Путь: `/InitiateMultipartUploadResult/Bucket`.
`Key` | Ключ, который ассоциируется с объектом, после окончания загрузки.<br/><br/>Путь: `/InitiateMultipartUploadResult/Key`.
`UploadId` | Идентификатор загрузки.<br/><br/>Все последующие операции с загрузкой должны передавать в {{ objstorage-name }} этот идентификатор.<br/><br/>Путь: `/InitiateMultipartUploadResult/UploadId`.
