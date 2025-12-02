---
title: x-yc-apigateway-integration:swagger extension
description: In this article, you will learn about the `x-yc-apigateway-integration:swagger` extension use cases, supported parameters, and specification.
---

# x-yc-apigateway-integration:swagger extension

With Swagger UI, you can access interactive documents, test and debug your API from the Swagger UI interface.

{% include [add-extentions-console](../../../_includes/api-gateway/add-extentions-console.md) %}

## Extension specification {#spec}

Specification example:

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

By adding the `/docs` resource with Swagger UI integration to the OpenAPI specification, you will get access to the Swagger UI interface at `/docs`.

The [authorization](../index.md#authorization) and all access policies will apply automatically, because `/docs` is a full-blown endpoint under {{ api-gw-name }}.