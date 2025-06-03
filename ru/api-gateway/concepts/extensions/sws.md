# Расширение x-yc-apigateway:smartWebSecurity

Расширение `x-yc-apigateway:smartWebSecurity` защищает [API-шлюз](../../concepts/index.md) на основе правил, заданных в [профиле безопасности {{ sws-full-name }}](../../../smartwebsecurity/concepts/profiles.md). Например, с помощью [базовых правил](../../../smartwebsecurity/concepts/rules.md#base-rules) можно блокировать нежелательный трафик, а используя [Advanced Rate Limiter](../../../smartwebsecurity/concepts/arl.md) — устанавливать ограничения на количество запросов.

Тарифицируются только те запросы к API-шлюзу, которые не были заблокированы в результате проверки. За работу профиля безопасности плата взимается отдельно согласно [правилам тарификации {{ sws-full-name }}](../../../smartwebsecurity/pricing.md).

## Поддерживаемые параметры {#parameters}

{% include [param-table](../../../_includes/api-gateway/parameters-table.md) %}

Параметр | Тип | Описание 
----|----|----
`securityProfileId` | `string` | Идентификатор [профиля безопасности](../../../smartwebsecurity/concepts/profiles.md) {{ sws-name }}.

## Спецификация расширения {#spec}

Пример спецификации: 

```yaml
openapi: "3.0.0"

x-yc-apigateway:
  smartWebSecurity:
    securityProfileId: fev6q4qqnn2q********

info:
  version: 1.0.0
  title: Protected pet store
  license:
    name: MIT
paths:
  /:
    get:
      x-yc-apigateway-integration:
        type: dummy
        content:
          '*': "This pet store is protected by SWS!"
        http_code: 200
```

## Примеры использования {#examples}

* [{#T}](../../tutorials/api-gw-sws-integration.md)