[Документация Yandex Cloud](../../../index.md) > [Yandex Cloud Postbox](../../index.md) > [Справочник API](../index.md) > [REST](index.md) > Выделенные IP-адреса > Метод GetDedicatedIp

# Метод GetDedicatedIp

Возвращает информацию о [выделенном IP-адресе](../../concepts/glossary.md#dedicated-ip) в каталоге. Нужный каталог определяется по сервисному аккаунту, от имени которого выполняется запрос.

## Запрос {#request}

```http
GET /v2/email/dedicated-ips/{IP} HTTP/2
```

### Path-параметры {#path-parameters}

#|
|| **Параметр** | **Описание** ||
|| `IP` | **Тип**: string.

Выделенный IP-адрес. ||
|#

### Заголовки запроса {#request-headers}

Используйте в запросе [общие заголовки](request-headers.md).

## Ответы {#responses}

### 200 OK {#200}

```json
{
  "DedicatedIp": {
    "Ip": "<IP-адрес>",
    "WarmupStatus": "DONE",
    "WarmupPercentage": 100,
    "PoolName": "<имя_пула>"
  }
}
```

#|
|| **Параметр** | **Описание** ||
|| `Ip` | **Тип**: string.

Выделенный IP-адрес. ||
|| `WarmupStatus` | **Тип**: string.

Статус [прогрева](../../concepts/dedicated-ip.md#warmup) IP-адреса. Всегда возвращается значение `DONE`. ||
|| `WarmupPercentage` | **Тип**: integer.

Процент завершения прогрева IP-адреса. Всегда возвращается значение `100`. ||
|| `PoolName` | **Тип**: string.

Имя [пула](../../concepts/glossary.md#dedicated-ip-pool), в котором находится IP-адрес. ||

|#

Ответ `200 OK` может содержать дополнительные параметры. Он не возвращается строго в формате, указанном выше.

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
|| `400 BadRequestException` | В запросе неправильно указаны заголовки или параметры, либо значение параметра `IP` не является корректным IP-адресом. ||
|| `404 NotFoundException` | IP-адрес не найден или не принадлежит вашему облаку. ||
|| `429 TooManyRequestsException` | При вызове запроса превышена [квота](../../concepts/limits.md#postbox-quotas). ||
|#