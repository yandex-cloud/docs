# Расширение x-yc-apigateway:smartWebSecurity

Расширение `x-yc-apigateway:smartWebSecurity` защищает [API-шлюз](../../concepts/index.md) на основе правил, заданных в [профиле безопасности {{ sws-full-name }}](../../../smartwebsecurity/concepts/profiles.md). Заблокированные запросы к API-шлюзу не тарифицируются. 

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
