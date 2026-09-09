# Метод CreateDedicatedIpPool

Создает [пул выделенных IP-адресов](../../concepts/glossary.md#dedicated-ip-pool) в каталоге. Нужный каталог определяется по сервисному аккаунту, от имени которого выполняется запрос.

## Запрос {#request}

```http
POST /v2/email/dedicated-ip-pools HTTP/2
```

### Заголовки запроса {#request-headers}

{% include [api-request-headers](../../../_includes/postbox/api-request-headers.md) %}

### Тело запроса {#request-body}

```json
{
  "PoolName": "<имя_пула>",
  "ScalingMode": "STANDARD",
  "Tags": [
    {
      "Key": "<ключ_метки>",
      "Value": "<значение_метки>"
    }
  ]
}
```

#|
|| **Параметр** | **Описание** ||
|| `PoolName` | **Тип**: string.

Имя пула. Должно быть уникальным в рамках облака.

Допустимые символы — строчные латинские буквы, цифры, символы подчеркивания `_` и дефисы `-`. Длина имени — от 1 до 64 символов.

Нельзя указывать имена, [зарезервированные](../../concepts/dedicated-ip.md#reserved-pools) сервисом. ||
|| `ScalingMode` | **Тип**: string.

Режим масштабирования пула. Возможные значения: `STANDARD`.

Необязательный параметр. ||
|| `Tags` | **Тип**: array.

Массив меток для пула.

Необязательный параметр. ||
|| `Key` | **Тип**: string.

Ключ метки. ||
|| `Value` | **Тип**: string.

Значение метки. ||
|#

## Ответы {#responses}

### 200 OK {#200}

{% include [api-response-200](../../../_includes/postbox/api-response-200.md) %}

### Ошибки {#errors}

{% include [api-errors](../../../_includes/postbox/api-errors.md) %}

Возможные ошибки:

#|
|| **Код ошибки** | **Описание** ||
|| `400 BadRequestException` | В запросе неправильно указаны заголовки или параметры. Также возвращается, если имя пула не соответствует требованиям, указано зарезервированное имя пула или параметр `ScalingMode` не равен `STANDARD`. ||
|| `409 AlreadyExistsException` | Пул с таким именем уже существует, выберите другое имя. ||
|| `429 TooManyRequestsException` | При вызове запроса превышена [квота](../../concepts/limits.md#postbox-quotas). ||
|#
