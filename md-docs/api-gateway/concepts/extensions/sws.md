[Документация Yandex Cloud](../../../index.md) > [Yandex API Gateway](../../index.md) > [Концепции](../index.md) > [Расширения спецификации](index.md) > Интеграции > Smart Web Security

# Расширение x-yc-apigateway:smartWebSecurity

Расширение `x-yc-apigateway:smartWebSecurity` защищает [API-шлюз](../index.md) на основе правил, заданных в [профиле безопасности Yandex Smart Web Security](../../../smartwebsecurity/concepts/profiles.md). Например, с помощью [базовых правил](../../../smartwebsecurity/concepts/rules.md#base-rules) можно блокировать нежелательный трафик, а используя [Advanced Rate Limiter](../../../smartwebsecurity/concepts/arl.md) — устанавливать ограничения на количество запросов.

Тарифицируются только те запросы к API-шлюзу, которые не были заблокированы в результате проверки. За работу профиля безопасности плата взимается отдельно согласно [правилам тарификации Yandex Smart Web Security](../../../smartwebsecurity/pricing.md).

## Поддерживаемые параметры {#parameters}

В таблице ниже перечислены параметры, специфичные для API-шлюза сервиса API Gateway. Описание остальных параметров читайте в [спецификации OpenAPI 3.0](https://github.com/OAI/OpenAPI-Specification).

Параметр | Тип | Описание 
----|----|----
`securityProfileId` | `string` | Идентификатор [профиля безопасности](../../../smartwebsecurity/concepts/profiles.md) Smart Web Security.

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

* [Защита API Gateway при помощи интеграции с Smart Web Security](../../tutorials/api-gw-sws-integration.md)