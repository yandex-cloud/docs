# Метод GetDedicatedIpPool

Возвращает информацию о [пуле выделенных IP-адресов](../../concepts/glossary.md#dedicated-ip-pool) в каталоге. Нужный каталог определяется по сервисному аккаунту, от имени которого выполняется запрос.

## Запрос {#request}

```http
GET /v2/email/dedicated-ip-pools/{PoolName} HTTP/2
```

### Path-параметры {#path-parameters}

#|
|| **Параметр** | **Описание** ||
|| `PoolName` | **Тип**: string.

Имя пула.

Получить информацию о [зарезервированных пулах](../../concepts/dedicated-ip.md#reserved-pools) с помощью этого метода нельзя. ||
|#

### Заголовки запроса {#request-headers}

{% include [api-request-headers](../../../_includes/postbox/api-request-headers.md) %}

## Ответы {#responses}

### 200 OK {#200}

```json
{
  "DedicatedIpPool": {
    "PoolName": "<имя_пула>",
    "ScalingMode": "STANDARD"
  }
}
```

#|
|| **Параметр** | **Описание** ||
|| `PoolName` | **Тип**: string.

Имя пула. ||
|| `ScalingMode` | **Тип**: string.

Режим масштабирования пула. Всегда возвращается значение `STANDARD`. ||
|#

Ответ `200 OK` может содержать дополнительные параметры. Он не возвращается строго в формате, указанном выше.

### Ошибки {#errors}

{% include [api-errors](../../../_includes/postbox/api-errors.md) %}

Возможные ошибки:

#|
|| **Код ошибки** | **Описание** ||
|| `400 BadRequestException` | В запросе неправильно указаны заголовки или параметры, либо запрошена информация о [зарезервированных пулах](../../concepts/dedicated-ip.md#reserved-pools). ||
|| `404 NotFoundException` | Пул с таким именем не найден. ||
|| `429 TooManyRequestsException` | При вызове запроса превышена [квота](../../concepts/limits.md#postbox-quotas). ||
|#
