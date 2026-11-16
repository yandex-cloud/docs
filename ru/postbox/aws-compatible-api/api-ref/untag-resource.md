---
title: Метод UntagResource в API Amazon для {{ postbox-full-name }}
description: Из статьи вы узнаете, как с помощью метода UntagResource удалить метки пула выделенных IP-адресов в {{ postbox-name }}.
---

# Метод UntagResource

Удаляет метки [пула выделенных IP-адресов](../../concepts/glossary.md#dedicated-ip-pool) в облаке. Нужное облако определяется по сервисному аккаунту, от имени которого выполняется запрос.

Метод поддерживает только пулы выделенных IP-адресов. Удалить метки адресов и конфигураций с помощью этого метода нельзя.

## Запрос {#request}

```http
DELETE /v2/email/tags?ResourceArn=<ARN_пула>&TagKeys=<ключ_метки_1>&TagKeys=<ключ_метки_2> HTTP/2
```

### Query-параметры {#query-parameters}

#|
|| **Параметр** | **Описание** ||
|| `ResourceArn` | **Тип**: string.

ARN пула в формате `arn:aws:ses:<регион>:<идентификатор_аккаунта>:dedicated-ip-pool/<имя_пула>`. Значение `<идентификатор_аккаунта>` не используется.

Пример: `arn:aws:ses:ru-central1:000000000000:dedicated-ip-pool/marketing`.

Изменить метки [зарезервированных пулов](../../concepts/dedicated-ip.md#reserved-pools) нельзя.

Обязательный параметр. ||
|| `TagKeys` | **Тип**: array.

Ключи меток, которые нужно удалить. Чтобы удалить несколько меток, укажите параметр несколько раз. Ключи, которых нет у пула, игнорируются. ||
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
|| `400 BadRequestException` | В запросе неправильно указаны заголовки или параметры. Также возвращается, если ARN имеет неверный формат, указывает не на пул выделенных IP-адресов или на зарезервированный пул. ||
|| `404 NotFoundException` | Пул с таким именем не найден. ||
|| `409 ConcurrentModificationException` | Конфликт операций. Дождитесь завершения предыдущей операции и повторите запрос. ||
|| `429 TooManyRequestsException` | При вызове запроса превышена [квота](../../concepts/limits.md#postbox-quotas). ||
|#
