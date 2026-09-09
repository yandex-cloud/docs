# Метод PutDedicatedIpInPool

Перемещает [выделенный IP-адрес](../../concepts/glossary.md#dedicated-ip) в указанный [пул](../../concepts/glossary.md#dedicated-ip-pool). Нужный каталог определяется по сервисному аккаунту, от имени которого выполняется запрос.

Один IP-адрес в каждый момент времени может находиться только в одном пуле. Чтобы удалить IP-адрес из пользовательского пула, переместите его в пул по умолчанию `ses-default-dedicated-pool`.

Операция идемпотентна: повторное перемещение IP-адреса в тот же пул завершается успешно.

## Запрос {#request}

```http
PUT /v2/email/dedicated-ips/{IP}/pool HTTP/2
```

### Path-параметры {#path-parameters}

#|
|| **Параметр** | **Описание** ||
|| `IP` | **Тип**: string.

Выделенный IP-адрес, который будет перемещен. ||
|#

### Заголовки запроса {#request-headers}

{% include [api-request-headers](../../../_includes/postbox/api-request-headers.md) %}

### Тело запроса {#request-body}

```json
{
  "DestinationPoolName": "<имя_пула_назначения>"
}
```

#|
|| **Параметр** | **Описание** ||
|| `DestinationPoolName` | **Тип**: string.

Имя пула, в который будет перемещен IP-адрес. ||

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
|| `404 NotFoundException` | IP-адрес не найден или не принадлежит вашему облаку, либо пул назначения не существует. ||
|| `429 TooManyRequestsException` | При вызове запроса превышена [квота](../../concepts/limits.md#postbox-quotas). ||
|#

Существование IP-адреса проверяется раньше существования пула. Если неправильно указаны оба параметра, вернется ошибка об IP-адресе.
