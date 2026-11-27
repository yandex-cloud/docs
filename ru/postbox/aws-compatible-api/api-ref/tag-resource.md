---
title: Метод TagResource в API Amazon для {{ postbox-full-name }}
description: Из статьи вы узнаете, как с помощью метода TagResource добавить метки пулу выделенных IP-адресов в {{ postbox-name }}.
alternate:
  - href: ru/postbox/aws-compatible-api/api-ref/tag-resource.md
    type: text/markdown
    title: Markdown version
---

# Метод TagResource

Добавляет метки [пулу выделенных IP-адресов](../../concepts/glossary.md#dedicated-ip-pool) в облаке. Нужное облако определяется по сервисному аккаунту, от имени которого выполняется запрос.

Метод поддерживает только пулы выделенных IP-адресов. Изменить метки адресов и конфигураций с помощью этого метода нельзя.

## Запрос {#request}

```http
POST /v2/email/tags HTTP/2
```

### Заголовки запроса {#request-headers}

{% include [api-request-headers](../../../_includes/postbox/api-request-headers.md) %}

### Тело запроса {#request-body}

```json
{
  "ResourceArn": "<ARN_пула>",
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
|| `ResourceArn` | **Тип**: string.

ARN пула в формате `arn:aws:ses:<регион>:<идентификатор_аккаунта>:dedicated-ip-pool/<имя_пула>`. Значение `<идентификатор_аккаунта>` не используется.

Пример: `arn:aws:ses:ru-central1:000000000000:dedicated-ip-pool/marketing`.

Изменить метки [зарезервированных пулов](../../concepts/dedicated-ip.md#reserved-pools) нельзя.

Обязательный параметр. ||
|| `Tags` | **Тип**: array.

Массив меток, которые нужно добавить пулу. Метки добавляются к существующим меткам пула. Если у пула уже есть метка с таким ключом, ее значение будет заменено. ||
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
|| `400 BadRequestException` | В запросе неправильно указаны заголовки или параметры. Также возвращается, если ARN имеет неверный формат, указывает не на пул выделенных IP-адресов или на зарезервированный пул. ||
|| `404 NotFoundException` | Пул с таким именем не найден. ||
|| `409 ConcurrentModificationException` | Конфликт операций. Дождитесь завершения предыдущей операции и повторите запрос. ||
|| `429 TooManyRequestsException` | При вызове запроса превышена [квота](../../concepts/limits.md#postbox-quotas). ||
|#
