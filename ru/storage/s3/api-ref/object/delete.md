# Метод delete

Удаляет объект.


## Запрос {#request}

```http
DELETE /{bucket}/{key} HTTP/2
```

### Path параметры {#path-parameters}

Параметр | Описание
----- | -----
`bucket` | Имя бакета.
`key` | Ключ объекта.

### Query параметры {#request-params}

Параметр | Описание
----- | -----
`versionId` | Ссылка на конкретную версию объекта.

### Заголовки {#request-headers}

Используйте в запросе необходимые [общие заголовки](../common-request-headers.md).

Также, если на версию объекта в версионируемом бакете установлена временная управляемая [блокировка](../../../concepts/object-lock.md) (governance-mode retention), обязательно используйте заголовок, описанный ниже, чтобы обойти блокировку и подтвердить удаление. Удалить версию объекта с блокировкой может только пользователь с [ролью `storage.admin`](../../../security/index.md). Проверить блокировку можно с помощью метода [getObjectRetention](getobjectretention.md).

Заголовок | Описание
--- | ---
`X-Amz-Bypass-Governance-Retention` | Заголовок, подтверждающий обход временной управляемой блокировки. Укажите значение `true`.


## Ответ {#response}

### Заголовки {#response-headers}

Ответ может содержать только [общие заголовки](../common-response-headers.md).

### Коды ответов {#response-codes}

Перечень возможных ответов смотрите в разделе [{#T}](../response-codes.md).

{% include [the-s3-api-see-also-include](../../../../_includes/storage/the-s3-api-see-also-include.md) %}