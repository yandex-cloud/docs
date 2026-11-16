---
title: Метод PutConfigurationSetVdmOptions в API Amazon для {{ postbox-full-name }}
description: Из статьи вы узнаете, как с помощью метода PutConfigurationSetVdmOptions включить или выключить отслеживание открытий писем и переходов по ссылкам для конфигурации в {{ postbox-name }}.
---

# Метод PutConfigurationSetVdmOptions

Обновляет настройки сбора статистики для [конфигурации](../../concepts/glossary.md#configuration) в каталоге. Нужный каталог определяется по сервисному аккаунту, от имени которого выполняется запрос.

Из настроек VDM (Virtual Deliverability Manager) Amazon SES {{ postbox-name }} поддерживает только параметр `DashboardOptions.EngagementMetrics`.

## Запрос {#request}

```http
PUT /v2/email/configuration-sets/{ConfigurationSetName}/vdm-options HTTP/2
```

### Path-параметры {#path-parameters}

#|
|| **Параметр** | **Описание** ||
|| `ConfigurationSetName` | **Тип**: string.

Название конфигурации, которая будет изменена. ||
|#

### Заголовки запроса {#request-headers}

{% include [api-request-headers](../../../_includes/postbox/api-request-headers.md) %}

### Тело запроса {#request-body}

```json
{
  "VdmOptions": {
    "DashboardOptions": {
      "EngagementMetrics": "ENABLED|DISABLED"
    }
  }
}
```

#|
|| **Параметр** | **Описание** ||
|| `VdmOptions` | **Тип**: object.

Настройки сбора статистики. Содержит объект `DashboardOptions`.

Если объект `VdmOptions` или вложенный объект `DashboardOptions` не передан, метод возвращает `200 OK` и не изменяет настройки конфигурации. ||
|| `DashboardOptions` | **Тип**: object.

Объект, который содержит параметр `EngagementMetrics`. ||
|| `EngagementMetrics` | **Тип**: string.

{% include [engagement-metrics](../../../_includes/postbox/engagement-metrics.md) %} ||
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
|| `404 NotFoundException` | Конфигурация не найдена. ||
|| `429 TooManyRequestsException` | При вызове запроса превышена [квота](../../concepts/limits.md#postbox-quotas). ||
|#
