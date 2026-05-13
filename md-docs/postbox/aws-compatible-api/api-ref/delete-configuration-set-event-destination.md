# Метод DeleteConfigurationSetEventDestination

Удаляет [подписку](../../concepts/glossary.md#subscription) для [конфигурации](../../concepts/glossary.md#configuration) в каталоге. Нужный каталог определяется по сервисному аккаунту, от имени которого выполняется запрос.

## Запрос {#request}

```http
DELETE /v2/email/configuration-sets/{ConfigurationSetName}/event-destinations/{EventDestinationName} HTTP/2
```

### Path-параметры {#path-parameters}

#|
|| **Параметр** | **Описание** ||
|| `ConfigurationSetName` | **Тип**: string.

Название конфигурации. ||
|| `EventDestinationName` | **Тип**: string.

Название подписки, которая будет удалена. ||
|#

### Заголовки запроса {#request-headers}

Используйте в запросе [общие заголовки](request-headers.md).

## Ответы {#responses}

### 200 OK {#200}

Ответ `200 OK` возвращается в случае успешного выполнения запроса.

### Ошибки {#errors}

Для всех ошибок тело ответа представлено в одинаковом формате:

```json
{
   "Code": "<название_ошибки>",
   "message": "<пояснение_к_ошибке>"
}
```

Название ошибки заимствуется из ее кода, например `BadRequestException`.

Возможные ошибки:

#|
|| **Код ошибки** | **Описание** ||
|| `400 BadRequestException` | В запросе неправильно указаны заголовки или параметры. ||
|| `404 NotFoundException` | Запрошенный ресурс не найден. ||
|| `429 TooManyRequestsException ` | При вызове запроса превышена [квота](../../concepts/limits.md#postbox-quotas). ||
|#