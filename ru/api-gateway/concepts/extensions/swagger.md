---
title: Расширение x-yc-apigateway-integration:swagger
description: Из статьи вы узнаете, для чего нужно расширение x-yc-apigateway-integration:swagger, какие параметры оно поддерживает, как выглядит его спецификация.
---

# Расширение x-yc-apigateway-integration:swagger

Расширение Swagger UI позволяет пользователю получать интерактивную документацию, а также тестировать и отлаживать API в интерфейсе Swagger UI.

{% include [add-extentions-console](../../../_includes/api-gateway/add-extentions-console.md) %}

## Спецификация расширения {#spec}

Пример спецификации:

```yaml
openapi: "3.0.0"
info:
  version: 1.0.0
  title: Sample API
paths:
  /docs:
    get:
      x-yc-apigateway-integration:
        type: swagger
```

При добавлении ресурса `/docs` с интеграцией Swagger UI в OpenAPI-спецификацию пользователь получит доступ к интерфейсу Swagger UI по адресу `/docs`.

[Авторизация](../index.md#authorization) и все политики доступа будут применены автоматически, так как `/docs` — это полноценный эндпоинт в рамках {{ api-gw-name }}.