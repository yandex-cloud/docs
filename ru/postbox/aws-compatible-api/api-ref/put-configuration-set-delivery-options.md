# Метод PutConfigurationSetDeliveryOptions

Обновляет настройки доставки для [конфигурации](../../concepts/glossary.md#configuration) в каталоге. Нужный каталог определяется по сервисному аккаунту, от имени которого выполняется запрос.

## Запрос {#request}

```http
PUT /v2/email/configuration-sets/{ConfigurationSetName}/delivery-options HTTP/2
```

### Path-параметры {#path-parameters}

#|
|| **Параметр** | **Описание** ||
|| `ConfigurationSetName` | **Тип**: string.

Название конфигурации, которая будет изменена.
|#

### Заголовки запроса {#request-headers}

{% include [api-request-headers](../../../_includes/postbox/api-request-headers.md) %}

### Тело запроса {#request-body}

```json
{
   "TlsPolicy": "REQUIRE|OPTIONAL"
}
```

#|
|| **Параметр** | **Описание** ||
|| `TlsPolicy` | **Тип**: string.

Политика безопасности исходящего соединения.

Указывает, требуется ли для сообщений, использующих данную конфигурацию, использовать протокол TLS. Если значение равно `REQUIRE`, сообщения доставляются только при возможности установления TLS-подключения. Если значение равно `OPTIONAL`, сообщения могут доставляться в виде обычного текста, если TLS-подключение установить не удается.||

|#

## Ответы {#responses}

### 200 OK {#200}

{% include [api-response-200](../../../_includes/postbox/api-response-200.md) %}

### Ошибки {#errors}

{% include [api-errors](../../../_includes/postbox/api-errors.md) %}

Возможные ошибки:

#|
|| **Код ошибки** | **Описание** ||
|| `400 BadRequestException` | В запросе неправильно указаны заголовки или параметры. ||
|| `404 NotFoundException` | Запрошенный ресурс не найден. ||
|| `429 TooManyRequestsException ` | При вызове запроса превышена [квота](../../concepts/limits.md#postbox-quotas). ||
|#
