# Метод DeleteDedicatedIpPool

Удаляет [пул выделенных IP-адресов](../../concepts/glossary.md#dedicated-ip-pool) в каталоге. Нужный каталог определяется по сервисному аккаунту, от имени которого выполняется запрос.

{% include [delete-dedicated-ip-pool-note.md](../../../_includes/postbox/delete-dedicated-ip-pool-note.md) %}

## Запрос {#request}

```http
DELETE /v2/email/dedicated-ip-pools/{PoolName} HTTP/2
```

### Path-параметры {#path-parameters}

#|
|| **Параметр** | **Описание** ||
|| `PoolName` | **Тип**: string.

Имя пула, который будет удален. ||
|#

### Заголовки запроса {#request-headers}

{% include [api-request-headers](../../../_includes/postbox/api-request-headers.md) %}

## Ответы {#responses}

### 200 OK {#200}

{% include [api-response-200](../../../_includes/postbox/api-response-200.md) %}

### Ошибки {#errors}

{% include [api-errors](../../../_includes/postbox/api-errors.md) %}

Возможные ошибки:

#|
|| **Код ошибки** | **Описание** ||
|| `400 BadRequestException` | В запросе неправильно указаны заголовки или параметры, либо пул привязан к конфигурации. ||
|| `404 NotFoundException` | Пул с таким именем не найден. ||
|| `429 TooManyRequestsException` | При вызове запроса превышена [квота](../../concepts/limits.md#postbox-quotas). ||
|#
