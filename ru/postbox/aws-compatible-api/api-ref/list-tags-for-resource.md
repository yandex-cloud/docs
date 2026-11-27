---
title: Метод ListTagsForResource в API Amazon для {{ postbox-full-name }}
description: Из статьи вы узнаете, как с помощью метода ListTagsForResource получить список меток адреса, конфигурации или пула выделенных IP-адресов в {{ postbox-name }}.
alternate:
  - href: ru/postbox/aws-compatible-api/api-ref/list-tags-for-resource.md
    type: text/markdown
    title: Markdown version
---

# Метод ListTagsForResource

Возвращает список меток ресурса {{ postbox-name }}. Поддерживаются ресурсы:

* [адрес](../../concepts/glossary.md#address);
* [конфигурация](../../concepts/glossary.md#configuration);
* [пул выделенных IP-адресов](../../concepts/glossary.md#dedicated-ip-pool).

Адрес и конфигурация ищутся в каталоге, а пул — в облаке. Нужный каталог или облако определяется по сервисному аккаунту, от имени которого выполняется запрос.

## Запрос {#request}

```http
GET /v2/email/tags?ResourceArn=<ARN_ресурса> HTTP/2
```

### Query-параметры {#query-parameters}

#|
|| **Параметр** | **Описание** ||
|| `ResourceArn` | **Тип**: string.

ARN ресурса в формате `arn:aws:ses:<регион>:<идентификатор_аккаунта>:<тип_ресурса>/<имя_ресурса>`, где `<тип_ресурса>` — одно из значений:

* `identity` — адрес;
* `configuration-set` — конфигурация;
* `dedicated-ip-pool` — пул выделенных IP-адресов.

Сервис в ARN должен быть `ses`. Значение `<идентификатор_аккаунта>` не используется.

Пример: `arn:aws:ses:ru-central1:000000000000:identity/example.com`.

Обязательный параметр. ||
|#

### Заголовки запроса {#request-headers}

{% include [api-request-headers](../../../_includes/postbox/api-request-headers.md) %}

## Ответы {#responses}

### 200 OK {#200}

```json
{
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
|| `Tags` | **Тип**: array.

Массив меток ресурса. ||
|| `Key` | **Тип**: string.

Ключ метки. ||
|| `Value` | **Тип**: string.

Значение метки. ||
|#

### Ошибки {#errors}

{% include [api-errors](../../../_includes/postbox/api-errors.md) %}

Возможные ошибки:

#|
|| **Код ошибки** | **Описание** ||
|| `400 BadRequestException` | В запросе неправильно указаны заголовки или параметры. Также возвращается, если ARN имеет неверный формат или указывает на неподдерживаемый тип ресурса. ||
|| `404 NotFoundException` | Ресурс не найден. ||
|| `429 TooManyRequestsException` | При вызове запроса превышена [квота](../../concepts/limits.md#postbox-quotas). ||
|#
