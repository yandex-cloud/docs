[Документация Yandex Cloud](../../../index.md) > [Yandex Cloud Postbox](../../index.md) > [Справочник API](../index.md) > [REST](index.md) > Выделенные IP-адреса > Метод GetDedicatedIpPool

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

Используйте в запросе [общие заголовки](request-headers.md).

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
|| `400 BadRequestException` | В запросе неправильно указаны заголовки или параметры, либо запрошена информация о [зарезервированных пулах](../../concepts/dedicated-ip.md#reserved-pools). ||
|| `404 NotFoundException` | Пул с таким именем не найден. ||
|| `429 TooManyRequestsException` | При вызове запроса превышена [квота](../../concepts/limits.md#postbox-quotas). ||
|#