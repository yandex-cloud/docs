---
title: Extensions of the {{ api-gw-name }} specification. Overview
description: The x-yc-apigateway extension allows you to set parent API gateway parameters whose values will be inherited by child extensions. The x-yc-apigateway-integration extension is the entry point for integrating the API gateway with other services.
---

# {{ api-gw-name }} specification extensions. Overview

## x-yc-apigateway extension {#top-level}

The `x-yc-apigateway` extension allows you to set parent API gateway parameters whose values will be inherited by child extensions.

### Supported parameters {#parameters}

{% include [param-table](../../../_includes/api-gateway/parameters-table.md) %}

| Parameter | Type | Description |
-------------------------|-------------------|---------------------------------------------------------------------------------------------------------------------------------------------------
| `serviceAccountId` | `string` | ID of the [service account](../../../iam/concepts/users/service-accounts.md) on behalf of which the API gateway will perform operations. |
| `validator` | `ValidatorObject` | [HTTP request and response validator](validator.md#validator_object) or a link to it. It can be overridden at the level of a specific operation. |
| `cors` | `CorsRuleObject` | [Rule for handling CORS preflight requests](cors.md#corsrule_object) or a link to it. It can be overridden at the level of a specific path. |
| `rateLimit` | `RateLimitObject` | [Request rate limit](rate-limit.md#rate_limit_object) or a link to it. It can be overridden at the level of a specific path or operation. |
| `ignoreTrailingSlashes` | `boolean` | If `true`, {{ api-gw-name }} ignores the trailing slash (`/`) in the request URL; otherwise, it uses the exact URL path to search for a handler in the OpenAPI specification. The default value is `true`. |
| `securityProfileId` | `string` | {{ sws-name }} [security profile](../../../smartwebsecurity/concepts/profiles.md) ID |

### Extension specification {#tl-spec}

```yaml
x-yc-apigateway:
  service_account_id: <service_account_ID>
  validator: <ValidatorObject_or_link_to_it>
  cors: <CorsRuleObject_or_link_to_it>
  rateLimit: <RateLimitObject_or_link_to_it>
  ignoreTrailingSlashes: <true_or_false>
  smartWebSecurity:
    securityProfileId: <security_profile_ID>
```

## x-yc-apigateway-integration extension {#integration}

The `x-yc-apigateway-integration` extension is the entry point for integrating the API gateway with other services.

### Supported parameters {#parameters}

{% include [param-table](../../../_includes/api-gateway/parameters-table.md) %}

| Parameter | Type | Description |
----|----|----
| `type` | `string` | Extension type. The available values are `dummy`, `cloud_functions`, `http`, `object_storage`, `cloud_datasphere`, `cloud_datastreams`, `serverless_containers`, `cloud_ymq`, and `cloud_ydb`. |

### Extension specification {#intg-spec}

```
<request>:
  <method>:
    x-yc-apigateway-integration:
      type: <type>
      <list_of_parameters_as_key:value_pairs>
```

The extension content changes depending on the `type` specified in the `x-yc-apigateway-integration` section:
* [dummy](dummy.md): Returns fixed content with the specified response code and required headers without any third-party service involved.
* [cloud-functions](cloud-functions.md): Invokes the specified function, provides it with the HTTP request data as input, and returns this function's results to the client.
* [http](http.md): Redirects the request to the specified URL.
* [object_storage](object-storage.md): Hands the request handling over to {{ objstorage-name }} to distribute static files.
* [cloud_datasphere](datasphere.md): Invokes the specified {{ ml-platform-name }} node, provides it with the request body with input variable values, and returns the node output in the response body.
* [cloud_datastreams](datastreams.md): Accesses {{ yds-full-name }} to perform an operation with the specified stream.
* [serverless_containers](containers.md): Redirects a request to a specified container.
* [cloud_ymq](ymq.md): Accesses {{ message-queue-full-name }} to perform an operation with the specified queue.
* [cloud_ydb](ydb.md): Accesses {{ ydb-full-name }} to perform an operation with the specified [document table](../../../ydb/concepts/dynamodb-tables.md).

All types support parameter substitution with all keys being replaced with the appropriate value. A key should be defined as a parameter of the relevant operation. All parameter types defined in the [OpenAPI-Specification](https://github.com/OAI/OpenAPI-Specification), such as `path`, `query`, `header`, and `cookie`, are allowed.
Parameters are only substituted in certain values, depending on the extension type.

## Components:x-yc-apigateway-integrations extension {#integrations}

The `x-yc-apigateway-integrations` extension allows you to specify the appropriate integration in the [components](https://github.com/OAI/OpenAPI-Specification/blob/main/versions/3.1.0.md#components-object) section. You can reference these integrations using the `$ref` parameter in the `x-yc-apigateway-integration` extension.

### Extension specification {#intg-spec}

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
      function_id: b095c95icnvb********
      tag: "$latest"
      service_account_id: ajehfe84hhl********
    BaseGetUnimplemented:
      type: dummy
      content:
        '*': Sorry, endpoint is not implemented yet.
      http_code: 501
      http_headers:
        Content-Type: text/plain
```

## x-yc-status-mapping extension {#status-mapping}

The [x-yc-status-mapping](status-mapping.md) extensions allows you to replace a response code in an integration.

### Extension specification {#status-mapping-spec}

```json
paths:
  /:
    <method>:
      responses:
        <response_code>:
          description: ""
          content:
            ...
          x-yc-status-mapping: <new_response_code>
      ...
```

## x-yc-schema-mapping extension {#schema-mapping}

The [x-yc-schema-mapping](schema-mapping.md) extension allows you to transform the JSON body of a request to an integration or response from it.

### Extension specification {#schema-mapping-spec}

```json
x-yc-schema-mapping:
 type:static
 template:
   <field_name>: "<field_value>"
   ...
```
