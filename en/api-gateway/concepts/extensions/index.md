---
title: "Extensions of the {{ api-gw-name }} specification. Overview"
description: "The x-yc-apigateway extension allows you to set top-level API gateway parameters whose values will be inherited by nested extensions. The x-yc-apigateway-integration extension is the entry point for integrating the API gateway with other services."
---

# {{ api-gw-name }} specification extensions. Overview

## x-yc-apigateway extension {#top-level}

The `x-yc-apigateway` extension allows you to set top-level API gateway parameters whose values will be inherited by nested extensions.

### Supported parameters {#parameters}

{% include [param-table](../../../_includes/api-gateway/parameters-table.md) %}

| Parameter | Type | Description |
----------------------|-------------------|---------------------------------------------------------------------------------------------------------------------------------------------------
| `service_account_id` | `string` | ID of the [service account](../../../iam/concepts/users/service-accounts.md) on behalf of which the API gateway will perform operations. |
| `validator` | `ValidatorObject` | [HTTP request and response validator](validator.md#validator_object) or a link to it. It can be overridden at the level of a specific operation. |
| `cors` | `CorsRuleObject` | [Rule for handling CORS preflight requests](cors.md#corsrule_object) or a link to it. It can be overridden at the level of a specific path. |
| `rateLimit` | `RateLimitObject` | [Request rate limit](rate-limit.md#rate_limit_object) or a link to it. It can be overridden at the level of a specific path and/or operation. |

### Extension specification {#tl-spec}

```yaml
x-yc-apigateway:
  service_account_id: <service account ID>
  validator: <ValidatorObject or a link to it>
  cors: <CorsRuleObject or a link to it>
  rateLimit: <RateLimitObject or a link to it>
```

## x-yc-apigateway-integration extension {#integration}

The `x-yc-apigateway-integration` extension is the entry point for integrating the API gateway with other services.

### Supported parameters {#parameters}

{% include [param-table](../../../_includes/api-gateway/parameters-table.md) %}

| Parameter | Type | Description |
----|----|----
| `type` | `string` | Extension type. Acceptable values: `dummy`, `cloud_functions`, `http`, `object_storage`, `cloud_datasphere`, `cloud_datastreams`, `serverless_containers`, `cloud_ymq`, and `cloud_ydb`. |

### Extension specification {#intg-spec}

```
<Request>:
  <Method>:
    x-yc-apigateway-integration:
      type: <Type>
      <List of parameters as key:value pairs>
```

The extension's content changes depending on the `type` specified in the `x-yc-apigateway-integration` section:
* [dummy](dummy.md): Returns fixed content with the specified response code and required headers without any third-party service involved.
* [cloud-functions](cloud-functions.md): Invokes the specified function, passes it the HTTP request data as input, and returns this function's results to the client.
* [http](http.md): Redirects the request to the specified URL.
* [object_storage](object-storage.md): Passes request handling control to {{ objstorage-name }} to share static files.
* [cloud_datasphere](datasphere.md): Calls the specified {{ ml-platform-name }} node, passing it the request body with input variable values and returning the node output in the response body.
* [cloud_datastreams](datastreams.md): Accesses {{ yds-full-name }} to perform an operation with the specified stream.
* [serverless_containers](containers.md): Redirects a request to a specified container.
* [cloud_ymq](ymq.md): Accesses {{ message-queue-full-name }} to perform an operation with the specified queue.
* [cloud_ydb](ydb.md): Accesses {{ ydb-full-name }} to perform an operation with the specified [document tables](../../../ydb/concepts/dynamodb-tables.md).

All types support parameter substitution when all keys are replaced with the appropriate value. A key should be defined as a parameter of the corresponding operation (all types of parameters defined in the [OpenAPI-Specification](https://github.com/OAI/OpenAPI-Specification) are allowed: `path`, `query`, `header`, and `cookie`).


Parameters are only substituted in some values, depending on the type of extension.

## Components:x-yc-apigateway-integrations extension

The `x-yc-apigateway-integrations` extension allows you to specify the appropriate integration in the [components](https://github.com/OAI/OpenAPI-Specification/blob/main/versions/3.1.0.md#components-object) section. You can refer to these integrations using the `$ref` parameter in the `x-yc-apigateway-integration` extension.

### Extension specification

Sample extension specification:
```yaml
openapi: 3.0.0
info:
  title: Sample API
  version: 1.0.0

x-yc-apigateway:
  variables:
    handler:
      default: "#/components/x-yc-apigateway-integrations/BaseGetDefault"
      enum:
        - "#/components/x-yc-apigateway-integrations/BaseGetDefault"
        - "#/components/x-yc-apigateway-integrations/BaseGetUnimplemented"

paths:
  /:
    get:
      x-yc-apigateway-integration:
        $ref: "${var.handler}"

components:
  x-yc-apigateway-integrations:
    BaseGetDefault:
      type: cloud_functions
      function_id: b095c95icnvbuf4v755l
      tag: "$latest"
      service_account_id: ajehfe84hhlaq4n59q1
    BaseGetUnimplemented:
      type: dummy
      content:
        '*': Sorry, endpoint is not implemented yet.
      http_code: 501
      http_headers:
        Content-Type: text/plain
```
